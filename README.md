### Exercise 1:

**Task:**
Create a PL/SQL procedure named `proc_max_cazari` that takes an IN OUT parameter `param_id`. The procedure should find the camera ID with the maximum number of reservations in the `cazare` table for a specified hotel ID.

**Procedure Steps:**
1. Declare a cursor (`c_join`) to fetch distinct camera IDs for a given hotel ID from the `cazare` table.
2. Initialize variables to keep track of the maximum reservations (`v_maxCamera`), the corresponding camera ID (`v_maxIdCamera`), and other required counters.
3. Open the cursor if it's not already open.
4. Loop through the cursor:
    - Fetch the current camera ID (`v_crIdCamera`).
    - Count the number of reservations for the current camera.
    - Update the maximum reservations and corresponding camera ID if needed.
5. Close the cursor if it's open.
6. Update the `param_id` with the camera ID having the maximum reservations.

**Test Procedure:**
Declare a variable, call `PROC_MAX_CAZARI` with that variable, and print the result.

### Exercise 2:

**Tasks:**
1. Create a table named `NEW_CAZARE` that is a copy of the existing `CAZARE` table.
2. Define a nested table type (`info_cazare`) and another nested table type (`nest_info_cazare`) to store additional information related to a reservation.
3. Add a nested table column (`col_info_cazare`) to the `NEW_CAZARE` table to store the additional information.

**Nested Table Type:**
- `info_cazare`: Store information like reservation ID, arrival date, departure date, and a contact person's name.
- `nest_info_cazare`: A table of `info_cazare` objects.

**Table Modification:**
- Add a nested table column (`col_info_cazare`) to the `NEW_CAZARE` table to store additional information.

**Test Block:**
Declare an object of type `INFO_CAZARE` and perform any necessary calculations.

### Exercise 3:

**Task:**
Create a trigger named `trig_external_cazare` that fires before an insert, update, or delete operation on the `CAZARE` table. The trigger should check the existence of related records in the `rezervare` and `camera` tables for the specified `id_rezervare` and `id_camera`.

**Trigger Steps:**
1. Declare variables to count the number of related records in the `rezervare` and `camera` tables.
2. Check the existence of the specified `id_rezervare` in the `rezervare` table. If not found, raise an exception.
3. Check the existence of the specified `id_camera` in the `camera` table. If not found, raise an exception.

**Error Handling:**
- If no matching data is found in the `rezervare` table, raise a custom exception.
- If no matching data is found in the `camera` table, raise a custom exception.