-- Docs
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE user_id INT;

    -- Declare a cursor to iterate over user_ids
    DECLARE user_cursor CURSOR FOR
        SELECT id FROM users;

    -- Declare variables for user-specific weighted average calculation
    DECLARE weighted_avg FLOAT;

    -- Open the cursor
    OPEN user_cursor;

    -- Start looping through user_ids
    user_loop: LOOP
        FETCH user_cursor INTO user_id;

        -- Exit loop if no more users
        IF user_id IS NULL THEN
            LEAVE user_loop;
        END IF;

        -- Calculate the weighted average score for the current user
        SELECT SUM(C.score * P.weight) / COALESCE(NULLIF(SUM(P.weight), 0), 1)
        INTO weighted_avg
        FROM corrections AS C
        JOIN projects AS P ON C.project_id = P.id
        WHERE C.user_id = user_id;

        -- Update the average_score in the users table
        UPDATE users SET average_score = COALESCE(weighted_avg, 0) WHERE id = user_id;
    END LOOP;

    -- Close the cursor
    CLOSE user_cursor;

END //
DELIMITER ;
