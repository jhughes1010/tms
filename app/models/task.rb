class Task < ActiveRecord::Base
  belongs_to :requester, :class_name=>"User"
  belongs_to :assignee, :class_name=>"User"
  
  #after_save :set_priorities

  scope :active, -> {where ("tasks.complete = 'f' OR tasks.complete IS NULL")}
  scope :serial, -> {where ("tasks.family IN ('2W', 'SPI', '3W')")}
  scope :crypto, -> {where ("tasks.family IN ('Crypto')")}


  def self.all_active
    #find(:all, :order =>"assignee_id, priority", :conditions => ["complete = ?",false])
    self.active
      .order("assignee_id, priority")
  end
  
  def self.all_unassigned
    date=Date.today
    #find(:all, :order =>"id" , :conditions => "assignee_id IS NULL")
    self.where("assignee_id IS NULL")
      .order("id")
  end
  
  def self.all_active2
    t = self.active
      .where("tasks.assignee_id IS NOT NULL AND category < '5'")
      .joins('INNER JOIN users ON users.id = tasks.assignee_id')
      .order("users.fullname, tasks.priority")
      .select('users.*, tasks.*')
      .includes("requester")
      .includes("assignee")
    t.group_by(&:fullname)
  end

  def self.all_active2_90
    date = Date.today.next_day(89)
    t = self.active
      .where("tasks.assignee_id IS NOT NULL AND category < '5' and tasks.scd < ?", date)
      .joins('INNER JOIN users ON users.id = tasks.assignee_id')
      .order("users.fullname, tasks.priority")
      .select('users.*, tasks.*')
      .includes("requester")
      .includes("assignee")
    t.group_by(&:fullname)
  end
  
  
  def self.topActiveCrypto( priority )
    t = self.crypto
      .active
      .where("tasks.priority < ? AND tasks.assignee_id IS NOT NULL AND category < '5'", priority )
      .joins('INNER JOIN users ON users.id = tasks.assignee_id')
      .order("users.fullname, tasks.priority")
      .select('users.fullname, tasks.*')
      .includes("requester")
      .includes("assignee")
  end
  
  def self.topActiveSerial( priority )
    t = self.serial
      .active
      .where("tasks.priority < ? AND tasks.assignee_id IS NOT NULL AND category < '5'", priority )
      .joins('INNER JOIN users ON users.id = tasks.assignee_id')
      .order("users.fullname, tasks.priority")
      .select('users.fullname, tasks.*')
      .includes("requester")
      .includes("assignee")
  end
  
  def self.all_active_by_requester
    t = self.where("tasks.accepted = 'f' OR tasks.accepted IS NULL AND tasks.requester_id IS NOT NULL")
      .joins('INNER JOIN users ON users.id = tasks.requester_id')
      .order("users.fullname, tasks.accepted, tasks.id")
      .select('users.fullname, tasks.*')
      .includes("requester")
      .includes("assignee")
    t.group_by(&:fullname)
  end
  
  def self.all_active_manual_sort(id)
    t = self.active
      .where("tasks.assignee_id = ?", id)
      .joins('INNER JOIN users ON users.id = tasks.assignee_id')
      .order("users.fullname, tasks.priority")
      .select('users.fullname, tasks.*')
  end
  
  def self.all_active_requested_by(id)
    t = self.where("tasks.accepted = 'f' AND tasks.complete = 't' AND tasks.requester_id = ?", id)
      .joins('INNER JOIN users ON users.id = tasks.assignee_id')
      .order("users.fullname, tasks.priority")
      .select('users.fullname, tasks.*')
  end

  def self.categoryCount(category)
    t = self.active
      .where("tasks.assignee_id IS NOT NULL AND category = ?",category)
      .order("tasks.assignee_id")
      .select('tasks.assignee_id')
      .group('assignee_id').count
    t.default = 0
    t
  end  
  def self.categoryCount90(category)
    date = Date.today.next_day(89)
    t = self.active
      .where("tasks.assignee_id IS NOT NULL AND category = ? and scd < ?",category, date)
      .order("tasks.assignee_id")
      .select('tasks.assignee_id')
      .group('assignee_id').count
    t.default = 0
    t
  end
  #current usage - unassigned tasks
  def self.all_for_id(id)
    self.active
      .where("tasks.assignee_id = ?" , id)
      .select("tasks.*")
  end
  
  def self.recent(days)
    date = Date.today - days
    self.where("tasks.complete = 'f' OR (tasks.complete = 't' AND tasks.updated_at > ?) OR tasks.accepted = 'f'", date)
      .order( "tasks.complete DESC, tasks.accepted DESC, tasks.family ,tasks.id")
      .select("tasks.*")
  end
  #this method is for cleanup of stale records in 'review limbo'
  def self.completenotaccepted(days)
    date = Date.today - days
    tasks = self.where("tasks.complete = 't' AND tasks.accepted != 't' AND tasks.updated_at < ?", date)
      .order( "tasks.id")
      .select("tasks.*")
    tasks.each do |t|
      #update record
      t.accepted = 't'
      t.save
    end
  end

  def set_priorities
    #Can I refer to PriorityController
    #unless @auth == 1
      @te = User.get_te
      @tsk = Task.all_active2
      #Spread out priority numbers
      @tsk.each_pair do |assignee_id, tasks|
        priority=0
        ##first_record_flag = 1
        #get scd and duration for first entry for date completion estimates
        date_complete = Date.today
        tasks.each do |t|
          #update record
          t.duration = 0 if t.duration.nil?
          duration = t.duration*7
          t.scd = date_complete.next_day( duration )
          t.priority=priority
          t.save
          #update variables for next record
          date_complete = t.scd
          priority = t.priority
          priority +=1
        end
      end
    end
    #end
    def self.as_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |task|
          csv << task.attributes.values_at(*column_names)
        end
      end
    end
    def self.gerald(userID)
      tasks=self.where("assignee_id = ? and priority > 7 and complete !='t'",userID)
      tasks.each do |t|
        t.assignee_id=24
        t.save
      end
      
    end
end
