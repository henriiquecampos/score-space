import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
import { QueryDocumentSnapshot, QuerySnapshot } from '@google-cloud/firestore';
import { document } from 'firebase-functions/lib/providers/firestore';

admin.initializeApp(functions.config().firebase)

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

export const updateLeaderboard = functions.firestore
    .document('scores/{documentId}').onCreate(async (snapshot, context) => {
        console.log(`New document added - [ID]: ${snapshot.id} - [PLAYER]: ${snapshot.data().player} - [SCORE]: ${snapshot.data().score}`)
        const db = admin.firestore()
        const newScore = snapshot.data()
        const newScoreId = snapshot.id
        
        const scoresDocs = await db.collection('scores').get()
        
        if (scoresDocs.size < 6) {
            return null
        }

        let foundDoc = false
        let docId = ''
        
        for (let x = 0; x < scoresDocs.size; x++) {
            if (newScore.score > scoresDocs.docs[x].data().score) {
                foundDoc = true
                docId = scoresDocs.docs[x].id
                break
            }
        }

        if (!foundDoc) {
            return db.collection('scores').doc(newScoreId).delete()
        } else {
            return db.collection('scores').doc(docId).delete()
        }

    })