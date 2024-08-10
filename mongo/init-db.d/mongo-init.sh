mongosh <<EOF
use admin;
db.auth('admin-user', 'admin-password');
use contacts-system;
db.createUser({
  user: "contacts-user",
  pwd: "contacts-password",
  roles: [{ role: "readWrite", db: "contacts-system" }]
});
EOF

