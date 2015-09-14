class Task < ActiveRecord::Base
  belongs_to :requester, :class_name=>"User"
  belongs_to :assignee, :class_name=>"User"
  
  #after_save :set_priorities

  # scope :grouped, group(:assignee_id)


  def self.all_active
    find(:all, :order =>"assignee_id, priority", :conditions => ["complete = ?",false])
  end
  def self.all_unassigned
    date=Date.today
    find(:all, :order =>"id" , :conditions => "assignee_id IS NULL")
  end
  def self.all_active2
    t = self.where("tasks.complete = 'f' AND tasks.assignee_id IS NOT NULL AND category < '5'").order("users.fullname, tasks.priority").joins('INNER JOIN users ON users.id = tasks.assignee_id').select('users.fullname, tasks.*').includes("requester").includes("assignee")
    t.group_by(&:fullname)
  end
  def self.topActive( priority )
    t = self.where("tasks.priority < ? AND tasks.complete = 'f' AND tasks.assignee_id IS NOT NULL AND category < '5'", priority ).order("users.fullname, tasks.priority").joins('INNER JOIN users ON users.id = tasks.assignee_id').select('users.fullname, tasks.*').includes("requester").includes("assignee")
    #t.group_by(&:fullname)
  end
  def self.topActiveSerial( priority )
    t = self.where("tasks.family IN ('2W','SPI', '3W') AND tasks.priority < ? AND tasks.complete = 'f' AND tasks.assignee_id IS NOT NULL AND category < '5'", priority ).order("users.fullname, tasks.priority").joins('INNER JOIN users ON users.id = tasks.assignee_id').select('users.fullname, tasks.*').includes("requester").includes("assignee")
    #t.group_by(&:fullname)
  end
  def self.all_active_by_requester
    t = self.where("tasks.accepted = 'f' OR tasks.accepted IS NULL AND tasks.requester_id IS NOT NULL").order("users.fullname, tasks.id").joins('INNER JOIN users ON users.id = tasks.requester_id').select('users.fullname, tasks.*').includes("requester").includes("assignee")
    t.group_by(&:fullname)
  end
  def self.all_active_manual_sort(id)
    t = self.where("tasks.complete = 'f' AND tasks.assignee_id = ?", id).order("users.fullname, tasks.priority").joins('INNER JOIN users ON users.id = tasks.assignee_id').select('users.fullname, tasks.*')
  end
  
  def self.categoryCount(category)
    t = self.where("tasks.complete = 'f' AND tasks.assignee_id IS NOT NULL AND category = ?",category).order("tasks.assignee_id").select('tasks.assignee_id').group('assignee_id').count
    t.default = 0
    t
  end
  
  def self.all_for_id(id)
    self.where("tasks.assignee_id = ? AND (tasks.complete = 'f' OR tasks.complete IS NULL)" , id).select("tasks.*")
  end
  
  def self.recent(days)
    date = Date.today - days
    self.where("tasks.complete = 'f' OR (tasks.complete = 't' AND tasks.updated_at > ?)", date).select("tasks.*").order( "tasks.complete DESC, tasks.id")
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
end
