-- Docs
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_score FLOAT;
    DECLARE total_weight FLOAT;

    -- Calculate the weighted average
    SELECT SUM(score * weight) INTO total_score, SUM(weight) INTO total_weight
    FROM corrections
    WHERE user_id = user_id;

    -- Update the average_weighted_score in the users table
    IF total_weight > 0 THEN
        UPDATE users
        SET average_weighted_score = total_score / total_weight
        WHERE id = user_id;
    ELSE
        -- Handle the case when total_weight is 0 to avoid division by zero
        UPDATE users
        SET average_weighted_score = 0
        WHERE id = user_id;
    END IF;
END //
DELIMITER ;
