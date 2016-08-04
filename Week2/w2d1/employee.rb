class Employee

  attr_reader :salary

  def initialize(name,title,salary,boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end





end


class Manager < Employee
  def initialize(name,title,salary,boss, employees)
    @employees = employees
    super(name,title,salary,boss)
  end

  def bonus(multiplier)
    total_salary = @employees.inject(0) do |sum,employee|
      sum += employee.salary
    end
    total_salary * multiplier
  end

end


david = Employee.new("David","TA",10000,"Darren")
shawna = Employee.new("Shawna","TA",12000,"Darren")
darren = Manager.new("Darren","TA Manager",78000,"Ned",[shawna, david])

ned = Manager.new("Ned","Founder",1000000,nil,[david,shawna,darren])

p david.bonus(3)
