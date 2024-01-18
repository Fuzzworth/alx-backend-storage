-- Docs
DELIMITER //
CREATE PROCEDURE ComputeAverageScoreForUser(
    IN p_user_id INT
)
BEGIN
    DECLARE v_total_score FLOAT;
    DECLARE v_total_projects INT;

    -- Calculate the total score and total projects for the user
    SELECT SUM(score), COUNT(DISTINCT project_id)
    INTO v_total_score, v_total_projects
    FROM corrections
    WHERE user_id = p_user_id;

    -- Update the average score for the user
    UPDATE users
    SET average_score = IFNULL(v_total_score / NULLIF(v_total_projects, 0), 0)
    WHERE id = p_user_id;
END //
DELIMITER ;
