Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx485hic1DKuxI/DXnsXAYe4jKikXl+8HvXfxDdGD3V1JmFlFNJlcHSeEF4oeRRGeiLq/H0oK
ARC-Seal: i=1; a=rsa-sha256; t=1522393802; cv=none;
        d=google.com; s=arc-20160816;
        b=zFEolZFxH81lVZRU5M516U7fAzJTcXCZxoP8uC1kXmt1AtKv5IRS6qPELyYOTkxcq9
         QLU7CurMF6mBYiQsDw8DHzOarTFAwU6qEzpfEalsvUnnyX9aM4cguchYE++XX1VfnRHu
         B7w/umIFJGSmaF/EBU9g1dkk42uTJKqWbLi/i5+UcStLUUAJlB/Bn75gYzPH/HRpgm88
         jtO0nfV9FX12um/UibpdewlK6qDdtL8s2ijgkdkTaQXKv4a3W0oYkHtwUNIZ9m+TPUTz
         Y9cVAgd92jfNG+AHzQb61O6TOzJ4iumg6P1ecsmBftk0usMsbXh43zu8PZunvg5UJ2m0
         Z7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=tcQVEW9G/6Ynw8ttTjYGLfCDVLNx10FM9/eWz2EU4Zs=;
        b=Vtpoh6RKRYnjh29MDx94QOXiaGiHsATMpW9US4FjTFE+jcOnTho3M9ERBRhJJ4qLMf
         0u/AsUQLJRr2u8HG3YybQue4W0fOm+ycL6IYZyKX3F9avabmoNoGXNZ6jEe4xaRALShl
         T+zLI0KCgCxG/wMRpa3IawTcEaqm8sZ1Eo/7R/zoy8wmcLN1+2KsafY0qX+3RjCeCXHg
         /yGSa4UMcjkaCL+19KkMc0E3HEiHEuNCv5rC/eo8Wq+vcdTYHmUv9R8qoUVEQiHZDC+J
         arzb+cODB8BnbO6s0b1e9FXFR/yfGUzDH0IEbQlwrKrh8T3Akw5EO3n1pym06gcpnVCH
         YLDw==
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
Subject: [PATCH 72/72] staging: ks7010: Remove extra blank line between functions.
Date: Fri, 30 Mar 2018 00:08:38 -0700
Message-Id: <20180330070842.25224-75-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:+W1RGs6DX6j9SWjla72qBwS44rDTsLupTakNxQ+ygfEHhUlzyng
 /rfLxEvVvvTgGFlCwtV5OoXMK202g8sjmIQqNDnQxXukSqeQPTR6Y/BtAylmjFtyEhA0XfV
 mUdI42Qd9Lgb7uFcK4MKcBQBgfSXWFVgzwrqZ6tFwvnTEQU0KvX7+AppMlhJ4l/cz9XqwrN
 TUT9v9nOWphUrW6nY33qQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YnGsTmCfrGw=:w23787qS05XksAJ9/yKgkk
 Y5o4TnS3Y1/05Z9VC9tA3P9s7MVD3byFCWh/MUfipSD2ZD3seAJibRxeOpxCcp3L335IbL8bQ
 eOMOZnzDmCrOBiN4HB5odslHsU+EqeFNK4zV4LTSmf+4bMG61ycGbnOaQ8YwvLiBP4VwHcNdI
 ZczgDp/CswL/mhLAsnbgD/kBYvSafUxlP0Otxdxb7rgPvpHcj0jCyiQkLQA0urAwD5YGDS7cK
 uOz6BSgegbeqBze5H6Ba8lxLexynRw0CaNGzMRwVbUPAaTaLq6vs7CP5yGJm3cot/QD+KagPJ
 LyWPqVYQPrbxNJaX5XbVUjt1wsaoVQnAi78f307K8TKML5XI6VZFMqT59vKtRBSYfDr5CxLfL
 /TrGBfqdcSiryNi/S5x0SX+CAXTDDRaVyW0MfekvD9PuO7EdF8wJ7gvI/wLSXvzFSg3CY1xtm
 AK5Rgp8wV9d+9hidkjujVlYh0q5J3nmb0up33Aw/jH1KLvDOScLZlOsdKT8dzLhXjbvjCCdhe
 kiHeWSwmheZBmwBfwg2FQfdmGigg4hlSRFAJMWLz3BYWAqIQ88GL5QEcbW45jhM0d/ykEErF4
 H3/jjmlAuRmstb9DCFXDnO3B/DMnaDNDHlOmVIF2irUMwlfpWYFBNFUzj1eoYwkCaq1WZF36Q
 NLORiV4Xcut4ozYqHDANKHIey7NHoF9qUQd+RnfI8c8GnYiyj0Qb9DOd2kzAR/lP1o1XUKR0r
 0OkjPr504hzYroXNCar2/O0pAzsCnqdAh/NWFA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345599363234699?=
X-GMAIL-MSGID: =?utf-8?q?1596345603612153241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove an extra blank line indicated by checkpatch.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks7010_sdio.c | 3 ++-
 drivers/staging/ks7010/ks_hostif.c   | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index d083bf8d238e..930d1f7d7dbf 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -305,7 +305,8 @@ static void tx_device_task(struct ks_wlan_private *priv)
 	if (priv->dev_state >= DEVICE_STATE_BOOT) {
 		ret = write_to_device(priv, sp->sendp, sp->size);
 		if (ret) {
-			netdev_err(priv->net_dev, "write_to_device error !!(%d)\n", ret);
+			netdev_err(priv->net_dev,
+				   "write_to_device() error (%d)!\n", ret);
 			queue_delayed_work(priv->wq, &priv->rw_dwork, 1);
 			return;
 		}
diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 3c8a8d0f800c..b97080f8ebd2 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -221,7 +221,6 @@ static u8 read_ie(unsigned char *bp, u8 max, u8 *body)
 	return size;
 }
 
-
 static
 int get_ap_information(struct ks_wlan_private *priv, struct ap_info *ap_info,
 		       struct local_ap *ap)
-- 
2.16.3
