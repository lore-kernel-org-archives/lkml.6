Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/79lNajyRHNlIPo/7Ldt+otn0p/j378lZ6o7uEX9pSxNg458npTSOioulPe8Bmo7QdiUQb
ARC-Seal: i=1; a=rsa-sha256; t=1522476585; cv=none;
        d=google.com; s=arc-20160816;
        b=lOKazSibbsW7Mb+FXH2geXaktO9Gt+LwsUsYAISjp5s27t9OhJ4EQjMLo5KOiL5PrH
         bKry8EJ4ShxmMSfEYwlGZpe/llaGzLf6z93kaQCXnVum/onXMR5n0d3qUrQ07vyT19u+
         JKQ2Tz9QHQ6P2f/62OCPPMeUyH+E3QZ243Wxxt+Sfx759E31trngTHXDNob4DxdGitXy
         a/pNysJcCFWpe7IhA3n4p42ysWH0Crr2EmtR/VGzGHj6BYSNLNwgKo4tHGcmycskY+LF
         DnNYgVmp/4D640CdkmU+cNPg7Ei+7LHQCizSvVHhJfhkk80Le+pMczl7eI2uWeIIo0ki
         YmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=MI7FpanqsrgKWDx41Qp0BVpps5XyTS6mKhvIh2CDKyA=;
        b=qs3JzKP6ctJkid9/ARJD3I4Q3EDkO4hMiXx5qk3fsCBR1VWE+Lpk55qpo9cIPUnl/2
         12RL2Cr0/AGs7uncWMkSMjalKOrwfXHMLoB5XQpUtBwT3qmQa8wQHU6UnOzRo3Zi2XZ+
         mw9gPzxTR78wD7XE+JbXWzFl+yuW82ekk3QMfEv1U/7adkijA13ULrUKrgbWaCrRjWLw
         QPz/cJyuoWdcIEd6DEdpi0IUbzcM1/6DgyN2hnSUj8293nUK5XNI0rNM+4J+TKCHXpFp
         Iqw6JjOi7PjU2GEILfJzrPEBsrtJQC7rjW0eAvFZ5FM6cJ2YJGJOQWWvpNMz7g0hYfur
         06mA==
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
Subject: [PATCH v2 25/75] staging: ks7010: Remove trailing _t from 'struct rate_set16_t'.
Date: Fri, 30 Mar 2018 23:08:05 -0700
Message-Id: <20180331060855.9452-25-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:jODN+hSO53CZaumfnhEn+MPPWior8Qg/0T6SWex4Gf25J0tvre8
 XNwmonUcujAHhc1wzNOQE1lnnf8QaZy0pJ0a28IFh/17My1ER/HsbJmn0jvzCMJ7iEVGTpO
 2F7+rvWg5VDUMlIvEojM6IG7R+bcy6Z6BIUuRpRcgJgYCZJvISfGL2LTPrWF7QTdQ4IQoTo
 Uy7rG27kqYnitkIjTTKSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GVLNiS74vJ8=:9e3tzUnyNpvEX81iZmqtg9
 P9mO17F4GA2LUKkaJ1irc1gD/jdbkXN8qZ+OSOVPAINc7o0K5YUUABqSmjd2LJw7quMsPtsfQ
 5DCpCYYZ80BqKdgxOwnlAqim+QpDmeOhFTm9yXKUR6X6h/UP9zTJRmGFnqcdmrg/g3KPb/v8v
 nfvfRYeDWJ2BEXKtv92kZTL4m4rN+Feezawalb8vwSWF9ujNnbYofusZYpF2WU+t5XVDqmxtk
 GpxpYs9lMndBJsiRumONaNxAF5lLvYc6REu7+i0kwUzG45KkJEbGrDxdj6/0k5WAcLhg1FlzJ
 iLvaAC8ZDlhaBX2ed5VtEJFEIX74clum0VY1EsotbY4yzFKDnD5QRTSO1VAZ4XSDZJ9vTqiay
 vN3Ar8eUClwyTzBHKbjPAeWVTEjTwWfoeO9MbnTQeIepQsMzj266KgoiquLnuH8yekZuNzIg4
 aB/JKOFtjpD+oiks+8LMVd7IPWGLigCWkPpUcGJ9DpvlU8zQZgFm/jZtxcfAfmewK/N0WeHv1
 xpTnvk//JisJ/adtw4SgLDgZmQh9veCZ6n2GWEmCiF10Lgmfo/6wETne2Qr5/N6iQc4HV7hUd
 D7bptAeiLSOTKQLgI3rJLsn2L+Oq/0oq5JreoILaDs1mrJpMhW0BkBGrmrPTrYeoBue8jAAEc
 vyXQhi8XTRFwUwmIDsemt1nrWrRbhp7o81l6BpPT2EN31FdfQvobK91nC0jyZGXXqd96OxkoO
 N6vrJ+mZCZH93CX1V77M4RwrwME9K8+wkR/SYA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432407846198902?=
X-GMAIL-MSGID: =?utf-8?q?1596432407846198902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct rate_set16_t' with 'struct rate_set16'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 4dd11307e4c5..87d018f83fa2 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -237,7 +237,7 @@ struct erp_params {
 	u8 erp_info;
 } __packed;
 
-struct rate_set16_t {
+struct rate_set16 {
 	u8 size;
 	u8 body[16];
 	u8 rate_pad;
@@ -315,7 +315,7 @@ struct hostif_request_t {
 	__le16 cts_mode;
 	__le16 scan_type;
 	__le16 capability;
-	struct rate_set16_t rate_set;
+	struct rate_set16 rate_set;
 } __packed;
 
 /**
-- 
2.16.3
