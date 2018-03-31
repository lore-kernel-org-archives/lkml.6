Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+Sfir/hnO8MtfnwHUCaztuhHF1PKPkVzgaIlJrGcUdrEDOlQ49VwbDj5mP9CsZVdKdqNha
ARC-Seal: i=1; a=rsa-sha256; t=1522476588; cv=none;
        d=google.com; s=arc-20160816;
        b=ai8lKw1uFrkgot0lf4HIg7aXH7IbUbu6iBxQttjUuppcmn3A/wRfAYQHS9X/mH/lVo
         l68sejv1Sp+VEqVrBd+8pfiUcxfYYG4MQhjAVe4WgKVSVHLnZu3Q6/fCnbl/ea5RRlC9
         TuEMagWfeWDp+uGGR4pkf5XFrjzl3bErFrEXipHo1ak1Erv5yJiafH5TXMP16owzx4qj
         N7vxKILzdK+5JUm72GSPGnePbU8W2XNpM4Ou06OBrpOpzyjODk0bscKx38/d1KbYK+QH
         fDOkqNE1po7yznGR8k8lrPMOFQbg3mGFGYS4rJg4mS4dXL4Ukez+Ql+2We3XETicfSOv
         W7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=OHxI46kM26QCO9O2j4OAUZo6VAHhnfarXwX4sU09QBY=;
        b=0jN7h7r9s89mNGJgJg7yuoCjIsakTyvIgu1L5m0+nW7abZkOJOOVbglZXnSgyXRtxH
         0IcgyGY+wVQaK4L4VnSzwh81NsOeMR3xdDa3Ma7+vLXeoHhJL6BgBtvvuIF89ynAyd7z
         U/5xAiI0rT4cZ9ZPIl0sOtzrP0VBdmfeZng1ueQDzvz/nfiBnNzCEcDlatjMMfcDoCOv
         azeN5BauLflC0skb+dK7HW/PjsPnTogX1IoyGtqiHhyaCo9NI2MBgcyy2vfD26rdbiiR
         wczNlf+3jU9PrCfyjnHA5bQdg8Chwnlkoer5BBFtjNbdtnH5oU1+jhmQ/SOZzqD6GGDL
         Hkmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 29/75] staging: ks7010: Remove trailing _t from 'struct hostif_stop_request_t'.
Date: Fri, 30 Mar 2018 23:08:09 -0700
Message-Id: <20180331060855.9452-29-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Vl7CNPzoqnQR8tzJIy+8bhn3gu3ovVRJUo6b+xLxOmQidI0asSB
 f4K0SxtEXI8MrDiAiS9dXEZdR5VWAIiaZobti4pKPQ65PNxEus0U8Uis21p4rxMrI5dzGcP
 h7Gd1zLhQo8QLaOQ/J8DuiU71s8WkyztxLCv7H5qtQihA/8SpTXjDBTnl0mR6f3wnPg4jWc
 t9NqT9YRLB3Wnpb5ETKZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H4geki7IZZA=:meVunzwroaFi032Ou2FT7s
 ifQt6IuiOZ1KJQ6vKDh13aJ5O2xqSpTOQuNcFr5ChjiAXlbxwGu6HXG0M6Z2nZA+kcXj0dz8A
 pHP2N7RgeiXsGSG2ReLfpez/p+ifBLrc9pNkBlJzZd3oizfNtJO7Dh4I/nZGyXmf3VRX4Cx+6
 +jy1N2xeWkzwXTVZGzLfzqx7hQWVgP7fyzAW7g8J+WPyZCE6cthHDZgeKXRIL9nxGuaJlMSc7
 Qe66iI/WkBEDNHglaOSWRXqXopj2GZou8EH/jKAIhi9RGU7Q31ZR7hHHATbPvPy7rn/dLVB1U
 WFd2Szt/eF6uz8Hh9GiCTM1p7AnBE9HRUB20X6D8yoU/2Yo+Uk1jutR04vmi2Qw7BEmo+qrjV
 8DJg8zy4gZKtbykwWXAzVwK3F29vH0bpCM3na7+qd8qhXxnu8Qn4CNbfkjOns7B4YzpPat1h8
 0851guyjktU8jcOLf7JsYMQZVQ+fdKgMoNXWRJlJNR6lfzkwiyIu0He+ShoD6YUYxZuY7WSAA
 0nxn7F2opvxjOIbvG8ALhAP1YyTGoCKStDHsfyQpmiK1QyUlZRKRHlgikyQW5i8XqFziVt5sb
 aX2ESfJop1luORdsHPfN/Qov2DRVKkx1IsYpyx8X8wldz4IP2WxpwLnttwnRqb0eQOBARdA6+
 HNFcwqkZ3fmIfnlqTgSm1gjdkEDSV6WZpAbl92yK44hVoVD+eJzwo01hsuutpjUEwSxoZMKTp
 LdEHfZnjQI6JNyIYK9/hIBA5NMdBmZ3Trcj8Ew==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432411778275256?=
X-GMAIL-MSGID: =?utf-8?q?1596432411778275256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_stop_request_t' with 'struct
hostif_stop_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks7010_sdio.c | 2 +-
 drivers/staging/ks7010/ks_hostif.c   | 2 +-
 drivers/staging/ks7010/ks_hostif.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index b8f55a11ee1c..d083bf8d238e 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -950,7 +950,7 @@ static int ks7010_sdio_probe(struct sdio_func *func,
 /* send stop request to MAC */
 static int send_stop_request(struct sdio_func *func)
 {
-	struct hostif_stop_request_t *pp;
+	struct hostif_stop_request *pp;
 	struct ks_sdio_card *card;
 	size_t size;
 
diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 27db9732d9c3..5c78f94e6f72 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1426,7 +1426,7 @@ void hostif_adhoc_set2_request(struct ks_wlan_private *priv)
 static
 void hostif_stop_request(struct ks_wlan_private *priv)
 {
-	struct hostif_stop_request_t *pp;
+	struct hostif_stop_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_STOP_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index bb58733521c7..f3c453be9701 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -288,7 +288,7 @@ struct link_ap_info {
 #define RESULT_CONNECT    0
 #define RESULT_DISCONNECT 1
 
-struct hostif_stop_request_t {
+struct hostif_stop_request {
 	struct hostif_hdr header;
 } __packed;
 
-- 
2.16.3
