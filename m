Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+K8hMj5T+BNhEXR3oQovSCa0js0HTp3vbm6mGi353FUmtjMnwF7fOCV2Tppb5NdbJmoWdk
ARC-Seal: i=1; a=rsa-sha256; t=1522393783; cv=none;
        d=google.com; s=arc-20160816;
        b=PH3ZCOcMiXBaRdEC0iOup3+NViIUfWdy4YFHkT3+k1/RvAKNW05a/QvaPOivlt3Vz/
         oGf+rPo+qBSDovY+2gmgnmCK+Thxs7FuXPNRCsKZ5gAk/SMnmfMWwHVKuBnMD4WXV0HK
         qGq6SqNGrLrs+G5qFpy64ZNOHxMyCgT/GDHjao2Iz2qJCflK6wQvjq/0lBC1JoGdl+Y2
         gBjbd0ZPkh9cT2oUJOUNrwOuU+xQvntjrmtmjt4cromn5xiamfTEhsEKIPYwX9U/xdfC
         +sJV/q5RFI7jUGx9GJc7xxFJh3fnSVogHNlFroQS76x+IKwI0hXK+UOSOjAehR1bCxXt
         ZoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=j1kavfvAP90Awh8IkzGUACkRvyhYxcZweoRKS3BRL0A=;
        b=cKNrM6edG/yeujjl352khCGvNqgoEpcAYKY0SKDyD/zVFiabSHiuuLdfjj9da1IwVq
         t8uiC53IvV0+y9oaJBs+vtdF799js52fr3aYHq1yyNI89cceZsxd05SHMP3nQF+9PraL
         FZNgjwaJhFCLPb+jmqK+BJaw2BCLTKPjkMxnfN/ZHfTVNOcMcZhRDJOeuYIunl+stPVU
         jQWBBHXF0tV8cgKCzRKghxW/dfXb4knyxWtq/2/rGhqbjMGRm7mvsbCFTvFMKsDYb7Fm
         QM5GgD5SFkTCbkGMvFkoYLz8b4gP87/4SYWhupgPhGJvyzna4k0YJmGuUrD7nCzdVHbt
         YvTw==
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
Subject: [PATCH 52/76] staging: ks7010: Remove trailing _t from 'struct rsn_ie_t'.
Date: Fri, 30 Mar 2018 00:08:15 -0700
Message-Id: <20180330070842.25224-52-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:sTpyRnx+2AWgNKxJ05P2TLVCMWZUGQIJMkLz84jAO0S/G9/8tcp
 RirBih/Skib3npUXpKnJ7FghOVZWdC0OR5twXHS7Na8rthtcwAYDVYNc+tjnIfligJ+uA1X
 ee7xh1Y7wg5GhvBaqTLLFhHW6AfST8xpwZJ+0zISyzFiCfav3FuZSuP48SKkNBLc5BFN1GD
 8PI6m4KLEf3Cj8D6MBvkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tKmZbAwoNhc=:EMIknoA4AjJY/rYslhslrI
 Ob6wndz7k6Shd1XGAqlMj+YySXeQERzdUO4kH5apPFKxDK7rbQvpQkaeQRf4oRPY/pq3oQqO1
 OYWAlTGNc3HHO0ED0kzC7uEHhBcGxk83XffH0T09ymMmwJkln/Hb1tRMQpNq+kVNTkLrto+FR
 nCCYSacF9iNX1IwyReKjV0llTMAb0TleSc2yegvc+gWuw0M4UCrWPaziywoKs91xtT558psCw
 Fz8NvJI/DGB2y0ph434OLxdWnQEPK+so1hElT5mhVc3F8D96TXnTeX0mPFwidrVpkwA1K6arq
 J/7bTtlSA8Abq6gYgiCblrwBraamo6/TUJDxuHKNxjsN9rUcRbbGmpPfqPWtfaIO9lDKR/bYQ
 +RF83nGULq5XTMj6ka0SiY1GA//kvrMkfx3pC2m9vqHEheVDdWzyl83ies6OeE+PfklwhY2j/
 YGfqisXEoi7Qj5CVoNc3Ye5lhDJDxzs4u48/dxEXYmszSS08xuiwCOSKPYV7tE9dg4xrjeYm6
 TmCcaqu/8sBrQyxBU56XsgVsxF4gdfe77+U/HffPCvh1CiqSZfCaVzr7DeOjblaEOpLad+jg3
 d+X8Ji7ri47WPuEutrAMXspsJqYmOYQOck5KRFMyR6QSFJUzJK0tOpT2OUXcU4Kh5d5eput93
 sJlXREHQ2fIVT+xgOlTp39r0CTvDDcIKBllM1BFGtu5KpVldKpVlO7Ma5wNiav6SMckshOFOw
 SXJJ/28xO542j5NX8uzjuo5TbAO7U/d90N9iGZcM/ajCoQlSaq1lDmhWCU2DMHQSaPmoUKcc/
 e/KHTsJQ7TDBf8gebODFbOKk4EN4nIukfLNHiDxiXc+QukTzhxF81rFsib2hKI6r9618xOf34
 4RxRsZD4Ie7f7cfoIgb/X6L65p+1uMCOP7NuJGEza+zy8QMT2ZL/rNEkfdbU0X
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345583310174103?=
X-GMAIL-MSGID: =?utf-8?q?1596345583310174103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct rsn_ie_t' with 'struct rsn_ie'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 3ea62b708b01..10ff4460594f 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -203,7 +203,7 @@ struct hostt {
 };
 
 #define RSN_IE_BODY_MAX 64
-struct rsn_ie_t {
+struct rsn_ie {
 	u8 id;	/* 0xdd = WPA or 0x30 = RSN */
 	u8 size;	/* max ? 255 ? */
 	u8 body[RSN_IE_BODY_MAX];
@@ -235,8 +235,8 @@ struct local_ap_t {
 	u16 capability;
 	u8 channel;
 	u8 noise;
-	struct rsn_ie_t wpa_ie;
-	struct rsn_ie_t rsn_ie;
+	struct rsn_ie wpa_ie;
+	struct rsn_ie rsn_ie;
 #ifdef WPS
 	struct wps_ie_t wps_ie;
 #endif /* WPS */
-- 
2.16.3
