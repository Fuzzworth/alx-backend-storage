-- Docs
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE weighted_avg FLOAT;

    -- Calculate the weighted average score
    SELECT SUM(C.score * P.weight) / COALESCE(NULLIF(SUM(P.weight), 0), 1)
    INTO weighted_avg
    FROM users AS U
    JOIN corrections AS C ON U.id = C.user_id
    JOIN projects AS P ON C.project_id = P.id
    WHERE U.id = user_id;

    -- Update the average_score in the users table
    UPDATE users SET average_score = COALESCE(weighted_avg, 0) WHERE id = user_id;
END //
DELIMITER ;
