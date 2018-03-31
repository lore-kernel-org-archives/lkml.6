Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4851ydwg3BropUPXsMiApty8AqtdYXvIreuqqksma+EbXx/scd/d8YsnR8z8vA83B7wsoC5
ARC-Seal: i=1; a=rsa-sha256; t=1522476592; cv=none;
        d=google.com; s=arc-20160816;
        b=S2We4vhhNVkAx7XVcHYtldHy6VLDAko44ZSwLNK4qpGyt09zcvh82u9aOlUrMzGAyD
         4VR3qwB2vSAS0nOG5BC57zlV2bOfJkL6+9gmvob7kWDYrqVuMsgjwJZROJ7HtpIXfIxL
         qTd+kH1L8KisNTiqNdFj9avKsolmA41D8JKVdZxcJ2Id6dxfKNOH+6mc052gvylbAzId
         +OIDqtlWKmQsxL/bNVpaFGlAwdLKbNy8XZterdyrhqW7t1eWdAIoeCAtSd1qHGsduMSl
         /bqqDKh7SIYLnPoqhL09TwICCdStpExLOrhL54musv0ZqMAXoumYugnmECiFLAxODI5E
         K4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=E8emxCDdBrofcM74gnnXHTlab4xK+EKYNyvReKka9kg=;
        b=kL0uJoOgslaEQojmxhggh6MQ6KUEQlDYMITN0TquaO7k4+jyCIn8K5XAud0scWAySF
         Cr2lmAgoN+3bqCK1lZtKWu8vRwkA04W1zY0qIQnIGhkNAA+F+YRysiqV1obuNDMrxgiz
         ZyIH7tGRAN36prtLHx1+X5hLWf6M2JkNHzaQNN6628FV5CTHAlHcWnHjX/muoq6KeuOw
         k0IbAlSfQzX/+l1u3JBHk4Rl8Yek4VjnR4rATutpZ/G4Bb2BYDLBBpvw/1rLUq+/PSyJ
         RfBSvpsf/nqQ2UxGlMt8UA7l7ccIEeeeWVeYzePoA+XwNllMHzKbRqFL4L8nlUIaXdsK
         61sg==
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
Subject: [PATCH v2 33/75] staging: ks7010: Remove unused 'struct hostif_ps_adhoc_set_confirm_t'.
Date: Fri, 30 Mar 2018 23:08:13 -0700
Message-Id: <20180331060855.9452-33-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:S4W5/EnXCOm0oIv6ND2gJof+EkChot/0GcUhWztSC1yk48KRU4b
 qxhHRHjvR8wZBhxRE6WbJzUWXAvRKOMfA2FhzKOk8fWxQRPlFFHQKqnXH//vcgrxO0WMLwf
 qpz+NxhQ1etnvLJIpldhUycmuybMMAIqJ5u05w0/GlVPMCQgeH1WZdqn4jD0+v2aIIDzfw+
 Bnq0UDxKA8yJ82OA5kgQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JDBHvwdtoxc=:ySN7urJ+nvLpPRZDhX+FtS
 tNReKUx70V87BDqDphh0GmmGMcX7U9IsrvF8r4nFT6OJzObs1LeMlvaLDEJp2XkDABZHC7BbH
 v1/1bFdhhU/sZe7O5PTOiwR0zlIFqIxH6NTsKue6iAxdjL8fVwRaVOND08j+JESTwx+b5xgyi
 nG4lrLhIUNlJaHddsFMl2NwytfGE4RWmKdtCDDRvPeOt5k8uKIhiJczLImXpWxo2XHjFzJDPq
 2n2zMBzSOjygxr6Pf9TsBiag7u67DhiIQ9PDf4s9fmkuy32mYLhsWLsiEYNDtFA0JivrFh3TU
 wcV3nJ1DEqqDaOkcjRIJ+VUbBUbDFeuLd0ipp0fRqQG9y2tfF6OtFBWFYxFg6IfifjxpajeIG
 nmffT57RcVo6ythgRnsOfaPNzbLPIZ9WlodD/nLTs/4IwhILlT7M9PLlU9SlqdfK1Em9CNBgL
 BGaPXlXDaZyC1irT0NKf1FO1J20/M34FlG4Wz5DkbOvCGYZNk9gwI5K6B6figRMMG9MwlHl+q
 jxl9A5amwJ1Yg/Axi+slIfLdu6YmxM36SzgzyjxlaB7AoVccHt3mUUkZcYww+pcwLqwYP6S1y
 dwr8UJ6MZO+ZsvW4x4/ZGt3wB1mB2+5xgl0BPYLAqgiH7uECEec7huTRrUQCNmsx0o5ghbl82
 evmlsRC3ud1MEFkLujivC657C3/ocM5RZrNDbJBYW9xgp7L/2CAn2tfw2T9WGkjzC1SrTdGWg
 n8438kMmWQZEA1MamQC3i/6OTu8hrtDveCgrGA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432415511835399?=
X-GMAIL-MSGID: =?utf-8?q?1596432415511835399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct hostif_ps_adhoc_set_confirm_t' is not used in this driver. Remove
'struct hostif_ps_adhoc_set_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 3faa28c77446..baa612236eb2 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -321,11 +321,6 @@ struct hostif_ps_adhoc_set_request {
 	__le16 channel;
 } __packed;
 
-struct hostif_ps_adhoc_set_confirm_t {
-	struct hostif_hdr header;
-	__le16 result_code;
-} __packed;
-
 #define AUTH_TYPE_OPEN_SYSTEM 0
 #define AUTH_TYPE_SHARED_KEY  1
 
-- 
2.16.3
