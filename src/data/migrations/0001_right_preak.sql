PRAGMA foreign_keys=OFF;--> statement-breakpoint
CREATE TABLE `__new_tasks` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`project_id` integer NOT NULL,
	`title` text NOT NULL,
	`description` text DEFAULT '' NOT NULL,
	`status` text DEFAULT 'todo' NOT NULL,
	`created_at` text NOT NULL,
	`updated_at` text NOT NULL,
	FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON UPDATE no action ON DELETE cascade,
	CONSTRAINT "tasks_status_check" CHECK("__new_tasks"."status" IN ('todo', 'in_progress', 'done'))
);
--> statement-breakpoint
INSERT INTO `__new_tasks`("id", "project_id", "title", "description", "status", "created_at", "updated_at") SELECT "id", "project_id", "title", "description", "status", "created_at", "updated_at" FROM `tasks`;--> statement-breakpoint
DROP TABLE `tasks`;--> statement-breakpoint
ALTER TABLE `__new_tasks` RENAME TO `tasks`;--> statement-breakpoint
PRAGMA foreign_keys=ON;--> statement-breakpoint
CREATE INDEX `idx_tasks_project_id` ON `tasks` (`project_id`);