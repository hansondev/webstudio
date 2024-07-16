#!/bin/sh

HOST="$1"
PORT="$2"
shift 2
CMD="$@"

until nc -z "$HOST" "$PORT"; do
  >&2 echo "Waiting for $HOST:$PORT to be available..."
  sleep 2
done

>&2 echo "$HOST:$PORT is available. Running command: $CMD"
exec $CMD