Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49aknqzpTYG9yn/CLO+X4vXKQ8Wn42dft9Fk9sZUemJs+l/+iw93rwY49JObiAo5xl0wc/R
ARC-Seal: i=1; a=rsa-sha256; t=1522476583; cv=none;
        d=google.com; s=arc-20160816;
        b=ylP5p+41l9E4VJPKP8g0ElvWHHQ55bI1dFh2igPZwEDKRfQdlWNZYAwHtduJR7c/lH
         CqfpE4A6BydPaSx32ecpwcKtYLfzyfrGVzWbnI1DxXYUw39hebGP6Cu4YPThsQ9lj2Ct
         i1e2ZiOKDqgxMP7WBqKLryID+3+d7YRnR5VP27yvLKizDCQoVCnznKxuj2AyRKTIQqWd
         uUlTjEVQdmGoMgFucuKFNELKBuEOpphSCXUtn916K7NPCP6LX64zBxLM6r6NAtvcybP/
         nvb9bVHOkaE75lx+W8mqlol/45+KaBLKbR8rnzYL3TDDTIq6osR7mQqJxloC8CzeJ/qn
         WIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=YilTepY3SMHkXvWT3/IRvl0LLXowpewkJllVtxZlxJE=;
        b=CAYIqPQVgjnfq0SAG3KQv5Mwj9oHZ99AQbVlUd3/tUIFS/Mz9svfw7EiJMFx51DKuZ
         d5A+UDfDNASbYi1OyM3Dpp0N5JncfVRjziaVYRGD+0Znjhnh1SE7lJMS3oLQj60dfcAI
         1cZEs03bJYmzkLa+KP78ek/QHxsqMCL3GQDyNhurq8eAOnjz+wov5ND7N31aTKuSiM1+
         89Mq4ZC3L9mmjhS6/6K/ZiW7qknUQLpc/vKpms0xao/Jk7ualeDIKWGGYNZ7ngkZ5xN2
         /1zQ7ZRDFQwtcr404piFdCkmTJ5jEMMmNy+CxuvokZ16Q8fRDXQnwXIpuLIuT9pCoTmC
         Q7VQ==
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
Subject: [PATCH v2 23/75] staging: ks7010: Remove unused 'struct rsn_t'.
Date: Fri, 30 Mar 2018 23:08:03 -0700
Message-Id: <20180331060855.9452-23-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:OqZDxd3u7K0Nrk+gXX3ff9K+k+mNmFxWVWq+YnYBbgASOL/XQjq
 DuReqBmB2d/3WK8C6p/SJzS7gk4Vo33crQuRzZ+QS+l8u+sMaTQe+3YQFroJwmL3pVpkMCG
 Oti5mUaaNh5dV/hb5vODApQc5v8V0tBamZPAhoBuz2/7AFdlI/3vIATEHNtnJBeDNv4pRKP
 XoupNrdMb4rNajzWsiXxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hz2cuUdU5ZA=:hovY0dIUOZjr8F73HSDkWZ
 R5UqStL6vcSBhynyqLLLw7QM7MRoENXb1UTVNMOg/abbmhyacjPlPaN1OOV5buxz0Gt64HDEN
 mFdCYgpI5YpwV3LQFdVlg8Yo0jwLZAq1BTCvAp/+s6i5/BKtdKKz4FyGbkWf0Dx0MAc3dT7Kz
 pu5rOjFqITjTGryo3q3sDEcc8Q5wLKVw+M1UJwQRu6+g6CT+j1ZlazgZs4coPYcjmcF/pd0X9
 glivpzH5R3YKEU4bnyDv+M8Vpjv6reYnZeRs+pjH6TuzPdJEsyQFehsv0HwY1M8gt60fQvp9I
 R/jQMipwCHtSDA5dxNIL5+ErHcd9nbxwMRJjo2DcpTNIJqtRCj7z52drSJBaFdxW4f7Hr5fdp
 inlUhfRQBe7B42lQ91gcS3YeTJEeCr49HkKz8PJVzBzXb/65BIWxrlEFq/NPQDWTNb/PyyBsL
 DDcFKdoc/pJy6ON1u8h8v2PhckwK6CA2z8lHPDdEBZSBqK9xItmvhw1zmit/2IlUGlvvF/Azl
 wZ4WMvGscDUsZeZg0VedPCdIhXdv7xlWskKv0GpdIeaLVRAwqJaDmfBwR2a0Yu4t1chE8WhS8
 rquQVbUY/TwLGpPmW2ApLj198FP9JjFUVnKud9g8yUnfLvulG/L3t4F8cmKoxpclTSAxxthBQ
 ohETAu7SqUIoapNEck72zuHUwAMhDaiXZhe0JiFOYR1PpqlLEuTd4AiRsB14rIpH66iYCi5ji
 4j5ws0mg3ck0ljsTt+Ti3GJ+IaBhqzosGxjGnQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432405638554201?=
X-GMAIL-MSGID: =?utf-8?q?1596432405638554201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct rsn_t' is not used in this driver. Remove 'struct rsn_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index a3c686c1289c..091bc82a99c4 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -231,11 +231,7 @@ struct ibss_parms {
 	__le16 atim_window;
 } __packed;
 
-struct rsn_t {
-	u8 size;
 #define RSN_BODY_SIZE 64
-	u8 body[RSN_BODY_SIZE];
-} __packed;
 
 struct erp_params_t {
 	u8 erp_info;
-- 
2.16.3
