Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx492Xlz+Ff4+DUbPymMR0kmwyzf3vNuhNsQnRRTm3QiDosNIy25iGv4960nOB0oaaUaY3NcI
ARC-Seal: i=1; a=rsa-sha256; t=1522476581; cv=none;
        d=google.com; s=arc-20160816;
        b=faVoL56K8oj3y0SAt/G1YDwRgUj2jAUGxFJl4zC8jQL/J4F0LYJZDVM+feFKMgdE+W
         klMocBSv3nBAJ1ioS+/pLGX6+8o1dyEarXkcmPid9SPVkz6oFXlBSiqzWxKJQDRbHqul
         DsD2zdMidcYa9qQuT5Uc4saj/w6vcTv7Q5JxP3K8Fcbqcw3TUcnEWVN6i9VgS5fqQ48O
         shHqV9jcICBYiUhaEZSIPqCHdRvUODlLZ6TfSCPPxkmQrgRjTAei5ysZphM3s+9Jcivm
         5rU9sixY8efwq+1uXGpvlSXXnXV2FDLGarpQn63G3DK9AXdlQ8By4HgFc/9sJSqTxcr7
         c9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rKgx5XVSd/vyxH6gbGblChxkSRZVl4pzidRKNAXIvhM=;
        b=ArjJpOZuhXI0H2dZRUAQHYABfcnJmbtwz+NWkVklacH0LSzTR1u5zv3am46m5L+dq/
         eqjpAKNbUz5KyQu6+2JO5uBIBcl08IgUw1l8sQr9b4SBnrkwx8xVCgtczCKl4gjP0vtz
         lVk+0tBesq8wbe77QtqCKpmCmkmviTb/qOVmgmOdDHRwWQRFVPF3a0v1kxhgVdJcaRFc
         KVZjJQy9Bu4LvEzLPPQilA6BOPPKLh1zeHbjtPDGucJJaCfSkMear3abn0E8cE9Nz106
         DPC58oM/ceszgbkhS4HbQVsaYwL296mLS8Yd+/sfQrtJWDUIttVH9aWFFBV8bmHgD8KU
         bAeg==
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
Subject: [PATCH v2 21/75] staging: ks7010: Remove trailing _t from 'struct cf_parms_t'.
Date: Fri, 30 Mar 2018 23:08:01 -0700
Message-Id: <20180331060855.9452-21-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:zgGBSMgvqxfhKhSzIKKyJlMwG1KArzFunpMsIPJuKM06Ln0uHm2
 jMhW8KU7E7BMyYI16gWGz2VOoFN86XlL6L2j5dRFth5yck9f3zMVZxzGS7OfM0Dka0DqeWy
 PLhLEZzwhLGkglOrDCCboK+2VdDYNru4/8x80IG35MBCUsmGPt03+xXjF2LanCSlcQUJz1M
 N8eo0g5EBoZVOCgg/p6Fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M9jnAcKnmX4=:eBfieO0O7SfKBLFWGOI/Ed
 GZPLjkkyvJEucJOtsPEAjoTStq6ANPRkIjkl2Nh4i50QCCXdNR7svy8ZjKlOc/wdo/Bwkk09T
 6/HttXZ+KRwKsLBIUVtiv9yKpxy/RsAVXo5iOcmOZmiS//uXweqH34k/7lFBTF3gq2yPNCe3H
 MERVjkYK7leNMWYQCTfno/Y6nNetddcsxRxeyaWQOSQhCZGRz2/ly1NuR4pQ4kqZhpzr3NGiN
 +gDLEP0Lqq1f4imYcartA2p0ZAQKu5nIyh3wu1guI0iyIUVK3fiPopZUBGH3n+hkwes9rXvWT
 PQ+AGPsGpWFb2DXCuod7cILJEFeBi7CVKRVQtsNly19Qil0MBZtYgi8XFzq6p6wwV0kNWdw0S
 jdBgqnkg5+DgaprApecf1sXET+/RwmsaHCLmH8eQDctptv0ASxsK11vRtGP/CK9QBHkXyd2Mo
 Idge2+IpZqx2AeGMU/lnHI3fLVc5E2WD2/NpUWXnDY4V4qpIFIQX7YhkZZVW9hqBURNW7ERCg
 AbJ0XblD3OgAKrBjewJqhm9OiCf+FdYw10soO05IRHJV1jDPrTeWenHVOgFOSeGkgA5yA2vQz
 u2ycd5zsQdW8sJlYdh5QrSUFBSm05cFWAdgGZjbyljWJY1+4FVgubOP3fZFyfl7TB4RRP3v3K
 WU9xo8z9gmwda1bn92BEWXuz80nZ3uvKpF7PIM/qcxwDX4lJ5ZAoutMjS82iX5zW0GxtNy2M6
 D57kiYwtq9uLGXdFbFwvJZ11y1kyW4Oaw5V4XQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432404242730357?=
X-GMAIL-MSGID: =?utf-8?q?1596432404242730357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct cf_parms_t' with 'struct cf_parms'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index c48730b7527c..2dcd6253b17a 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -220,7 +220,7 @@ struct ds_parms {
 	u8 channel;
 } __packed;
 
-struct cf_parms_t {
+struct cf_parms {
 	u8 count;
 	u8 period;
 	__le16 max_duration;
@@ -273,7 +273,7 @@ struct link_ap_info_t {
 	struct rate_set8 rate_set;	/* +14 */
 	struct fh_parms fh_parameter;	/* +24 */
 	struct ds_parms ds_parameter;	/* +29 */
-	struct cf_parms_t cf_parameter;	/* +30 */
+	struct cf_parms cf_parameter;	/* +30 */
 	struct ibss_parms_t ibss_parameter;	/* +36 */
 	struct erp_params_t erp_parameter;	/* +38 */
 	u8 pad1;	/* +39 */
-- 
2.16.3
