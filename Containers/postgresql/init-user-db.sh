#!/bin/bash
/**
 * SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

set -ex

touch "$DUMP_DIR/initialization.failed"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER "oc_$POSTGRES_USER" WITH PASSWORD '$POSTGRES_PASSWORD' CREATEDB;
	ALTER DATABASE "$POSTGRES_DB" OWNER TO "oc_$POSTGRES_USER";
	GRANT ALL PRIVILEGES ON DATABASE "$POSTGRES_DB" TO "oc_$POSTGRES_USER";
	GRANT ALL PRIVILEGES ON SCHEMA public TO "oc_$POSTGRES_USER";
EOSQL

rm "$DUMP_DIR/initialization.failed"

set +ex
