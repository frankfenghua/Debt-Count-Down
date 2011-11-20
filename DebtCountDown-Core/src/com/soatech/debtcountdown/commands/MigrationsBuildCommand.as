package com.soatech.debtcountdown.commands
{
	import com.soatech.debtcountdown.db.Migration;
	import com.soatech.debtcountdown.db.Migrator;
	import com.soatech.debtcountdown.events.MigrationEvent;
	import com.soatech.debtcountdown.models.DataBaseProxy;
	
	import org.robotlegs.mvcs.Command;
	
	public class MigrationsBuildCommand extends Command
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var event:MigrationEvent;
		
		[Inject]
		public var dbProxy:DataBaseProxy;

		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */
		override public function execute():void
		{
			var list:Vector.<Migration> = new Vector.<Migration>();
			var migration:Migration;
			var version:int = 1;
			var migrator:Migrator;
			
			// 1
			
			migration = new Migration();
			migration.version = version;
			migration.upList = new Vector.<String>();
			migration.upList.push("CREATE TABLE schemaVersion (currentVersion integer)");
			migration.upList.push("INSERT INTO schemaVersion (currentVersion) VALUES (1)");
			
			list.push(migration);
			
			version++;
			
			// 2
			
			migration = new Migration();
			migration.version = version;
			migration.upList = new Vector.<String>();
			migration.upList.push("CREATE TABLE plans (pid INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"expenses REAL, income REAL, name TEXT, startDate TEXT)");
			migration.upList.push("CREATE TABLE debts (pid INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"planId INTEGER, name TEXT, bank TEXT, balance REAL, apr REAL, " +
				"dueDate TEXT, minPayment REAL, FOREIGN KEY(planId) REFERENCES plans(pid))");
			migration.upList.push("CREATE INDEX debts_planId ON debts (planId)");
			
			list.push(migration);
			
			version++;
			
			//3 
			
			migration = new Migration();
			migration.version = version;
			migration.upList = new Vector.<String>();
			migration.upList.push("CREATE TABLE planDebts (pid INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"planId integer, debtId integer, " +
				"FOREIGN KEY(planId) REFERENCES plans(pid), " +
				"FOREIGN KEY(debtId) REFERENCES debts(pid) )");
			migration.upList.push("CREATE INDEX planDebt_planId_debtId ON planDebts (planId, debtId)");
			// migrate the data
			migration.upList.push("INSERT INTO planDebts (planId, debtId) SELECT planId, pid FROM debts");
			migration.upList.push("CREATE TEMPORARY TABLE debts_backup(pid integer, " +
				"name text, bank text, balance real, apr real, dueDate text, " +
				"minPayment real)");
			migration.upList.push("INSERT INTO debts_backup SELECT pid, name, " +
				"bank, balance, apr, dueDate, minPayment FROM debts");
			// convoluted way to drop a column in sqlite
			migration.upList.push("DROP TABLE debts");
			migration.upList.push("CREATE TABLE debts (pid INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"name TEXT, bank TEXT, balance REAL, apr REAL, dueDate TEXT, " +
				"minPayment REAL)");
			migration.upList.push("INSERT INTO debts SELECT pid, name, bank, balance, apr, dueDate, minPayment FROM debts_backup");
			migration.upList.push("DROP TABLE debts_backup");
			
			
			list.push(migration);
			
			version++;

			//4 - Add paymentRate column 
			migration = new Migration();
			migration.version = version;
			migration.upList = new Vector.<String>();
			migration.upList.push("ALTER TABLE debts ADD COLUMN paymentRate real NOT NULL DEFAULT 0.0");
			
			list.push(migration);
			
			version++;

			//5 - Calculate payment rates on old data 
			migration = new Migration();
			migration.version = version;
			migration.upList = new Vector.<String>();
			migration.upList.push("UPDATE debts SET paymentRate = minPayment / balance");
			
			list.push(migration);
			
			version++;

			//5 - Create budget items and frequencies 
			migration = new Migration();
			migration.version = version;
			migration.upList = new Vector.<String>();
			/*migration.upList.push("CREATE TABLE frequences (pid INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"type TEXT, dateInfo TEXT, dateInfo2 TEXT");
			migration.upList("INSERT INTO frequences (type");*/
			migration.upList.push("CREATE TABLE budgetItems (pid INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"name TEXT, amount REAL, active INTEGER, type TEXT)");
			migration.upList.push("CREATE TABLE planBudgetItems (pid INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"planId integer, budgetItemId integer, " +
				"FOREIGN KEY(planId) REFERENCES plans(pid), " +
				"FOREIGN KEY(budgetItemId) REFERENCES budgetItems(pid) )");
			migration.upList.push("CREATE INDEX planBudgetItem_planId_budgetItemId ON planBudgetItems (planId, budgetItemId)");
			
			list.push(migration);
			
			version++;
			
			dbProxy.applicationMigrations = list;
		}
	}
}