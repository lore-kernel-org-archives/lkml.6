Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48YfbFMugqOAOHMshSrsn3Ha506BT+WRVHogBqFpNGss4Fj4peObFo0h51wBFr0RjJC7Ef5
ARC-Seal: i=1; a=rsa-sha256; t=1522393758; cv=none;
        d=google.com; s=arc-20160816;
        b=eS0B+wRkgaIfXvQN4IlzrXazh8Ps7wKtGPL+Wc6hTX4wV0D/sDdL8lb6G9Bn7sATf1
         ye+I9fMI+zsIFyjAEaaLyCgsC/5ThuSclHzepR+kXioO9XwEVU41iHJ3iqhm1l84uNgT
         NNlEdenAe+9FPn3srQvBjc+Nk8BXQrVyWdvj5hY2ZoAVq8Ov/k9sM20SQ+Fvp0Pv1l1X
         7JauXAKMjpruBwOUVSSaS7SqlMzTQuarUTjQEJiKK9KVnvd4RVKW4vOV2xHWRnxpQfmI
         FrXoJfH6ATXcHIhdhpGgfNzz4wE+zpmw5KlYBU1xIKlqIm5d0z/FYDl1Ky1bXy5NpKCI
         nwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=pQAaxmdqrJ9S8bqlKLlkkM1uihNWRioSfKDXMz8CRqI=;
        b=sQgNY6CfMdwr4Yls9APxh6K1TGSSBp0980zAAq2MhBPzMUyBthLBf/gA56zCyuNokF
         YJU2iDZdZnw4W8VuEQozq7nUE6R1gz3/6fTdRzD5Q5BhJPXyWSdGLPTpV+BpndhIFsFN
         +tTT3xSCeej6MYvh9T0hn8XBvi/HHtttYRkauYzx8ekaQJtJxiFb2/0vGQWpjKdCegoW
         4jb7HXlKxOHQdwYaQ7R4eADty/uFsjeXD+EpuxleBPrAuLLZ/0tOAe973Md76GeCew8B
         OkYDFBM1Mfl0jMIDBg3HFE6vz06uC2V167hiDrv0Jvx2HEdy/fepMxYWIDXRW2Z24vgE
         XKlg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 23/76] staging: ks7010: Remove trailing _t from 'struct rsn_t'.
Date: Fri, 30 Mar 2018 00:07:46 -0700
Message-Id: <20180330070842.25224-23-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:vqp6+VckTxZPp0lB6hBdcyIpJgPAmAEtdnrsfSoBi/oBb7YNIQA
 sgOmbO7eJCs6W3d1PkZvmLcHzXXcxl3HoAftnvLZ1dULFVJ1cSM0Lwm/DpdoCCWjZXAbXvd
 VyX5LdstJHldgUrIc7GI+7SA98dE7Woh3BbEzr/s0bP6VjT/OZGabQ3i+WdcO9LSzKxU/sv
 NtXAkKXdxrUl6vePXAVbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bwqvMhrBCnE=:MAUR59/I8uRYvy8VblDdse
 lckHVCFkr2upZlU6mVQE9csd7zJtxhVFfhF8dNjNAos8xpFoDNKY6hW9RaS1NLuLp3kuvW5kM
 8yim3Ebi/wlTIELoxPS+vF500CKEBUtlNf0FyO6JBAZJAQXp+VKbs7gqMrIzzmuQn+IN/aiCJ
 jXD7nlxN/DwcMfI9jZW/staK7IkaFECLqudRv0fvYZoXCznMy+BFeo7pSi9F8e+YfPp6bmgBA
 cX3xYuj61UvODWPjzvLhuojsWOSd4E2j/AwRRY+2jhd9PJ1RnAS3+zN8VjDTNiI3f8PQ1SGL7
 SuJsWatKaVjZZmVj8R+1SLLAgRdG/1cXsl9PaY7IB1yc7Y+KUAobEvjgBSUsaL3wf4WB/cY1F
 518rE6V0CCpFamtIyxzWD2TAF6KGqLhW8YAeN/pEFnxFet+NMxohIuNkj1UifdIHS+FvMmlz1
 jjQO5H9Lgm13sPwqsmc22Zl972ZpAVZkclR9wJrYizdMX9bptqK+vWLAY1cBI2ZRkYOPaFEoG
 66WvvA1KM6GqbkU+YVvp0xUq0yMesFyx0cyN9fMtj+VSULQuMkmMQs4LiIPTLEM9humUMhZvk
 QyErMzUc05s8ohG0TP3kGYWHgtqepwBSVHx+HTe/PkxBTDZQX4bC+TRG8WDajXfMkuhkK4wav
 LYoxazbGnXfaCmsefP4Z6cF7hmKFgvqeXy+ad46uJhlNjiUQLHf4v8K1t9sQotzvFuqHP+PzT
 fiJuVnTnFzsMY36f1NWKxDs6Vyu6B5HqYEhvQw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345558139967312?=
X-GMAIL-MSGID: =?utf-8?q?1596345558139967312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct rsn_t' with 'struct rsn'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 8a203d759aa1..548ad0e8a5f0 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -260,7 +260,7 @@ struct ibss_parms {
 	__le16 atim_window;
 } __packed;
 
-struct rsn_t {
+struct rsn {
 	u8 size;
 #define RSN_BODY_SIZE 64
 	u8 body[RSN_BODY_SIZE];
-- 
2.16.3
