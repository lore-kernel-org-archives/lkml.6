Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48RIE8ncZJrI10cJ7CFuX2w+opEIDO2ToNTPTNGJXkgjTFnjwGGPm47Sb4aftOc83iSdKS2
ARC-Seal: i=1; a=rsa-sha256; t=1522393769; cv=none;
        d=google.com; s=arc-20160816;
        b=DhV/E+RaBnfNyAK7bb6cNXr6pSs3NZHXw0M9nOO+r12ZbwY3VlvMQI3vNUBpWw2NXN
         1fuPqNU2Nr5vmlJcZ1l/auJv2mxg8L9g9NaUShiJ1YphVQ6iGA0gO9EUocEJfHzAg+kY
         2IkmsXREcko3P7pJRlGx2BJygIHCo4/I+SybPPHnAHoi/jyCm6fKdVa81PHUXATwsQ60
         XjnHKcz1RUmgQSXvsGrJ0jHtkqHhSXT0qAJWBxcUDa+Ca/iFKQojnlTnjF1/TRdWdqgE
         paMHELEL8DgIVVDvvUxh+dbiclqYyS0ZYxRYFLho9BfQtayR3cUbrjoIs6Ye0fSMizQB
         e8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=4FHGdjXUwBl84xLEDxYYQLMW9out4wsY69Lgt2Mn65s=;
        b=GuIUjdgA5DDaRZuqUXv9UAQtKL6MM19uuGYa7Dmlt9FUT08Nt5TUvLHjqjTnDhOG2x
         CCHOsLG1jCNNZl3MwgtsmYu17qZOrkdy9G5cHkBT/Jd85MKQrXADO/yMU+vFgIzsb/+k
         96jCoygJzDB1acGs8h3qhA1FqvEeVEpHtwpsJJDjS/EFkcoXOghgfUWWN4OuRr2EYxv9
         GWCK0fKJOP+krc7BwYYxLvrSyXcXMgcQuXEw/Yxvbh2JH9aLIcr27UfVsZ7Xs5MDhgA5
         9q7tKi1HliEbXR++mBHDOJx4t9YrEvEhEv/A8oZXWZoYaJ5YoXislMsxdwZkglLDPfTQ
         FsHA==
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
Subject: [PATCH 36/76] staging: ks7010: Remove trailing _t from 'struct hostif_adhoc_set_request_t'.
Date: Fri, 30 Mar 2018 00:07:59 -0700
Message-Id: <20180330070842.25224-36-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:JhaEXcjUsdyvL1K3swVGKDfDWXGUePjxObDdrddKl1ym+3R/gX5
 1dmjrwP0vqzldVd8yB2D39YGvQD4aKXrXuY5sPiYTJxdporluqJEz8mMJddXMQ09EqwQA7Z
 NsXRz/cfWCKB2dGm2K0uma9nujIJmELrl58trN33JO0Ydv9d0E5KT7i+Ovpc426WHVAh0BZ
 sxWOHW5PC1+U475tc3TlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lPnkeR+Btt8=:5mj0jJZoaTcOIr2smQX4Rl
 gmfk4I24gC+PIp3B+yX4tGBs1nbNxfIIGsRCMWSJLgtUrfk24kCmWCmlX8yQrr1RNX+lK5lyk
 /27kRE8RUskCU6Qx9xOgZ+Qqe2AxOY0p2hhJVXWU1cX4GxcPtWsvEtAtqVN7ttAJul8sMG90C
 sDtz75V+uDI59FKweFYOZFOW5uR94h6KGhOMWn60iXFJolgIj/1G7I/tWwefmaHbY1tLdSiN7
 s+A7WE9COqZ6aixmtkRjgUAdKpELiPc8fa1nXXhJczEhIKYDtYQdEa50HlQ5pKreyJm0mqZOJ
 f55Go9UU0bXutzbjQv9eio/X/BPjswuMRMZh2P1GHEOQ+N9mJAXQgqoZWInC/ddt0SzpbJhJp
 lwfYnHNfR9Uc9/US/As16ptC4XlET4icNLccDQRMBDkdaF9ZtSgsPmJHwPVbG38HXbnaypGp0
 8EZSyaVS2uU+EDi+RUZK7dks53sKuS03HU3zvIVYhvYfQ7s6rw32+v9D0ZZpCdjUgwQkFslVn
 el7NOkVzI0Ecp2qexKtFL1tvEQg+zMnQDta2rNrWQlPR2sPvJGNmZXWZnY/zRWWI11RGnIDTp
 ZAnrC0iogbEREcg8ijAN8JXfXF/XwmUXsDPWZJTAFf417s1OH1SYhdlqiTxkh1fGd8XNvVCTg
 yVJHYP7VLYdWheze8vLwalGGE5psiB3doIpRSMlAIP0q2Zh3N1Pzg4INrW3ioy0kH4RwHLdAp
 kwonpRqytHvgoAyxASaa3B4+BYaORcgLuiLpXw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345569404658837?=
X-GMAIL-MSGID: =?utf-8?q?1596345569404658837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_adhoc_set_request_t' with 'struct
hostif_adhoc_set_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 3d6ba74cc3e5..de56cda64bb9 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1385,7 +1385,7 @@ void hostif_infrastructure_set_request(struct ks_wlan_private *priv, int event)
 static
 void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 {
-	struct hostif_adhoc_set_request_t *pp;
+	struct hostif_adhoc_set_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_ADH_SET_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 9deb53edb344..25a00a8f35d8 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -395,13 +395,13 @@ struct hostif_infrastructure_set_confirm {
 } __packed;
 
 /**
- * struct hostif_adhoc_set_request_t
+ * struct hostif_adhoc_set_request
  * @capability: bit5  : preamble
  *              bit6  : pbcc - Not supported always 0
  *              bit10 : ShortSlotTime
  *              bit13 : DSSS-OFDM - Not supported always 0
  */
-struct hostif_adhoc_set_request_t {
+struct hostif_adhoc_set_request {
 	struct hostif_hdr header;
 	struct hostif_request request;
 	struct ssid ssid;
-- 
2.16.3
