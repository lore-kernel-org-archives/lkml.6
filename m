Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48cW6FLIpeEy3HXz1NlXBsokrOeXlellnC509ST7seNT7gRYfsihEAjBUMo+O85UOiYafAq
ARC-Seal: i=1; a=rsa-sha256; t=1522476599; cv=none;
        d=google.com; s=arc-20160816;
        b=PqESu7r4cfenrdbWjdD0dsrr9WBz+EhOIsU9OLRzBP8yPIdK+4PmV7Rc7zhYFH8Jd+
         QyEwta/LmM75CsqdwVJjz6TwuJ0vrdED2fYZ7sp/GVUcNwNMAHLAhXB1uBjmDfPLIek3
         vX1qUh96cR57I31/kHzbLPvKRIG+rybQO6P78ciW1GylhdJ2ZFmFnUG+J8auT/CZSzIT
         qGvW65wpkqDcyCU0/GUZ/GTrIY1rlfBGUKEHA90Q8l7DO2gu6Jx4uuVrTVgSduFBli6e
         0RG8Uq2B4Uw3alzel7yuf4G5OeTz3h8RvYsx/JUCW9QZ85UKwfKhJndn/3BzAB6tI/wY
         sWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=icN8qmZkuqhXpeY/tNk07YCnNGYff6vJUA0Gb4GLdr0=;
        b=c5CZOSOY/rsoAP+eu0Bj+zioil+3VRVWCNuh6t2Dm4rG+vA/aCGCzdmeppCQRSYhyy
         bdDyiFcGvxxRo3vtAVnABpwhs1G/z1BJ0mR6+EeR23NDr7t4Mj5ifW/RkJyse1Fqy7d3
         sE/fu1GkSJcOgb6li/zpYx8H60yRKtTRcUZoH7T/ts3s8Xm1nD7bmccLoAye0lyuA+vb
         4wjaZAQC2Qv3ZUQlTRK414GlbXjbKdQK1ptneHfPYRqha2i07s2W+lKXkt2wYL3qXtBc
         5/RKciGZqKPs5YdvKsiiEgvC6UoQV9mInK293l+Kk07ch06dm6zl/ZhVQcf2dnZoIeJI
         MI0A==
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
Subject: [PATCH v2 41/75] staging: ks7010: Remove trailing _t from 'struct association_response_t'.
Date: Fri, 30 Mar 2018 23:08:21 -0700
Message-Id: <20180331060855.9452-41-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:aRxcuphD7ju5ZUdNztX7Hc6ShBJ9c2kIM2MHCVEh3mUrGrvwVfC
 +xockU5n0ZTDHK7uJmoZ0UdTjPdJgLhFsinkw+qusN2Xktde9NFNZHeNpGi0q7reL2uc7Cl
 J3oGPmvHPJnAPVRSXMrdPvayzW4GSEJk90WjyBfkTSb2mCTyj35NQzeA2nJ+uMBql66ZFdF
 7nNp9rfIlmlDf31lyFR+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iwrUG4eCzcs=:f3ZLZPP8eMzr2bXR2NDAxu
 VJvV3tS+N0J/7pd8XaNJdTJmxOTmuq9DZ4N3QN1Jyd8duRlViT+rN8A11cvET6E3t+nWxf/wV
 SWIhY9SvgXCwAx2Qf0YJSuf2HKaOvEBTwsKThNxe/7eOgV8vz5WTb80h49MuGi7OKtsSCxG9Z
 6AR6IAFTXSzxLSnW0PCXitC1ilqCp+XyB6ReBlAGi6zgK3G3R2BioLpw7+43W+sp3ysbTw8hx
 0UYe3ajaSMmho7flBsnmo0DpWwwwZzbTQSsb4WiBdzy9QwgE1CjjlTgEEyf7hw2yW/PpjHmu6
 z9eB+Rnc3JtvB8GEy0kIanA3DEm85GT8hBiXLYDc19ITjhMGqVr8NVuj6ZjKBW5dJZHWAjHey
 BjOkTfVsYxHQOCONI4xFEV/vtj8Nwnyzyhf/pSc6hTk5B4sSbJZFR+QijKdrdp2+fK6ePKc0Y
 ZyT5O0sZOI9vLqd/9nPH7CuRnem92FYzHSP542JExmXdA7q5DG+lLPlw9wQUwhUH3I94tqzLM
 xo2j/uNXz1OjfGYHRR1avVAQiFN/r8LTghceVZEPvrJfTBTjuqZe5dBI8ebO8MfIPZEMmy3iU
 yJ1IkLazuSXxEJeBNaW7N+W0g/6d5phFVqJdNydr43Gry+IrLicRzxa3F8QRf0blcQPa9fkhr
 EjSdnUsobBPpXc2+dkVcwBEY9t3rpEngte4k0DJEXtvKF+lzFjeJ100C9JfDzcZ5YyU0HWJEs
 /8HXvUov8NDqfSYXqUJb0FPI1ZHkm6+rv9X1+A==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432422420461565?=
X-GMAIL-MSGID: =?utf-8?q?1596432422420461565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct association_response_t' with 'struct
association_response'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 43d06fdda9de..e733a77269df 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -864,7 +864,7 @@ static
 void hostif_associate_indication(struct ks_wlan_private *priv)
 {
 	struct association_request *assoc_req;
-	struct association_response_t *assoc_resp;
+	struct association_response *assoc_resp;
 	unsigned char *pb;
 	union iwreq_data wrqu;
 	char buf[IW_CUSTOM_MAX];
@@ -875,7 +875,7 @@ void hostif_associate_indication(struct ks_wlan_private *priv)
 	static const char associnfo_leader1[] = " RespIEs=";
 
 	assoc_req = (struct association_request *)(priv->rxp);
-	assoc_resp = (struct association_response_t *)(assoc_req + 1);
+	assoc_resp = (struct association_response *)(assoc_req + 1);
 	pb = (unsigned char *)(assoc_resp + 1);
 
 	memset(&wrqu, 0, sizeof(wrqu));
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 08c75f8a1646..d8ecde16ecd0 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -380,7 +380,7 @@ struct association_request {
 	__le16 req_ies_size;
 } __packed;
 
-struct association_response_t {
+struct association_response {
 	u8 type;
 	u8 pad;
 	__le16 capability;
@@ -392,7 +392,7 @@ struct association_response_t {
 struct hostif_associate_indication_t {
 	struct hostif_hdr header;
 	struct association_request assoc_req;
-	struct association_response_t assoc_resp;
+	struct association_response assoc_resp;
 	/* followed by (req_ies_size + resp_ies_size) octets of data */
 	/* reqIEs data *//* respIEs data */
 } __packed;
-- 
2.16.3
