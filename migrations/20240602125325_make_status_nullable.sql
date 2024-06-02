-- Add migration script here
BEGIN;
ALTER TABLE subscriptions ALTER COLUMN status DROP NOT NULL;
END
