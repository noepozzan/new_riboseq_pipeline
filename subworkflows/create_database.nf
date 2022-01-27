include { DATABASE } from '../modules/database.nf'

workflow CREATE_DATABASE {

    take:
    workspace
	db

    main:
    DATABASE( workspace, db )

    emit:
    database = DATABASE.out.database

}
~
