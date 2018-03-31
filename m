Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48Vy0qDVLuApNLNLy8e0/O2pJeoVVr2HIPHeMfXseJyjrMcZL4eceUQ0E3IDSv+1tIf/x2K
ARC-Seal: i=1; a=rsa-sha256; t=1522476565; cv=none;
        d=google.com; s=arc-20160816;
        b=rlrqDBEhkuNcxelppHmTclKtR/New/0UDvHe6Mi8AtpcPrgmi1fu+k/epPcBaHuPfT
         vRuh1ISTK39NIBvzVQKvc27L5aK1Gh3Ust/zM1Nr0d9kYdGAicZXBnftkqlWWGtCBLSV
         c5CIWv8Rz0X/eDcDjOufBcScC9C9jc9QUVgC5uCip2N8tpQXM4dRM1jD+3uqy3kvyQ2v
         Su3JyT0DjtxRbZmuMvTXtXIYYZw+oX9RWc6Unzz2SYVt1K1ybHRKCtUsUC6Yk9UMXOJ8
         Axo1TtdrxYra9nl6llZ1FhjrIDiX72HdnxPdjHUXM82AGGFxKlqnN9wTmUy9VZO9QGMX
         5uPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=wmij6Hb6HIuQL9gP8o9BLUxiMsJWwZtLYM5Gkc/N0qA=;
        b=b7WZlC5e+gbT2FCY2oDgI0sM4gereW5FIRNqNq+X1VkQsjbj+gqHdw3BCc71uqf9dd
         XIHMGJxnWx8uW7f0J+tn7vQRWgvgO9k9s9mapq/y5oa1jcXtfJSAYzE7tVPkcsdcZfiG
         ImLHtlLbGGHS1+tc/d9oMLlZmpfJidRXAjcUZwIEDYBX0pXwzgqq1osxtDIo2RjWGLNt
         LhRVjdlypV5dycE+XbpGxEdZAqbsrd9hdgF3S6Lpzh7N/RzrPybbcooFUk+d98TEnW4y
         KWdmPcxBoaxeQC0BUwQfVsmY0ZRF7IGsFZ/Sq4Ja6femnu2oFmH6HtQu7+4v67AHJ5/h
         9sHw==
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
Subject: [PATCH v2 03/75] staging: ks7010: Remove trailing _t from 'struct rsn_mode_t'.
Date: Fri, 30 Mar 2018 23:07:43 -0700
Message-Id: <20180331060855.9452-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:CmWyRw6Lj2YNzNWfOdxx8BFUtX9XszaxcKYK/XgrXX6uweqtVBk
 RCocC3nFzaimamdxuHq1mJVRh4y0KO8SPVx4Lz7+B3nltdiqt3zYHGWcnGxwdpvGlMHtUkj
 VPWrMUUokJQkwv4SYSpERSHlNKXCWqucsdKdT9rNN4A5EKKfE3Sg5pFhAmiJq4AfB/34cfl
 AjWs+jT9tLMrnuXeYAlig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fon0wJE7PfE=:Tth1pKN3KYHk1lfFoGV2ku
 xf2onQrEtoOV1mqnX+Xd2LT1uNSN8IaJlbV/S9Ju4e+LQgNyD7P/rcsclrB8AnDtKaMkT03f8
 rxWtJQH4VDZ+KP4zRgE1v8bSlRzi/irocz9c8oxELWS8YUate8VDWt9NpavK/NpYujgskMfuU
 52maBynfojpRWj8Ou7+5865kjhoIA/g/TsxjkmMIGy6sTo2dCXa8HU0/Vg3mu9F8Wnb3rdiMq
 HG1b6qo6VrdaEq5j8v34Txc/Y9nWKApg+l2o0jSJeyzXAjsAtX229Mr7PZ8h64Zf1HxRplUJ2
 21Et5G/chINUFglgaorAy+RNN9lR7MFk30yeNiQg2I62dXvIcMaUg5wnBm0EK5EeqJvcQHMv/
 Hoo+JalLc6SH3wSeo1UYlEJb0zdHrpRAE5vf8HD7xtAgWt2cePThX8MtQClNBRIswgarNbPRr
 VjvZSqNteLMiObvq0YF03JFSCzR69ZFiHqIq9DqTtmESds1FAw9iRAinq8q20tF6gPSag0Xck
 7e77heiJG8LKHeAfp24Q9JVXUW6RFpQlrgR8t08ZaN8p9iC+4ZXL1FOoaa+C1gfMdlgMo79nq
 DCI4Pgq4u/BlKKMy3RZrjIFVphVcBfNSyoZsjZOyaDd360yn1tNO9HkGnI1Un/zJnfGin1arr
 PS5mwDsKcbgY1EJ2/DrW23fWua90vGf6Cc/aIMRd/V+MX03agL+MSZVCtvR5IZHsy13BlAJBp
 /uoa+TEbaJpgSVzjqD3h2ZbJb4HBSelS0NB8ag==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432387236301895?=
X-GMAIL-MSGID: =?utf-8?q?1596432387236301895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct rsn_mode_t' with 'struct rsn_mode'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index af1a5c123789..8c269624401b 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1665,7 +1665,7 @@ struct wpa_suite {
 	unsigned char suite[4][CIPHER_ID_LEN];
 } __packed;
 
-struct rsn_mode_t {
+struct rsn_mode {
 	__le32 rsn_mode;
 	__le16 rsn_capability;
 } __packed;
@@ -1674,7 +1674,7 @@ static
 void hostif_sme_set_rsn(struct ks_wlan_private *priv, int type)
 {
 	struct wpa_suite wpa_suite;
-	struct rsn_mode_t rsn_mode;
+	struct rsn_mode rsn_mode;
 	__le32 val;
 
 	memset(&wpa_suite, 0, sizeof(wpa_suite));
-- 
2.16.3
