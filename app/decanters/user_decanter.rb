class UserDecanter < Decanter::Base
  input :email
  input :name
  input :age, :integer
end
