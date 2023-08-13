import { Router } from 'express';
import { studentCtrl } from '../controllers/student.ctrl.js';
import { validateData } from '../middlewares/validateData.js';

const router = Router();

router.post('/', validateData, studentCtrl.isValidStudent);

export default router;
