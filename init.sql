CREATE TABLE IF NOT EXISTS tenants (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    tenant_id UUID NOT NULL REFERENCES tenants(id)
);

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
