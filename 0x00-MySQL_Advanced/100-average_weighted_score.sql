-- Docs
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_score FLOAT;
    DECLARE total_weight FLOAT;

    -- Calculate the weighted average
    SELECT COALESCE(SUM(score * weight), 0) INTO total_score,
           COALESCE(SUM(weight), 0) INTO total_weight
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;

    -- Update the average_score in the users table
    IF total_weight > 0 THEN
        UPDATE users
        SET average_score = total_score / total_weight
        WHERE id = user_id;
    ELSE
        -- Handle the case when total_weight is 0 to avoid division by zero
        UPDATE users
        SET average_score = 0
        WHERE id = user_id;
    END IF;
END //
DELIMITER ;
