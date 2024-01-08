-- Enable RLS
ALTER TABLE my_table FORCE ROW LEVEL SECURITY;

-- Admin Policy
CREATE POLICY admin_policy ON my_table
FOR ALL
USING (current_role = 'admin');

-- Manager Policy
CREATE POLICY manager_policy ON my_table
FOR SELECT, INSERT, UPDATE
USING (current_role = 'manager' AND department_id = current_department_id());

-- Employee Policy
CREATE POLICY employee_policy ON my_table
FOR SELECT
USING (current_role = 'employee' AND user_id = current_user_id());