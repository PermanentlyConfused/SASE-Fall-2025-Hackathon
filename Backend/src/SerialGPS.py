import serial

def convert_to_decimal_degrees(raw_value, direction):
    """
    Convert NMEA coordinate format to decimal degrees.
    
    Args:
        raw_value (str): Coordinate in NMEA format (ddmm.mmmm or dddmm.mmmm).
        direction (str): 'N', 'S', 'E', or 'W'.
    
    Returns:
        float: Decimal degrees.
    """
    if not raw_value or not direction:
        return None

    try:
        if direction in ['N', 'S']:
            degrees = int(raw_value[:2])
            minutes = float(raw_value[2:])
        else: 
            degrees = int(raw_value[:3])
            minutes = float(raw_value[3:])
        
        decimal_degrees = degrees + (minutes / 60)
        if direction in ['S', 'W']:
            decimal_degrees *= -1

        return round(decimal_degrees, 6)
    except ValueError as e:
        print(e)
        return None


def read_serial_data(port, baudrate, timeout=1):
    try:
        ser = serial.Serial(port, baudrate, timeout=timeout)
        print(f"Opened serial port {port} at {baudrate} baud.")

        while True:
            data = ser.readline().decode('utf-8', errors='ignore').strip()

            if data.startswith('$GPRMC'):
                parts = data.split(',')

                if len(parts) >= 12:
                    raw_lat = parts[3]
                    lat_dir = parts[4]
                    raw_lon = parts[5]
                    lon_dir = parts[6]
                    latitude = convert_to_decimal_degrees(raw_lat, lat_dir)
                    longitude = convert_to_decimal_degrees(raw_lon, lon_dir)
                    if latitude is not None and longitude is not None:
                        return([latitude,longitude])
                        

    except serial.SerialException as e:
        print(f"Error opening or communicating with serial port: {e}")
    except KeyboardInterrupt:
        print("Serial read stopped by user.")
    finally:
        if 'ser' in locals() and ser.is_open:
            ser.close()
            print("Serial port closed.")
