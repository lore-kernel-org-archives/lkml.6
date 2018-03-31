Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49hx6NKHpegTBpO6n9FI8q2GKLVAH0eNv1A1jVOH7I98IyQfnJXKY+4f+cgQ+x5bv4HXxyI
ARC-Seal: i=1; a=rsa-sha256; t=1522476582; cv=none;
        d=google.com; s=arc-20160816;
        b=SGoQlsVZIzVcov4ij74CS1El1WMQPKC9YkIy4GMOQw65w3QNE7R9hJiR2qPpWTCjDZ
         NB3mngxoXXV8Oi2qyBh+z82UHPLmXaUOpcFDmHOys3Yv7V5CvmH6UKZGg9Ez7K+/4CbB
         2BWdBD3bpOATGuM07tQGqn65ypmlqb+tx081JLxLIhE5N76Ez2tPHy3803G1h8om2Gr6
         jV1bpLTe7sTDpFEL1k+UnuTJvTGu76P7iivspRKFWarLDzeVe5fHTj4bf2am+l7er0Iv
         mxNHKdliOojcsHaHUt/INFbsAFtPfFpbZMij8ue5kTc+udlav+jrUO4OfHCV9eq7cIZ1
         Pmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mhoPruKJ8ErHUhmT6KSrrABbOWh28eBPDZym1dJRmUQ=;
        b=XSptxKUVwpgtsWpbxCYV4ofyOCwWC0QWwaJi4gcibjCHJLh8ZokaioOhRyuL9j5925
         eGbL+NzIAUGkTm2zZWMlq8bSQw4xuLE/CDc0qGEEdyp1kriuzxJl0P6WWqZr00539rx3
         yDU+L8+zlVQ1UJPdNh7URcIWejUbhHH19g+LwvOh4iN+J2SGMwY+DJZgysPEFvQQfIgo
         73GKi/QcbH2QgCeuN0RaDkOA1OmYtf1EtWOQ7B1oWg8UZTc3XH6PEyl+usc9HgYQUmPp
         zhDnmqorVVosqjRCkDQcG+r8nyd1PpHPiY1rXUIM3Jv5RXMsRX3XA/sA80uiXdKjcaQg
         wGCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 22/75] staging: ks7010: Remove trailing _t from 'struct ibss_parms_t'.
Date: Fri, 30 Mar 2018 23:08:02 -0700
Message-Id: <20180331060855.9452-22-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:/i26zr05S/8bmLJYf38GH7nIGxw8Pu6ZLIkartXum2kyeuzqk/P
 XP5jCkS7H+R+o/NJnsY/DQ7NKsRMwae01mTzOFdMFtVrQloK8HAN0CwTtSF3ZNMzRcx3qjR
 2c1hKXTtxD3GCsWX5kIP10Cp5EMszvcaW4gVAq42TYmgLgXjY+rWAjq1AY7JNdYRBc1PeIK
 wyN7dXbNiqRGZsnuCst3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ffw8ujRHH90=:KT5tmzM1LlsG7cKyIEgF9g
 XJtDGIamt5XaM8m3RVaUwO48cpeQMp8YM6YYpKS87rt1DyCwqdD9Ncdu7Q89otv9/KO/2QdbW
 bvWdN1nihMtvSL+9v01m8RwVHeROlEYnrwymK7DwFVbvaqrDAoCPYy6f2zGm1HWIHHHa1AZEL
 /vZa+zyi+TfVrkH0M8KO5vNnsVqqUGsU6qHbSusmkBJJNTOi6fWcpsNhOyuuYMcVUp+At2im0
 6zEFoQMcY1IFQ6oWp50v6byw+TtrXItsygnmwkB/LUyR0LBtGiSWNEF8pfHWQ/8ey/17LyIyH
 qLzyV+eWhgHSAqfdKyoTn3+jvBfQSrTNd9ApPk/1rn1NAsnFAbkOErMuF/yLFwdEoHkRvuPVp
 iDicJPaujQtg5Rmyp7xOzv0pZ6q5PUW3WdAhF2Z3YLeW6JSz+vB+fJgHauX5wTG0O+TOC6e2/
 0rp5J3QPz//tlX8eCMx2w9DxiiHOe2caPUXZjjZm+bQ9JATSgV2AIEcKmLw3C3PdTQYCgNZlu
 d1RPamgrY0BH0bWkQ+qt81Nj5KaEsgI32SWWP1dQsqskOo2wYsYKwuiqBev6LXfOcljp0fluz
 YqFIDmqQSg/nuLKrZ9u+0MFbIWUAboo1ci+8GUKrHAIWOQm06reRqXj8iE9/DGZvEnMWKF8K3
 LNhgoUERTFzX5olZD0PYioMew927119dobCTD0R7mDngMIxUkQa5eNYx3rKzJ0P8QS8LA2fmU
 Il15y2CWaeeWSPj3pSGq3O5sbIRHGchLj/TtHA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432404841885899?=
X-GMAIL-MSGID: =?utf-8?q?1596432404841885899?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct ibss_parms_t' with 'struct ibss_parms'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 2dcd6253b17a..a3c686c1289c 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -227,7 +227,7 @@ struct cf_parms {
 	__le16 dur_remaining;
 } __packed;
 
-struct ibss_parms_t {
+struct ibss_parms {
 	__le16 atim_window;
 } __packed;
 
@@ -274,7 +274,7 @@ struct link_ap_info_t {
 	struct fh_parms fh_parameter;	/* +24 */
 	struct ds_parms ds_parameter;	/* +29 */
 	struct cf_parms cf_parameter;	/* +30 */
-	struct ibss_parms_t ibss_parameter;	/* +36 */
+	struct ibss_parms ibss_parameter;	/* +36 */
 	struct erp_params_t erp_parameter;	/* +38 */
 	u8 pad1;	/* +39 */
 	struct rate_set8 ext_rate_set;	/* +40 */
-- 
2.16.3
