import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

//const db = admin.firestore();
const fcm = admin.messaging();


export const newTiccketNotif = functions.firestore
.document('tickets/{refNo}')
.onCreate(async (snap, context) => {
    
    const token = 'e54wGqJHdCA:APA91bGFz78jqQlFTIt1eUOnAugxZnxA2BmWRZIEoCU1aFjTIFINBXMwbLdoQQP0UoVh59L2i865z6_g4clw-IdW5BCvd8pJRi8kQsHYAPSn4NixCfCG0yCw4VX-MtDLrhAm8Ga5got0'

    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: 'Success!',
            body: `Your ticket has been created`,
            icon: 'your-icon-url',
            click_action: 'FLUTTER_NOTIFICATION_CLICK'
        }
    };
    
    return fcm.sendToDevice(token, payload);

});
