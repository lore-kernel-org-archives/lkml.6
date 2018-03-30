Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+NM3lxbW7JdgEYOv8a6y676g9FcOwZQdUbIWFsQc3NgM+BxCLP3oz5nXvgqBxdJTZESQ6u
ARC-Seal: i=1; a=rsa-sha256; t=1522393762; cv=none;
        d=google.com; s=arc-20160816;
        b=0kkX7w01Nsz1+E6yqsT+y1iHzdzPq5L2rv/QMQAABhflBj7MWj7+VY651sG/pj9CNp
         TTUTyp1ij2/MPoCt4697mUXoJpt4ZOrs/9V1q2LnDe2csQsSCA/LDQ6ErQHseigpSTBO
         meb8E6X7wgDHYkM0ZRERp/+Y2DHB2VKx43oJDmqXV5e2X7TTRsbKa6ocXpdYvokT6UeG
         0+x42qLDq4CtABXQfN8kYD+IybxhHekNFDaP+1VgeBXPLC1/spbMOnMTI/EgSepCIeYq
         vFtpehCrEQbchmeENKIJdlG6TfXOvRNdAiKvIjo7VW0kA6LGoYxmn1cqpxfn9ldVCfiC
         4cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=D2lCCx2eRDwQyJNj3326TOfwZxCWOa1lOEQsvFsAvnA=;
        b=BAOLVtJk9IE5+NWnTZVotGLLmwSjgLzNI0F8vKjJNN3UZpPx9MNBsk7aEBte7re9IR
         NfDt8pI5STTdnxXs2V+c3k+3MGRa60/X9WaW4NzMdUaQLtjulWc89Mb09laQLRogAx0D
         2OQSbvqN5U4FbhXMOYwKzmKW2QggPZU4hQQT9mAvTSY4wCOCW2l75XQqRrl76EC76tWU
         71E42yHhBN4dX4WhVdyRAmzLxn3cNBuqzEyagK1EkZHGTrY6mP+jyin1idhoCVzIdi/A
         /PctdfsbqwCu9P3gSBuiGqr9zUbs6GkHgeNidqoXGRrLHhsviHJBNUt1OEFnSkQlc79V
         mzxw==
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
Subject: [PATCH 27/76] staging: ks7010: Remove trailing _t from 'struct link_ap_info_t'.
Date: Fri, 30 Mar 2018 00:07:50 -0700
Message-Id: <20180330070842.25224-27-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:nrDOv4ldp3Y/RLtYGdypeZy49L775XfMNtrsT/zd9GFnnO0eVZH
 onYmePbaLPamw+5g6mUDAknNy2dRCn2RfBeYwDQy63Gt1BFqAjjftC4qLJsPm+ltjH6fIS/
 5SuyMOXiL2e8YKpD3KbBkkdz0IMd5evU1vhgRrLKOjayqoAFrWy3ujXnpBFRRy2J+6eloCt
 eHQx+HVd4HrSp4p+pHYXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WZd2wECWLvM=:6LeoPBc4SfvXffHSbwHBh6
 8YMEufhyttVuwKcFHFVWTqs3ljJzat3JwAkjSEpWt5suTEGZ2D65Q8LUd2x4/ngC95RQbFtxJ
 E1UCCFRZUyRxK2uW91IPj6pYHVgCY79R5iRmvMxLHCuuO7nnIqSBlcQqO5rd6gPN+eAZtSbI+
 YOzWM6RO5NHzpPasRrfCjNz0fIybrxQp9NW7HyXIzcYifBUGzrV81g+gaabJoj4MnXnNs/bWy
 yD/VOGWhNEFMJmepy7+LqS8ubBbddsW31bT5WXvPG/Hsg7EaqNZ1GO1hmVPYwnNGHuyw006tO
 cAH0leC9d4ZEye4I2z1fSZiKThiy3s/kxxPkLA4gOagU1TNO8CLhaiYg2UiJ0elHnDPvYPrHZ
 6Dx6rZSiGC9MFpvDfz3M1DlNb/lRJuSov+66dns+vh7rCcOYGm565ikRDWur5kLhBOdNujmrO
 f6g2tF6flCrIRnpXAWXLkfYKIF99Ko+57DGbG1c27dbvWGgys43RaSKQa5b8B7RVNGpVi5VM8
 oNEL8fiorSkuUraLnVfKvoG6a3KMeBZjRi0eYXc8hKZU1YWDjDW7d/kCbu5G+5BTDMyWeTKNO
 SR0b1b4KMqj4NyldEw+/m/9HdMJtaJj3bVaHZgwB9/xG72S9MTLSHuzsdm0lurWU1NIpeYAyv
 oGOyrpt7euKlF1WlO76GBFJUiNgp1LXG0gM4RND2UtnBE8rsfRTKFi0CTl1AsFt3UZ6zwylkT
 hxqwJm4+lVlbaZWGs6rbsIZZEZoAnAEA3oI4Wg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345561543790248?=
X-GMAIL-MSGID: =?utf-8?q?1596345561543790248?=
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
index fbc8e58eb544..46b19ddd23a0 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -291,7 +291,7 @@ struct ap_info {
 	/* +1032 */
 } __packed;
 
-struct link_ap_info_t {
+struct link_ap_info {
 	u8 bssid[6];	/* +00 */
 	u8 rssi;	/* +06 */
 	u8 sq;	/* +07 */
@@ -323,7 +323,7 @@ struct hostif_connect_indication_t {
 	__le16 connect_code;
 #define RESULT_CONNECT    0
 #define RESULT_DISCONNECT 1
-	struct link_ap_info_t link_ap_info;
+	struct link_ap_info link_ap_info;
 } __packed;
 
 struct hostif_stop_request_t {
-- 
2.16.3
