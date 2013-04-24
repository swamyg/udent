class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :course_description
      t.string :availability
      t.string :prerequiste

      t.timestamps
    end
  end
end
