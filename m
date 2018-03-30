Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+ygZ1rPWrH8uwtZJJwOc9cdqKojg5bLjMGNdIWqnw0R76A6v0VShiHFsRP0AAMg0JLWHtl
ARC-Seal: i=1; a=rsa-sha256; t=1522393792; cv=none;
        d=google.com; s=arc-20160816;
        b=NLbImq3o9uEGKt2waAJYhFln3PxvwFL+0h6CB8OYHq59NxmD9gX3+b2fd+5Z4iclyP
         gNIoau/RR0pJACy2EMAy4Fd7XXLrDGkbzSOs7rAmzdoYEOXnrr9Ttmqz5uByIMM35ksm
         UWW+DL3ohWIMFAY6D1Ek5gJg/SQY/QIJvVMN4glNcbKWAL8R5GZ7bh6/vMJCNkAQzd2Y
         NwT9rRfcYHEAtz7VCwuAQNovnSUUg6fyMBXiY7O80rdlk7M+fPEptLqmZCRF8TJxIcj4
         AlbBv3c6KSlGyEc4RtrxneO3d0LiC0JMUbYFbZknwcCZe9g9jrj3KoyXQWrg5+wPingu
         NbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=EbHcxwmUt8J1UdifjuYNDAQ40kSUGH220+FF5w/Zs9w=;
        b=V/LyqVBe1JYxwxobFwLebr4lxKsX81X1g7orplqC1kogguGkF04gqLBUyN5Q05x+72
         8caG6NkZKUbVFo2uegjdDsrc9sVfB/6kVv3gVUURuUhIMjJd9fMBtoPpfS6Eq+LmomEU
         QA/JK1ncQ/65LgKoDbggZhk7gnvyU8av+iYcGbct2Lx/EP+3u32oXph7htUIu/lLPgR0
         COpBkD2o5aL1L6nT97uogiwBTKtko2V3DVzeplrtmb3PKsSUdhcm1LGBRo4vCOSVQRs0
         V+8skLy5sQze2/YI0O9KTgGFOJEVL08G85tliGczOQQ11x2P6KWMpdv/3N3cri4nsXAg
         RWhA==
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
Subject: [PATCH 63/76] staging: ks7010: Remove trailing _t from 'struct wpa_status_t'.
Date: Fri, 30 Mar 2018 00:08:26 -0700
Message-Id: <20180330070842.25224-63-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:fLk+YgS0W6lStiRYC+Rem/Otj6AYF3gARGXSFgIrokmQvON6WDA
 UzbiGERSiNISfE99U0GParj6RvUMFa5GVp8pLdoqEu7i4Sme1iHGXoUGq7+oo0wgY42QYGZ
 njV0hBLohNDjloA7ygmseyzk+DhOg+j3ikx/PyejKQTiZfD94+fQwl5ttnB/0ePtiM30jlF
 SzVGviBL1mrFGRzc7gbTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ye5TIfDMZ8U=:UBKfLaaykM1avclMZ6wStA
 3AkKJFdbvLmEZsjs36l/Kjz1ztyo+0oCsSBmYNMWlyd4hLJdYJgLmFuPdXN92o8j6J6wWpUYN
 aG6eTylt2InGy3YvPx2Ygs1BNLXUJX31X3qu4AqXi6kFXB8Mp8VWs9yA2HcAH7fc5Jrv2jCDS
 RElvrkvZWhP48TowTUwqlhvOelaavJuQ04mIjEAhAt4dLXD1IoaGEBBf4t9aX1eYjY55SYXFS
 r6qkYsxZj5OYp4NpWDuWfQHHZufbfgZTM7W6YJCtD4JNd76CmHTVjvOlEvJzEgqzMlA/NGlx6
 burM3/w4Ht4U7csCfDo5KWxNRyyp3JO9XTKRQVmwx3d+/R4FlSmGbrKtkaaTUc+8IgUgpF3gH
 Fo4tTYnrIqHTHSB+E/a1X9RXHAqH07lz3WLELQO5P8UBb9HqETDYD7Z4Lvm8duuOcI+v8xEaY
 z1JzFIMvyCkCJWvXQgF46/0SY7SL3JAliISZ1znAUzONYcE3yploMelqdYdDrH7Gu9lVrLp97
 rBOVWq5IhA2s8ukI+OyVMlf0p4jAUMONQVtoHw0zpaDM8wc/AgAxH1KSlOY9Kncqmkq7Xy/TS
 uRK3vhfg9qGWFv+4jTdpw9R4p6du1RYJgcNmFLLMq9ieXdZ7IXaDeY/NfKGEIdlXSAhMQLF5B
 6/cJKLq3bMMh61SfHMGFPBDjYiGLxbmI5zo4IB18Pc5Jt5q85IVFFv/ZlpZECMsDUeNBpQ+zu
 kdknM8XNFJT5FIYFquX8jCyaZ56nMUIFDlwl+EKj3KyfHzVHFj9ZcNdu1+gTNk4E/gcFhC7vW
 Ia7t4lBSR0PIzwuqCdSCeHUpYzZ7S2LborTWfMnJeRvNvUxfx6v9CLyqL91Oe8neVLKxsGpDc
 FGKr1WQ3gcMwMp2FEhklxi/VliEyL32D9SxXKgibKe/rFwyOKnnJmcq32jvC3C
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345592917569954?=
X-GMAIL-MSGID: =?utf-8?q?1596345592917569954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct wpa_status_t' with 'struct wpa_status'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index c3e61021a75a..851721182b05 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -364,7 +364,7 @@ struct mic_failure {
 	int stop;	/* stop flag */
 };
 
-struct wpa_status_t {
+struct wpa_status {
 	int wpa_enabled;
 	unsigned int rsn_enabled;
 	int version;
@@ -427,7 +427,7 @@ struct ks_wlan_private {
 	struct local_ap current_ap;
 	struct power_save_status psstatus;
 	struct sleep_status sleepstatus;
-	struct wpa_status_t wpa;
+	struct wpa_status wpa;
 	struct pmk_list_t pmklist;
 	/* wireless parameter */
 	struct ks_wlan_parameter reg;
-- 
2.16.3
