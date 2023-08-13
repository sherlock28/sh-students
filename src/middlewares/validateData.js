import { HttpStatusCode } from '../const/statusCode.js';
import { serviceResponse } from '../libs/serviceResponse.js';

export const validateData = (req, res, next) => {

    if (req.body.file_number === undefined) {
        return res.status(HttpStatusCode.BAD_REQUEST).json(serviceResponse({ data: null, success: false, message: 'file_number is missing.', error: 'file_number is required.' }));
    }

    if (req.body.file_number?.length === 0) {
        return res.status(HttpStatusCode.BAD_REQUEST).json(serviceResponse({ data: null, success: false, message: 'file_number is missing.', error: 'file_number is required.' }));
    }

    return next();
}
