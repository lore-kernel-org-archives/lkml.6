Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/4BLpFHkS6x+sd771B8F03WceFiH2nHRqKlIkPRqXSPdlsTKU9lxMKmlrMhh7xzd3STEho
ARC-Seal: i=1; a=rsa-sha256; t=1522393756; cv=none;
        d=google.com; s=arc-20160816;
        b=MFdgJE8RAAhre0RhJpqItUSZIshmv413Fo/ej6C8mdUC5BgoV3sz+XOSYapdMdHNvP
         dfSo1leXOoDZPS00T0MKcDGRBOR9imw01UVFvB1BYdFvybpiW1a2YDpOkb9p2WGs3ipv
         ub+cfYLfLDxdCRGJ8GWGMA3BWsLivcFIF/1L+jVpR0PNXMdfh62jIg6T+Qa4ECl4HeEr
         bGye8RtefmfuvD7e2tF0I6iSKvgPvbpjsZuCeoObTbuUXFoDMBprd1IaMTMdD1ERQA0u
         BMrOKA32VMdlxYKviILeyEc23fHXdOYPKtFDMOek9Co6v/4TQxGKPxViysTVFjNgWPeO
         bAww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ROxjXFquJT6bjNyWjEtwsLPPHqtQ8lsHPdpuNTBPyC8=;
        b=DHlvPxiGiTQ6UVfg7OLpp7lsaF/skEHhZb5x2udHLHIcwEPheBNB/S8h3UGUnbPzHo
         HK31FVr5Yyg1MGpHOpvTtiDNUZhsX15EPAsW5nuPALkx3DXmmZlc/9E7oVqvJ+UIUqlJ
         wpj3X2Cq085oBsV2n/EN9yn8WMvuinK+t16YeDXFNNWdu9gTUWMI28UlSx6HoXH31qRu
         hw2IxopP1fnhMCKDB7Mno2ewMylJQ8ESufLT8JmNa2Gi/5HReVxURxqaBJ70rB8REaDn
         9X675f2a1Cbu/t7NAE7tirUP1tyIItCA7BqQ1sdG24THQvIxmvxdKsUh5PnSp17BwANd
         vPBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 20/76] staging: ks7010: Remove trailing _t from 'struct ds_parms_t'.
Date: Fri, 30 Mar 2018 00:07:43 -0700
Message-Id: <20180330070842.25224-20-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:ld49PnaM7e+AjXoolZS3zwwXmRtO3r2w8G2ITXCNEzcVoPFGNI/
 iRA7NcalzQGc2ItTO1N0VniLO1lmoWljHYNVgbvuCws8bI+ol9UJorHW60yXU8qsfSjipJP
 FaTX3E9tgSciZgGP8qakNrxpqGs6SCDuCz9jYko+6Gc8tUsI9ShC5Edwea6ym9oTosa6crX
 LUjJ59N9LGtdo9UdGBg4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yob8JzM5J84=:BeTMLDswIQAI6nCuNyQjK7
 P2c1hD1nYO3wlacZN69RAP3AQRqQhgwMIKz6LyNbHKuBYn8sydAcsJWGCAH1qZTUy6n3MQk4f
 /oHe5AFfgBCC6eMs6SVdFaOkV/CgKRFLVKXxnlBYHBenwy/X9AKrsez/xZYN65wsKfRg7eXrY
 x+3OAkgdCSfwr7Wzo+8o4feohGd71U1Bf5qxYxWitfB957oEKuHpj5Mz1q0+Kb1nRJN6ozcK5
 H8LR6unQS48+kHQYZSjdi/aORC0Dw+m3nnbSH/9f3In+p5JfpdeXT2mn6E6/ZxUtu7J6KyeP9
 LwE7WfUokS0w+WbExaile2tgshMR0izJdgFf3fIOhGWLZN2U7TQ66H8Yxm6MhzJ8zteYRTRuI
 atXtlYIsqE7nCbMuk1X8ztrHYZmkCOoNcqrXarYOZjb4ai5g4EQO4zBw1dIjzfNicsjNhmfK+
 ZTNONZNyz069YjwV3d8fnk894dVjUpdgY4ReWZzniAturfW1PsJtgqBBIKePF4jn/9VavLl14
 4kKyJCe24j4Q1kax6dW9bGhCwUK74lGMhvcC5vpQeNFQdEgceyYWrZ93sk/qjUpYjZPq89dxB
 sLP7UwrOGuHYQI2RyZqEDOH5CvYUtBnAZos7e7KXENDzjxcBLNRPfN9kjv8UMwTRgJbNi7egJ
 dKUXOMpqiqMfMZ4+CZuUsArYeEItWCc6eV9jqDktyOZ3lhbYLzGXvjuQtREmG9l157foLpGbi
 QjkDx542hKGfw6fS9dMuvBd9eiaiJFuER/pWFA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345555471261719?=
X-GMAIL-MSGID: =?utf-8?q?1596345555471261719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct ds_parms_t' with 'struct ds_parms'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 697cd52292f9..669453b707ea 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -245,7 +245,7 @@ struct fh_parms {
 	u8 hop_index;
 } __packed;
 
-struct ds_parms_t {
+struct ds_parms {
 	u8 channel;
 } __packed;
 
@@ -301,7 +301,7 @@ struct link_ap_info_t {
 	__le16 capability;	/* +12 */
 	struct rate_set8 rate_set;	/* +14 */
 	struct fh_parms fh_parameter;	/* +24 */
-	struct ds_parms_t ds_parameter;	/* +29 */
+	struct ds_parms ds_parameter;	/* +29 */
 	struct cf_parms_t cf_parameter;	/* +30 */
 	struct ibss_parms_t ibss_parameter;	/* +36 */
 	struct erp_params_t erp_parameter;	/* +38 */
-- 
2.16.3
