CREATE TABLE "products" (
  "id" SERIAL PRIMARY KEY,
  "category_id" integer NOT NULL ,
  "user_id" integer ,
  "name" text NOT NULL,
  "description" text NOT NULL,
  "old_price" integer,
  "price" integer NOT NULL,
  "quantity" integer DEFAULT 0,
  "status" integer DEFAULT 1,
  "created_at" timestamp DEFAULT (now()),
  "update_at" timestamp DEFAULT (now())
);

CREATE TABLE "categories" (
  "id" SERIAL PRIMARY KEY,
  "name" text NOT NULL
);

CREATE TABLE "files" (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "path" text NOT NULL,
  "product_id" integer 
);

ALTER TABLE "products" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "files" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

CREATE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
NEW.updated_at = NOW();
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON products
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();