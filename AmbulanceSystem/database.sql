CREATE TABLE IF NOT EXISTS ambulance_revives (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    target_id INT NOT NULL,
    revive_time DATETIME NOT NULL,
    FOREIGN KEY (player_id) REFERENCES users(identifier),
    FOREIGN KEY (target_id) REFERENCES users(identifier)
);

INSERT INTO ambulance_revives (player_id, target_id, revive_time) VALUES (1, 1, NOW());