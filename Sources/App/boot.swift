import Vapor

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    print("""
    Vaporized BilibiliCD.  Copyright (C) 2018  Zhiyu Zhu
    This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
    This is free software, and you are welcome to redistribute it
    under certain conditions; type `show c' for details.
    
    """)
}
