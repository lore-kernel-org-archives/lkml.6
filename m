Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+Ba3Hci0NOqfX77hbvIjJJ2RfgKECvXEO4nHWuB5wVGRJ4GIGhelQ3Edd5i+xOqgCu7jf2
ARC-Seal: i=1; a=rsa-sha256; t=1522476628; cv=none;
        d=google.com; s=arc-20160816;
        b=OI1A4hOF3bduO1WX/T5uFwpYGIc+jM/ffCPrI71NyJQ9YeF4VzGUbGVApq6S8K9kAp
         UktPZxOy6lvg2ALdD1ro94YIqYYFwmZrRq01Tpa6gFNCihr+cav2sRxFJEANmcUjvgXo
         WG0es3o6gnEg+obn6BAU6mQeSheNkWoH2EhqJ0SpiiRHZE9V7mz2nQOqtWOXt2HJb1lP
         3Aa9Bi54yxsdBloPHRjO6K+MxZ3Qef8f1c4ClNcFhjdFkZUX7GLHaURho2aJcsg7xdDn
         OAKYxvxJUjfqrFSMicAsgARR2nxNckZ/SqE0m44jyAIJ3GDlOY9i5vyIn1dJVnkU2PIm
         +/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ub4F5YBKwrkUjGvRgciZzYSd51Znum3Wf4rXtZfLIws=;
        b=Wui6jam0NRNCzGO+kSIBKich1nk1Ei30uZlxF1dY05Utq/pIMe+PF7OVmNuHwVIGsx
         eh79fOdRqOQUr7dY7JzSomFRvekQuG4Mh1+qtsoQSEHAoEz/iKXtJw+pReZA5e82hswr
         e8+uDwP7LRqxbyAJGg3Fm56LOjK9CMEkWM4YrmiDcLIXwDblL7s8B3wo6vViQaErhYpd
         aHwAG3nycMO4mMXszRNtfVckiS3Sh+fqqHjo54aroF8QlmY0s4TV0EjIsg5X9VrbVD3e
         JvHNIyPZ0R0JiOeGAdnKUzXkXMJY4x/AwUkP5XNBJzQPy9EAm6v4scAYAOhcD4KzukeF
         4E9g==
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
Subject: [PATCH v2 73/75] staging: ks7010: Remove unnecessary casts in 'struct ks_wlan_handler_def'.
Date: Fri, 30 Mar 2018 23:08:53 -0700
Message-Id: <20180331060855.9452-73-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:J1kI9UBDq47sOJb/IWUv6xifc9jnARJbCl9bFKAWJ5wti+hbHLu
 HurJ1gS3ZmMR88U9w6PgpcCI1dSPDAGrHlUsADT+sp+8Lx7vFb2wnXMXWcQJPamONKQWz5u
 eT/7NP1DWI0RRWrnwU6GoJklQb4yLNFEgN1Hgt9xwuWUQOuwGauLisoRLriEYWxHTywukL6
 avmrnFiCE7AeFzI1KIPDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fogHHfDFIH4=:OARdgac2KRNEmM3g66YBKl
 2V2Hk02d8rL6TJdZE6WFc4pU+dPHtRY26dc89AWFE9+eh283NTwupVY348UfaeXMa9CLAq3e4
 6vEjKIpRj0kma2wdn3qDOlTmMdp2nYRL9Eat7H9UVVXdgaJkn7cM28W0JnXj43b1DWAg5bUuD
 URShxl+xEmRbPG0wOMAmlUwlAbP4ifcxf2kTPKThk2Xsf+gMkUtQF9KAFvE6Dz1C8DvAqELiq
 A3zheOO59LF6QgGhFKNpMmVZisUzpH8ks4RNq7OkW1SUSp4jknPfBXXKZc6eGRGgOBs7bVU15
 BS3aC+1c8MDFP/MDVNrdDWFzOXnEfD97vV2/iVEeJSQxRv+qd1UL0gQ+0dKzLqZnO27ibVLCR
 1foyrAJYy5YqmueZD8kDRuDLO6z/6jjk1F3sxyAQgRJJGCb1bN9togUAuQ7qiSm1c7/z9IcOm
 veWeMOdO+DFhNo2S4z4gAk3vBqe2gkvG7XF6YLlBFTTLYF77oSaOAhxu69t7bAMXkm2F8EmiN
 WZimHk0/QqHzbsHP9J2dniUvd+EH8A3qfGIigQSaeSkFlV+gykUCWY7KZ7yB2t0rNAJYGbwyd
 xbLdmH8WdzNj39oI4fvTvHMgC+tanlCRAEsbFPMIpK6GFLOUa5xCEFBrcVCYzv3WAPxNANjXk
 YjYaag6r9Zcn+BWwZip0AJT42lkHxX0gqcVjB9MWL3N3mArPFxuHbUD4xu/7ozt/bSwSqTq1e
 S3G4ZBaC7AapyBXmqoQ0AJiGpWFSNYcXMbYgfA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432452661935521?=
X-GMAIL-MSGID: =?utf-8?q?1596432452661935521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The casts used when initializing members of this data structure mirror
the types the variables already have.  Remove the casts.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index e1773e57cbb0..d6fa2bfb6a6d 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2705,9 +2705,9 @@ static const struct iw_handler_def ks_wlan_handler_def = {
 	.num_standard = ARRAY_SIZE(ks_wlan_handler),
 	.num_private = ARRAY_SIZE(ks_wlan_private_handler),
 	.num_private_args = ARRAY_SIZE(ks_wlan_private_args),
-	.standard = (iw_handler *)ks_wlan_handler,
-	.private = (iw_handler *)ks_wlan_private_handler,
-	.private_args = (struct iw_priv_args *)ks_wlan_private_args,
+	.standard = ks_wlan_handler,
+	.private = ks_wlan_private_handler,
+	.private_args = ks_wlan_private_args,
 	.get_wireless_stats = ks_get_wireless_stats,
 };
 
-- 
2.16.3
