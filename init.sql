--------------------------------------------
-- PROVISIONING
--------------------------------------------
CREATE USER db_user PASSWORD 'postgres';

-- use conservative default privileges
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON DATABASE postgres FROM PUBLIC;

-- selectively grant privileges for the application user
-- basically, the app user can read and write data values, but it cannot alter the schema
GRANT CONNECT ON DATABASE postgres TO db_user;
GRANT USAGE ON SCHEMA public TO db_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO db_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO db_user;


--------------------------------------------
-- SCHEMA MIGRATIONS
--------------------------------------------
CREATE TABLE IF NOT EXISTS tenants (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    tenant_id UUID NOT NULL REFERENCES tenants(id)
);


ALTER TABLE tenants ENABLE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON tenants
FOR ALL
TO PUBLIC
USING (current_setting('app.current_tenant_id')::UUID = id);

ALTER TABLE items ENABLE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON items
FOR ALL
TO PUBLIC
USING (current_setting('app.current_tenant_id')::UUID = tenant_id);


--------------------------------------------
-- SEED DATA
--------------------------------------------
INSERT INTO tenants (id, name) VALUES 
('7a245486-3fc8-47ec-b303-04fefe7a58ff', 'pawnee-parks-and-rec'),
('162be16f-f76d-431a-a213-171838ded9ae', 'dunder-mifflin'),
('ebdba44d-ad48-4e73-9bd5-339e3c3fc590', 'aliki-farms');

INSERT INTO items (title, tenant_id) VALUES 
('apple',    'ebdba44d-ad48-4e73-9bd5-339e3c3fc590'),
('banana',   'ebdba44d-ad48-4e73-9bd5-339e3c3fc590'),
('cherry',   'ebdba44d-ad48-4e73-9bd5-339e3c3fc590'),
('durian',   'ebdba44d-ad48-4e73-9bd5-339e3c3fc590'),
('eggplant', 'ebdba44d-ad48-4e73-9bd5-339e3c3fc590'),

('a4 paper',   '162be16f-f76d-431a-a213-171838ded9ae'),
('binder',     '162be16f-f76d-431a-a213-171838ded9ae'),
('calculator', '162be16f-f76d-431a-a213-171838ded9ae'),
('desk',       '162be16f-f76d-431a-a213-171838ded9ae'),
('envelopes',  '162be16f-f76d-431a-a213-171838ded9ae'),

('art-fair',          '7a245486-3fc8-47ec-b303-04fefe7a58ff'),
('bench',             '7a245486-3fc8-47ec-b303-04fefe7a58ff'),
('concert',           '7a245486-3fc8-47ec-b303-04fefe7a58ff'),
('drinking-fountain', '7a245486-3fc8-47ec-b303-04fefe7a58ff'),
('emergency-kit',     '7a245486-3fc8-47ec-b303-04fefe7a58ff');
