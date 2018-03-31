Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+08GEnT1NKGZeKUGa71C7v2B+SruQF5dqAZjdc3C0FZnJuQn7LdEzoy0j7A3C9EOrNUsfR
ARC-Seal: i=1; a=rsa-sha256; t=1522476595; cv=none;
        d=google.com; s=arc-20160816;
        b=pYcrnmwQlkLg5fzQofPdM5WEhWrnLW1DcAVRkq2925EiXdhbQDrvNF2yltLKitSwQL
         6oLC7lMWx6UmskLEAy81l8TFkm5c+Efs7jY7iPIbfR2KHCd5+unlEi+WMJu3naJ6sABG
         v7HrzuKT3hrbRc9652B5OIE63beyrQ7oVpYNpsF7UwHndZfLVIDQfycslmqMdrcSZt5e
         UBJwYfAHXhvLTK8GjqeiQC1Zysj5XfgjtNJ/s5LGEojj75YNeudhzN1gDi1zUKd5cMla
         QnZh6TpNbGKvv07HoU3WWnP1ZEUHRqADbEsmuezlZFVMKKlV6SuNfi3XxWWHggPS/JnZ
         9O/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3vsHosEmLQ6qplQuAuDWhRZUOzYSi5cyY8qI/nx8S00=;
        b=qQg/ZWwODai4mjz44PkqgYB3CeC7MaH/QJiT9V6q2fnWxjDX3ddKRzLJNxJNEa/ooM
         /vjud/YMVBfdGEtM3ZphA3MmC0oUQdPqNfh6LHuxnBkcvd5aj1TU8d2Gl7nMCABlSA4B
         9NEcANJ3lbNKIP71I7PWn9v9YsU1s79ngPHoKqTPw/B7dTTAyqdoYZ+RNwYsQWd2rXfQ
         hDdRbiViO9I3X4KQ4G6o8hyfzVmZBkoUeevPTjsm6Rq7tXG1IGjgBgJAbBnUNAdm63po
         5RckwwEAJ+egCV9TdX8gqZGAoqre0QPs3/Sowuwl4RLPQZFMSTmka7lWaMewOBXDnvO1
         xUMg==
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
Subject: [PATCH v2 37/75] staging: ks7010: Remove trailing _t from 'struct hostif_adhoc_set2_request_t'.
Date: Fri, 30 Mar 2018 23:08:17 -0700
Message-Id: <20180331060855.9452-37-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:ioeU4XLCq9nBuoFqoJ5knJk54nnB1UdXTJZaj544MFm+lpkyzId
 X7MSN7gDNMy/M/7l+y2pHFxH4h1QZJbg9cxQq3G9XMZ9xhxTp88Lm9YwOkiAefY62D/Et1B
 hW63rrsTbAEaq9vvVmdH2XUujGrzL1REVbS+tuUgBjpEMz6b3fugA5x7Ja7u/bApydAW99U
 nvAvffRpgdeaCVrVHeqOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yxjZ8fRF+SM=:UqENQp094106DKvTWVFIWA
 EeVVPfq57SUj+Ald5bDwphvAgJ//GdQFptN8Ov1Z3dSKLkqNqMFDAB0a5G2Ryy7FcXkFGYgx3
 pQrXgbzgd7NOLfCabEUsaGbSDIR3dkc7iD2UnusikiYM6pCPHsiw5Y3E5UP8ztosbiHUgsY0c
 pR6RSAl0yLIBC9vBeqCBJ7N1/Y6/LOOJzugznQCLvnBn/oHJlIuJJq+/Ud05nMsHeiP8mZqlg
 cQUmFzTPo4d0Hg+/X4KH/m0XNh9WVkNvzFTxBx8G3CVXGSeSpz3RjYmn7misS0UmvpROi3amw
 YFTL5FMDJ0z46sX7gvnIY5smoVM6HptZwekaNFOkPzdbNBUGGSUUn7Dq57tS63sMcPXvt3RYB
 PCS1h34hnF4q4Slen8fU67BQAtsiXpHdVbiMYBpsolDgOVEfS/5gMuHHpz76xRU8jUiuVCNw0
 O7mWOGY5rcNSt9LAG/Mg5Nklxo3i3YO6wzUiwAt1E0EW044/uj2QgIwa7pcS+0ytpF90Ro1P6
 87/mt4JgPiHeBfq0tjsEsbD/51hJRYiQHazGP1mZkf1RuoTm2RW66YEZEGy121moC/m7inMjU
 drTChIyNoIytrWBhWMISthNlPlibNt9CymuqgsbNxkY1pFa35be8EmNEgfpuWDCkjDqKI3p3f
 aw3iDe3C0F9kPdsZePdJ9VZBloer1XtOG99LkEw+s9qLNCvZDE+Ak2kRmnc9z5LhllaP/vTy6
 8bhLqldAmFN0p3Sckp3tZU7XJIN4p/LnHbz0JQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432418645336019?=
X-GMAIL-MSGID: =?utf-8?q?1596432418645336019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_adhoc_set2_request_t' with 'struct
hostif_adhoc_set2_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index de56cda64bb9..a177496dd42a 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1404,7 +1404,7 @@ void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 static
 void hostif_adhoc_set2_request(struct ks_wlan_private *priv)
 {
-	struct hostif_adhoc_set2_request_t *pp;
+	struct hostif_adhoc_set2_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_ADH_SET_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 8574c09b3ab9..21b1c5cd9f34 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -356,13 +356,13 @@ struct hostif_adhoc_set_request {
 } __packed;
 
 /**
- * struct hostif_adhoc_set2_request_t
+ * struct hostif_adhoc_set2_request
  * @capability: bit5  : preamble
  *              bit6  : pbcc - Not supported always 0
  *              bit10 : ShortSlotTime
  *              bit13 : DSSS-OFDM - Not supported always 0
  */
-struct hostif_adhoc_set2_request_t {
+struct hostif_adhoc_set2_request {
 	struct hostif_hdr header;
 	struct hostif_request request;
 	__le16 reserved;
-- 
2.16.3
