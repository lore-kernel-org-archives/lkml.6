Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48kmDrEwNUvh8XcZ9aJSq/QuaJA2ajeY9tUgDXEdQEUS+XPUt9OX47J1MxppoR1dUss6JV4
ARC-Seal: i=1; a=rsa-sha256; t=1522393784; cv=none;
        d=google.com; s=arc-20160816;
        b=PfAoH/iY4TbFPp4PvIoxWIXKR+p+C+xo1b1h36/4DByjjvTxZ0s0jSfH1W4ob8RgIC
         7YDBRuMzdMKuyiZexjpfIxoVq9pnoh1VmeJH3lG4Ppq9H36gTArtcoLc8e1Oe8UKIRWG
         C2tCnJlYv+3jiyIxapPWTUSh2Mw+Xx7k1bQvuFMQo4xaxut8wEOrdR0eOmQvuzCk1Ely
         BkrV+nz2wx72xGpjwhGb9gbHdR5OokkfOTJzemli28HUGjfw0C+vi21PWwmgHYJfvqPg
         v9QM/8MXRi+anMwoZUwIzpRz1BbnCh/DU6uZx1npimnojCZt8aGb23dzlW0eaDMV1q2m
         Oriw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vWJ6v4njFQ2sKPugg6C4apAdHYPwQWPWKW5FiTlHx2o=;
        b=JXBj5oe9XxBNQSBpLK3Ggqs707rVfes3Mzfg4PoUbsj4VDFN4IuQeJlNG3VOzwunne
         DS9DzLpmZwaOKAdPtTdt8HPsEMKr8Bn9ONnKwEJptakqinnm+IJPD5DvTefff/cMxxxt
         CfVdj+MKMmoKUM8kp1QkT3JGcTO3sQpLIwiSOCpzGyENnRE0Ecxeq90NeVZtBD90SHlf
         ice1xTLBbWzM7JFNnsyDXQJ+uGoWcQdr8Y72s5IA0TrYWR/CehPJVO/pUBUYJwsmAwph
         8nzgyNhy2RXE/PwwPYLHu+6tAHWdBQEV9fk5XNfGCT64h8I6TMkQVJf3zyBkCdMceWCc
         KzFQ==
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
Subject: [PATCH 53/76] staging: ks7010: Remove trailing _t from 'struct wps_ie_t'.
Date: Fri, 30 Mar 2018 00:08:16 -0700
Message-Id: <20180330070842.25224-53-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:b934rH/AhmEkMDkfN8+ViwrnwFUcLTIi0SHmqHbLnzNqAhC8zlG
 8l0LiADI5nMvKr2Diysbj5AHDOctDA/p7A5vv6MT1NJQSDy93ILHLuXi/YOC051vo1bOlEg
 XSWycVrnw+W7dI+OUr3PkcvDIB0EV7SEnJArhnmXHXYmRZvtBQjvbOLw20hY9QWJAvUyx2y
 iNfEBCGo9J+a2jT1O3kiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3VQNnfBJous=:0G91bch2igcqKDjhWROtnj
 TYbV9RrI6ORoFAhyxT0Puk3nTA7ia4rmvMMMhI5245XfkyBG/wGJYNlXQFlF5/KatParOgJxP
 BRv3y6v2cp/Kw+EwXY4W1Y0NYWgT84L6a2MBdd250PIVFkAOTYdCwBYhaqP6nF0tY9s9MpJp+
 RVSuVz8PLYEv5cQEdqiCE2SCO9IjBlVsScm126iJg909DNHSWqXU+ivPqZPm2UAzeJP+AFrH/
 yyL06gtEH57Xa+23XAI+Po0s8SjvHvuh2haJLzWsumZx67zYv55TZG6MpZd8F08NzpUgRM9Xq
 6C60Tt66494qj9mbbNQys6mz4jWBn0Hh8Gv/mDWy6/ijy/q3OVbPTMIevU3/XdkamTAQqgoen
 7GVXujZG1yGbIelJjlPFQ2rzu5Jx/JINXjitFPJIC7HX5iZr7oEuOd9Utz+tMigezeQ85dkyC
 T6y159GeMvyLiE0VnWCPZg/WovLRqn6A8SWG4ilPjOnDcxVMV9BxOQDKVMuBC10LFK9mbGKiZ
 /bM55mwanDu4y7nYjHDaum94WR0PLdo6CSnrSnAEOIWAFNLfrnkMgzlz6wL69CG0FGyPXsegG
 +Xyffv+//HKBPe+8FJMg3g9dTvas9mLMasH4osMwyvuFLbTaZ2fFZ+gR1SnNjE+22juyzu9I3
 Va8mGpn6TQaiGyc2voqdzJrlBvIAGoBG46W5ltVuH02QCb6NT8wfq9y8ihvPNPkpkGc5z65Mu
 LnI09b8mrqIa0WzTCNH6N/6ntapcrLDYqixIXTuTHxJdIjVCR7S+bSRdumbE5xDdQihQe0TwA
 sQnHJjgkaWCXGDJMHC5Nn8LU/V1HiSfYdUeV31yRr/jVVdC3ZYnZyZZwYpeWYuqXxcWDPbAzW
 M2Ik803e0skOOqzfOrSCNY3ViqmF2L6uLUNsJbcD1kn7t6hHmgnd8A92ip/hyq
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345584482550488?=
X-GMAIL-MSGID: =?utf-8?q?1596345584482550488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct wps_ie_t' with 'struct wps_ie'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 10ff4460594f..30d81f9456b7 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -211,7 +211,7 @@ struct rsn_ie {
 
 #ifdef WPS
 #define WPS_IE_BODY_MAX 255
-struct wps_ie_t {
+struct wps_ie {
 	u8 id;	/* 221 'dd <len> 00 50 F2 04' */
 	u8 size;	/* max ? 255 ? */
 	u8 body[WPS_IE_BODY_MAX];
@@ -238,7 +238,7 @@ struct local_ap_t {
 	struct rsn_ie wpa_ie;
 	struct rsn_ie rsn_ie;
 #ifdef WPS
-	struct wps_ie_t wps_ie;
+	struct wps_ie wps_ie;
 #endif /* WPS */
 };
 
-- 
2.16.3
