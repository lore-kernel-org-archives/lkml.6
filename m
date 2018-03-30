Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+o4b/A0DPnafjZnCcBGefut1cGxu6xt+8SnDkqJOdTH1ue8+gG7xwb/AlE2ry46dvHFApq
ARC-Seal: i=1; a=rsa-sha256; t=1522393791; cv=none;
        d=google.com; s=arc-20160816;
        b=m2cp2pZmFrP+Fd9RgJ1x3O/CGGrOY6V8y5VVMyrA+jBb2JPzIpVACpqsmkIs3eQxf8
         /9NmIPbEk1g9MGrLN/0MskVPL1dKhSCriaESGNqmj9U92/VGOKle4WqFM4vD1tlaWMep
         sKm77tFkYhbKWOFS5IgosaMBW7qwAimVEkeC94tl2iTZOmFgPowmH94KFZYXvbjtmAk1
         3RllZpxbypixttJXCaSTgQp7avxe2DF5L7XdeX3BxdFO/1wl8P1vSukFmuDU/pWyJyOd
         ODi0rsDAT15+ht4j91jjJZCxoW2bCKVy2C7pcmMbrucYyBENljRXF237F/Cd6Pqpt48N
         hM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=H5r23RW3JJSfBzZpGA6TrSzgyHFejC3qPKrAw8bJHlI=;
        b=ZL1kS/ORqealOhjDCMm8OfbICp3b3EcCDmSRquAKOWS2xVMGvCIa+EALaz5p+3s3JI
         aZuC1F0KRv8NtyOCnZPgfvH04f6ISCqiEOp+xiD9W8QkrG5RQzfnOuWUd/3tPl7yVILP
         L6A6wna38ON5Gd8N/palMnYPWodAiDNdxtQM5CF52O8tARYHbTKplD6hVh2TBeIvfRjk
         z8qCxSxQU9x2GzUg2HLKp53FAm1PFN9YbxoLJUjnG2qm03wulgLpEErQ+AdAPckLuNEc
         XHdOTOo1Jjd5ydG5oxJ/1RtN6CpTI+j/uAe24ulFix1VjZ1eQ09xTaUXD5k+7h8QOVYM
         hT8A==
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
Subject: [PATCH 62/76] staging: ks7010: Remove trailing _t from 'struct mic_failure_t'.
Date: Fri, 30 Mar 2018 00:08:25 -0700
Message-Id: <20180330070842.25224-62-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:frlpwvo6hN2kbBUEoQQYJtJm770xbrYWg2ScIKrb11II5kizcc3
 UN8KRCP/R1nAcRcruwCniSnifp1iaIopBDf8Py/0zITTCMGP0eA3jOePMxIvJSB4fHLX/Sx
 MLSRD99J/ALQy3OJ25XQL4ZWzcXWlJihCQGb1QVm4J4gdFI/ZIrK6PzAtE0wbhdvq+mbtfH
 uW5ws0fWwqHFl+HIW0bDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K6LOW1J+A5I=:Ka9f1vBxY/rPuvb5KCR6ia
 w/3pFIARCQfbeN9KsqLAmLV9GpJzJJY7e+veKZkLd9En5szzR4wFdIVLhdF7kRdCCY9NZGs/5
 PtTpLBzy2snOX3JnGQFcwNi06jOi9LDzXldkqYWODonmum/vgajeT6WOwK/xMhXBnWXUs72+3
 9L9JnHrKeEruG6UQnavMy2nIQi1g8FUUa5x9Xy1cwoDucy02bF1yr+MzVTWcLIY69Sf5YqQpi
 6dYcS+moty8Zha7xsAWkfcqfQ73ajCi2+LWK0pRUpZsUUzOQmNEnmIiG3D/glj9Bc7H5RhcY+
 2BxcNmU+De9wxY11TK8xCga5re4qiWjXcP1ZhCvJ6TW22osxT6w9ycGQH9tj9bNtFpA0NrDRn
 paVigYSqIrzgx+k0Kq1C/7AI5mOAh3ui1gl9DfehDUO24FRIJ3lohzDZvNJN/JWuWljaPWsao
 j27ciR0qghPRXmDgZQ05HcM4WfUhnA3NTjEID0Mxoq/gaIE5b0KoLVFpns8kQ820/CyZXQTe5
 GXyynQYUyu5Qq+XErcrQqjTuxTfKZKwYGZzSF29b3js3TeK2bKrH9uD/WIME3DuhZoY43kcGt
 dpTGznd8rWRlVwi+bb6y7rjTq9FFoI71OB3/VCcReA3Kh+E2IF2kb9ItH2l8j4QxwFrqUQ/La
 bcPo2a1M1g3+EQhAhSOUBQzbYwQSIpF0i3bNF0qkdd3cvqy1ZprEjS/q/hXlWu4fjh9xMQcBq
 r7sb7ECU84+CQLyUSaMbczj1MSjoMqANhjcGNA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345592592264214?=
X-GMAIL-MSGID: =?utf-8?q?1596345592592264214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct mic_failure_t' with 'struct mic_failure'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_wlan.h   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index d8b40fd83b6b..fbe18ddf3ea0 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -314,7 +314,7 @@ int hostif_data_indication_wpa(struct ks_wlan_private *priv,
 	unsigned char recv_mic[8];
 	char buf[128];
 	unsigned long now;
-	struct mic_failure_t *mic_failure;
+	struct mic_failure *mic_failure;
 	struct michael_mic_t michael_mic;
 	union iwreq_data wrqu;
 	unsigned int key_index = auth_type - 1;
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 2458dbba66a0..c3e61021a75a 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -357,7 +357,7 @@ struct wpa_key {
 #define WPA_KEY_INDEX_MAX 4
 #define WPA_RX_SEQ_LEN 6
 
-struct mic_failure_t {
+struct mic_failure {
 	u16 failure;	/* MIC Failure counter 0 or 1 or 2 */
 	u16 counter;	/* 1sec counter 0-60 */
 	u32 last_failure_time;
@@ -375,7 +375,7 @@ struct wpa_status_t {
 	int txkey;
 	struct wpa_key key[WPA_KEY_INDEX_MAX];
 	struct scan_ext scan_ext;
-	struct mic_failure_t mic_failure;
+	struct mic_failure mic_failure;
 };
 
 #include <linux/list.h>
-- 
2.16.3
