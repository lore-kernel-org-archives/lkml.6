Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/jjose5u5fi6YrFDlZs0BY9Xtvh9IPIiV+kx53uGkdraCR8kCSU5ifyjwjI7d0u4LI1gnx
ARC-Seal: i=1; a=rsa-sha256; t=1522476587; cv=none;
        d=google.com; s=arc-20160816;
        b=SV7daD6dYRqsuysX7o4wpJe4n1AQNGGPWLtKzKGr5jw2IL1Nw82l0MTdzLfL6V6lWn
         SURDWZAPKxPc2tb4kNqsZ4lgvGrzHgZ5yLe6fplt7FTlE3o6P1G6tTzbzAdpn8e2Ca0p
         Xk0LpoyxO39XcbUGtN+lE5KJW9KfHVkFmKVxpcn9ouFqpIAhn3SMUp1kJHi5poT22uoI
         8c0BcDAalwixc1/S1ArXVYDsPiph9oWMlp/MaPra7+TrRpNu655Xw4zZi3aSwfn08/7+
         D8Xs0VK9JA7CQOhV+7di9a/cAD9T+IjEqOyA/bAtXr0U7XKy/110Q+BKjzJ9tCzO7DKT
         Vlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=kp8ck2neYG6tqdMprKBKIr1KIi/od0qiNXOvprbdQTY=;
        b=xO7JZe4RZn8LO/iAfL5ljcmkKWYgaDavzT7jk8rRnr4Tuxh7ptzpum0cAReUZTnwsY
         5Qtn63yinY5Mbz9pWq6It48YIlx1nFNG8dmt9w9NQQa3Gb8Qkk1Iz5dJ95QozzdTo/Ct
         G1bNEb/hdAXCbkJSx3tBMJznW03FFB5I3ztNFlFnkun24gWPlRaVn7MBoCR8elelOJm9
         L3/uXcHrn7sKQwUKYBAbyYaf3ffcKxD9bRiog+O7YUU8X9Q/zZVIz26yYbYaVEqKFX/U
         56oLOwvDWQaAA8+QMNiuv/QPROVudfSwyTLMfbGKjUhvlejF/IUc95fd/yc8au0kXLvz
         LeTQ==
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
Subject: [PATCH v2 27/75] staging: ks7010: Remove trailing _t from 'struct link_ap_info_t'.
Date: Fri, 30 Mar 2018 23:08:07 -0700
Message-Id: <20180331060855.9452-27-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:w35e6kUuyBBbNJAwmMIGE2DgoVcFgejDzluhRwsT4yuD0BbyjNd
 cM2SIauhbyorC362YXy1kHL/Fv7bBVgKafZM5RT37ZggNrDEWp9W3OrCJYsRcqYc9DtZEp5
 LWJDwpOiPCnWrPGC/QG9KsQuIe9i1uIUmFKN2Qi1ebqlRlHNtR/9OHH0k1tH20XoRkMUFHq
 gx860Wc157P+DDGDB+zzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MO7Hl186nFQ=:PcKZKZ5BGQCQxOdd3mKGu0
 QPx/xMD3ksL8BeBBunOyd3wDIO32eyzxu8DmxVOpauKah7JP0R6hi0yY83PUZqMJy81odrH/9
 26Eq0X//Ord+DB3Rc7lhcbKC+YzD0vkpgaWCXEZLHrGfskUrx3qoRs+iZOgSa8/+VM1zXX+jO
 xXi99y9kY6Yl1QXvvMiihPDhqOW/iWbMvYCWsAVjg79ztBLHCxNmh/cEToIiLf+21GYhdDCma
 qc3vRrwVGrIGqo0kCerelvZP9hDzt68SJTw5aYmZe0DDlglyoTw26l8c5xpt/m2DmcU10XT1T
 sHCvUGR/2b6imvCSgTiMTsuZteMwCTHw4Oo1HQNo0dxQXKbXrJhgDwwLpHTpDR/KEk8vV/CU7
 x1x7LMh09qVe0xzWJH/Oy2Xbh9SBndwJSsgQzlkgISeecgSxRZUadz6Ho8JsdZGFJeHowZ+Be
 7YXI1Ryeq8BMgoQJ0YrRw4tXHCn4XEu+dKYKvDz9+snJeeXirFcfy/p4a/UKOjigIur91vfcf
 GOTRyJbUJbA8xrBtnNrkUKW3VeVURoikqtR6N1W7sLz0nz2vydtkInAcR75BTJ+TOrInqEcOs
 RE3KwznIs7fWmokqjqNaCDBCID+28xgiEv3QjwLYXJv9CZOcQFumwgGLfxGmDZct++93gmucB
 7bz1gHm/KSh5JCYUOGXST9qgB8xOIdaFQs9l91U01WDmcM+Rrl0995lx6WFMynQcsb+UqVzSx
 aJ84tCwn3bx/oY0kXAITG2wq6GYwJV3dX0pwlw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432409995580692?=
X-GMAIL-MSGID: =?utf-8?q?1596432409995580692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct link_ap_info_t' with 'struct link_ap_info'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index c9cf61efaf5a..27db9732d9c3 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -107,7 +107,7 @@ int ks_wlan_do_power_save(struct ks_wlan_private *priv)
 }
 
 static
-int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info_t *ap_info)
+int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info *ap_info)
 {
 	struct local_ap_t *ap;
 	union iwreq_data wrqu;
@@ -745,7 +745,7 @@ void hostif_connect_indication(struct ks_wlan_private *priv)
 		break;
 	}
 
-	get_current_ap(priv, (struct link_ap_info_t *)priv->rxp);
+	get_current_ap(priv, (struct link_ap_info *)priv->rxp);
 	if (is_connect_status(priv->connect_status) &&
 	    is_disconnect_status(old_status)) {
 		/* for power save */
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index d61225958df3..f64eb2e1e947 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -258,7 +258,7 @@ struct ap_info {
 	/* +1032 */
 } __packed;
 
-struct link_ap_info_t {
+struct link_ap_info {
 	u8 bssid[6];	/* +00 */
 	u8 rssi;	/* +06 */
 	u8 sq;	/* +07 */
@@ -290,7 +290,7 @@ struct hostif_connect_indication_t {
 	__le16 connect_code;
 #define RESULT_CONNECT    0
 #define RESULT_DISCONNECT 1
-	struct link_ap_info_t link_ap_info;
+	struct link_ap_info link_ap_info;
 } __packed;
 
 struct hostif_stop_request_t {
-- 
2.16.3
