Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+/vxUj5AjtHMbVOa2jwbWYTXKbbpm0qoavC39A4N9/1+lvjujJgamrBKOmk5HKNZKnTJ9z
ARC-Seal: i=1; a=rsa-sha256; t=1522393760; cv=none;
        d=google.com; s=arc-20160816;
        b=VPKNLdbJAoT27phQimo6GlZvjNKx9Zs36ookNTOz3yWMsIvpBHFJMBeCt3t8tJpF9G
         5UnBjqNYtCXnHhDiniJh4+46jmn3zwIg8oNvjr6z0G9pb937eV+LqCBkoMNXloMf4gbn
         JIJaUx5JcDKUBpdnSa/Uy/mayLuPItBvMYyZ1qljfwPCHAELaeZxWZ24c0ow0FYWrt7v
         YILif6VXh1LUZfq2CP6pqxfFAD/XVnv/S9/EQczhRqK5a2/D+zc+iI39ZsKOGclOaxoI
         CAsayFsbJck5XapSp4P0IXUUNYsoPSCRkSjANx/UV4H2i8LFgFVjL9M1qTD7tRcaQ+ZC
         8+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=v0K7gPs4EQ20645HuA6GZcnt0Q/ABxp+ES2WyV7iPRc=;
        b=oUW6aLWjobusiGjhPSepYG9CihugghkBjchFnFMUbZS/DP42PvfQ8EhSHIWj0xr+u8
         U1/tkmwBVBH8JBqTXHA7WyHfYmXuRjCB4LWvFRkM99OxnPRH9Xr/MwuXbbKNffWBvyH7
         nuxRfMVzjeGALeoa2bu1DlbduvB3ILYyCVI5eYe9l8PMN8+FEuV+hQxWknG36MDiL4Yp
         HMuTffNEUq9//+kevnOYxoKY8LXKEVYO6txV7sHYxVa/v012bmXumFm+Vhp3pMo711An
         3oTV4nSKawrYKeT237HtHELCWWQlgG40VgF4RwSdvZagsRcyN/NSq0DHkVBhx5qjtuXZ
         kDWw==
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
Subject: [PATCH 25/76] staging: ks7010: Remove trailing _t from 'struct rate_set16_t'.
Date: Fri, 30 Mar 2018 00:07:48 -0700
Message-Id: <20180330070842.25224-25-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:/z0342EuoOd/MFqbvrhDFchFW0SaPZmEMZd+yXmMbZrqOgltvIc
 qkbY93fIeFpIoZF8lYkk1pw/98Oi6OrKOx1uqQ6kIhq50VdBl3PgBIVM89P/o4EAj4QjIkl
 wo73xb0G3G75RvyAv55Qi9fmKvXSeVCTjxgVo5qD9hNaHTw1WSkz26rmODDbcflDLd9meN1
 Rot9cAy7sL2WN2iEt4apQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gUk0zyAMU84=:x8t9m9MBAC31rVfKhSp1gG
 8naQ6ZNxWP2+ekPb+4lMfH8rcto0ua7+BhcdZrkLHhJOPw1ixvJA0SXLYYurS9puCHp5rlCvV
 nQOBBcjwp0/AM52D8rRQntDeymSgjZDPwFXXL5MR8xeroeaUdgdKibTe2bOwaVNbC4S9eLnWH
 89GOaKEqboesx931r0yol10Bpbwto5tGcxUhVOm8j/cojRftt39I/KYE8/eo7Ydt0wNbvIbiL
 BG43QFwa98VQiVr7GddpYkDmyg7NUUPLFe5WWhlO+gUUx5biy7jxLqwSWWWHdlTQ4BkzLZVMG
 lSbEwCes4gK6RbHLpVHTEhX1cGB3GXYA0MEYs3g/fOLpnF2CY7keV09rGSCM/yJyHQlMco3B7
 LS9+ZQFkvVw7PeETXs4GO0U0H5H1vSA+8M8w88rnW5T1KhHCg6zTGlWEI6ks4+kCQNlWE5j0y
 Jaln3tScsRYzCtToBpu9wG+yyG+MLfqye4m8ICiEWsdR4fdD16lI7dQ2syO7tTFHl2z4tT0+u
 5PJKPYncdm652It3DFQIhNY75vj4aN1G7jSMCeX3zyKHVPabSvC9wxv3fRjvvvIwqn9sxpKA3
 A6X/6CYoFcM0L+cQEXntWCKRCFMnQmm/BRc/DqkV66Oh57MHP7etXZn9wYTrPCl4xxbTdvSMp
 ryzC7M7sU84kecIVfPGUAXMiytHzrOVwd0j6Po4qBOooCVyaqvZMwIB4eUYhjmdPHKfshvbZp
 YJY2D1Xi8pKFCm5iBNSEeP2Wd3p2auWWBsQ8tg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345560022726230?=
X-GMAIL-MSGID: =?utf-8?q?1596345560022726230?=
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
index 4d25801ab38e..e68bf18e6a82 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -270,7 +270,7 @@ struct erp_params {
 	u8 erp_info;
 } __packed;
 
-struct rate_set16_t {
+struct rate_set16 {
 	u8 size;
 	u8 body[16];
 	u8 rate_pad;
@@ -348,7 +348,7 @@ struct hostif_request_t {
 	__le16 cts_mode;
 	__le16 scan_type;
 	__le16 capability;
-	struct rate_set16_t rate_set;
+	struct rate_set16 rate_set;
 } __packed;
 
 /**
-- 
2.16.3
