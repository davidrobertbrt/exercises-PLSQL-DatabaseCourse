CREATE OR REPLACE PROCEDURE proc_max_cazari(
    param_id IN OUT NUMBER
)
IS
    CURSOR c_join IS
    SELECT DISTINCT id_camera FROM
    cazare
    WHERE id_hotel = param_id;
    
    v_countCazare NUMBER(5,0) := 0;
    v_crIdCamera NUMBER(5,0) := 0;
    v_maxCamera NUMBER(5,0) := 0;
    v_maxIdCamera NUMBER(5,0) := 0;
    
BEGIN
    IF c_join%ISOPEN = false THEN
        OPEN c_join;
    END IF;    
    
    LOOP
        FETCH c_join INTO v_crIdCamera;

        EXIT WHEN c_join%NOTFOUND = true;
        
        SELECT COUNT(ID_CAZARE)
        INTO v_countCazare
        FROM cazare
        WHERE id_camera = v_crIdCamera;
        
        IF v_countCazare > v_maxCamera THEN
            v_maxCamera := v_countCazare;  
            v_maxIdCamera := v_crIdCamera;
        END IF;
    END LOOP;
    
    IF c_join%ISOPEN = true THEN
        CLOSE c_join;
    END IF;
    
    param_id := v_maxIdCamera;
    
END;

DECLARE
    obj_cazare INFO_CAZARE; 
    date_diff NUMBER; -- Change the datatype to NUMBER
BEGIN
    date_diff := TO_DATE('31-DEC-2023') - TO_DATE('25-DEC-2023');
    
    obj_cazare := INFO_CAZARE(5, TO_DATE('25-DEC-2023'), TO_DATE('31-DEC-2023'), 'Test 123');
    
    -- Additional code can be added here if needed.
END;

CREATE OR REPLACE TRIGGER trig_external_cazare
BEFORE INSERT OR UPDATE OR DELETE ON CAZARE
FOR EACH ROW
DECLARE
    v_countRezervari NUMBER(6,0) := 0;
    v_countCamera NUMBER(6,0) := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_countRezervari
    FROM rezervare WHERE :OLD.id_rezervare = rezervare.id_rezervare;
    
    IF v_countRezervari = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No matching data in rezervare table.');
    END IF;
    
    SELECT COUNT(*)
    INTO v_countCamera
    FROM camera WHERE :OLD.id_camera = camera.id_camera;
    
    IF v_countCamera = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No matching data in camera table.');
    END IF;
END;
