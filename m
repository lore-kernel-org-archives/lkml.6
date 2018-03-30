Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49AokveZQLsSIqMLsrbRdrmW5LD0amZ7ua8lrV0GxmW6/KOOlCefP5xeIDxVKsTyWPcTQQR
ARC-Seal: i=1; a=rsa-sha256; t=1522393798; cv=none;
        d=google.com; s=arc-20160816;
        b=IQb70oF/g8lCQr996s/vDAEclNdqPG5ecm4oanEjQYggLUNWGznNFQKRcQ1qsnRAMJ
         QKPWAfMOVjo8ZIVLyRxbZ7o3ShNbjiYZLHJZTgRhIH0FQLRXQ1tBXYNsHtUDC7tfnhqm
         W06aNIHrbpb5we/T6QyVBDfnfxARvF2sCBi6JbvnilSsBmj8KUxzQMImF8M5ZjZ8pO75
         0hMbxdOxS39e8gJJ47T1VDywHxXNa3ZL9gXmNl7zINla9a9ch3yBae11PAwq+9hgSFh8
         WTF8W0P9q8qflBhy/5HrYCXzoJsWSKRU17bnZlFg5j5lsRx1JKpuT5ywJgzsr9G8uaQ7
         SGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=tcQVEW9G/6Ynw8ttTjYGLfCDVLNx10FM9/eWz2EU4Zs=;
        b=RcwftaWzbiiq1iRhfns/hQSfpM2OWSgm5KuRRahRIpEGWQkC+RMIQjUUC20kOhg9mz
         gP7Dsz0EWBI3W82ETzIFUjgL4JN7F6OY/Rr+BibgLFFxDPdmnAfwUUffkznbG9H3MOH5
         /IW48HNSzDdD0bmH6n+zHLOiuU0YFiepiVa3VMiJHPucGmUj7HzvopcZ9QgW3lgOpZmo
         Z/IVcV6/qKMGhF71j8eumn2UgxwxIL/xDwg9hiNu+Ix17PbL1luyifoOzdo4xKp0PP+K
         7sY2gvws89FhVGJBiPEGq0N8C3xZVj41jYssVqy1baR0ZGKzom/ojy7IHIn7HoEUsX46
         u+Mw==
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
Subject: [PATCH 70/76] staging: ks7010: Remove extra blank line between functions.
Date: Fri, 30 Mar 2018 00:08:33 -0700
Message-Id: <20180330070842.25224-70-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:hHCzlfWHaOOEVkMGuipUm6lBzh6me2vS9zNHqpCg/4PR6ay9EFV
 VDy/HI2sq5ZHRBkSCKQs9uyscGKLtbKHvnaiiyCY9fNOE2mz7PbWEAvnUYmeytUUlyjHZ6P
 0Uy4wQlIep7CmlxIhHW1ybdpPyUNZrRTO2v0q5m28fnIk2arScLOuk0Y1RCoZuDj0gBiW/d
 hpmwkSdRgu4VHJhy+Owlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QdsD+kFtVxM=:eV98OI5DGnxLfrxHblFcOR
 OBneuLEqWYTGYOKHWCeme2Yx/wqJId/f5dOQEGxGrH+t20iGavwT7ANGLNZRHHN5ByHD6xM06
 98msQ6QFLYejQqSQ7/3kCDIECiapVTIrRorbgt9m4PUHddZC5qUlTCEj4HP0yAweflNHOO17O
 94F81iZR0vOtDQYQhR5e9+nhgHb/PgvXHPCMkW6LVMMuwkIHwjif8tqgoiaZOyVE6aot68lZO
 YEvTkYgSuXr7dXyfCxhR0TPgL+uzsCReI5nN86haiy/rQsfMXyy5DSm9v9Um7olglaD35Gq+M
 +08fSN+p9GuikipcSD16pjn4tJNu6tajbaDvQTgrGClbxxfcfEWpMuZIeJpdYOj5kRHeskhi3
 lCXowAjGdcqK9Twnl2GdiG7M0+/R2dbMAR6PBd4fQjcj8f8DgBxs0uW2stez8CpasQwhcomC/
 qMUZf4/yNKMfJaB30MEpzhlPRx8CGFZGIesJ10uEHSUREqwIeAG0O/wKvOwZ7SdTOsyWjNSL5
 yK6lYIQbKe7CqfeWz0hjIR7vDhQC0rGdz4tp3QzhsgeAHSLuDM2xfJ0chyX1ME0l6DaXjR2qu
 1yuzmNNe+bfu0MEPayUb/D7XI6f7N2f8Yb91TUNpBZ0qzvmK27y66f9x9skxfpLsC/Xb/n3Vx
 T/wDJXKwfbkxZs+0k2tVlGgYQN/FY16VPizBtpQKG4GPdK6Ti9lWctqMTpoQqNz0FkG9ohDD6
 pi0rABbAVGEbIv5lNAD2U3cjO6Y2YspxWZPQ1w==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345599363234699?=
X-GMAIL-MSGID: =?utf-8?q?1596345599363234699?=
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
