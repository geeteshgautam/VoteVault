-- Table to store voter details
CREATE TABLE voters (
    voter_id INT AUTO_INCREMENT PRIMARY KEY,
    voter_name VARCHAR(100) NOT NULL,
    voter_email VARCHAR(100) UNIQUE NOT NULL,
    voter_password VARCHAR(255) NOT NULL,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table to manage OTP-based login
CREATE TABLE otp_verification (
    otp_id INT AUTO_INCREMENT PRIMARY KEY,
    voter_id INT NOT NULL,
    otp_code INT NOT NULL,
    is_valid BOOLEAN DEFAULT TRUE,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (voter_id) REFERENCES voters(voter_id)
);

-- Table to store candidates
CREATE TABLE candidates (
    candidate_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_name VARCHAR(100) NOT NULL,
    party_name VARCHAR(100) NOT NULL,
    election_region VARCHAR(100) NOT NULL
);

-- Table to record votes
CREATE TABLE votes (
    vote_id INT AUTO_INCREMENT PRIMARY KEY,
    voter_id INT NOT NULL,
    candidate_id INT NOT NULL,
    voted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (voter_id) REFERENCES voters(voter_id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id)
);

-- Table to track election results
CREATE TABLE results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    total_votes INT DEFAULT 0,
    FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id)
);


-- Insert new voter
INSERT INTO voters (voter_name, voter_email, voter_password)
VALUES ('John Doe', 'john.doe@example.com', SHA2('password123', 256)); -- Password hashing for security

-- Insert OTP for login
INSERT INTO otp_verification (voter_id, otp_code)
VALUES (1, FLOOR(100000 + (RAND() * 899999))); -- Generates a random 6-digit OTP

-- Validate OTP
SELECT otp_code
FROM otp_verification
WHERE voter_id = 1 AND otp_code = 123456 AND is_valid = TRUE
AND TIMESTAMPDIFF(MINUTE, generated_at, CURRENT_TIMESTAMP) <= 10; -- OTP valid for 10 minutes

-- Record a vote
INSERT INTO votes (voter_id, candidate_id)
VALUES (1, 2); -- Voter ID: 1, Candidate ID: 2

-- Update results
UPDATE results
SET total_votes = total_votes + 1
WHERE candidate_id = 2;

-- Fetch real-time results
SELECT c.candidate_name, c.party_name, r.total_votes
FROM results r
JOIN candidates c ON r.candidate_id = c.candidate_id
ORDER BY r.total_votes DESC;

-- Insert candidates
INSERT INTO candidates (candidate_name, party_name, election_region)
VALUES 
('Alice Johnson', 'Democratic Party', 'Region 1'),
('Bob Smith', 'Republican Party', 'Region 1');

-- Initialize results for candidates
INSERT INTO results (candidate_id, total_votes)
VALUES 
(1, 0),
(2, 0);

