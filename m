Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/3o2X6HzR9TusepBAP0XHk2et4wZDzlRFLuZPBkOk9uQXUaKmLx9+0vb9a9wZ7/cTaTD7E
ARC-Seal: i=1; a=rsa-sha256; t=1522476591; cv=none;
        d=google.com; s=arc-20160816;
        b=w3Mqy1ZQ+1lvspnteAEBEBAssI4KrQ3bLNPdmdx9WQwdtyMwHjDouNPdYjxVFqx6dp
         7s9wZfasuTdnwiq9jaWobmBfcDVulN6CTryDFkg4+4B5lxRRc1TCj8YdSFkk3JvFmDCb
         s/N41mYzWURXc+EumJKKTrEovYrWp6KY2JRayj3skfaRHMJw6ezQFSi5j+LkhC/Hh3NV
         1mrvlKUOXVdxj1QYCSH6YKtMDn4nrVljIAJ+SBc3X71p737WjTvN6in/+zGa/CpXkCjL
         17m1pFsKX+Y0y2yJ9fE68bXuJ/ieKWm+4IJ2XRDrK0ciNJFmZk3u73rUWAgWbv6mF3TW
         3Jtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=aUOgswUauDRLbYlb2jEU7XS+820TVDxczNFKJTrkZ4g=;
        b=PtfX8kuhVLiSCvrRKAPbkhRDBhDa0lKchPi+kLrjjdWHUp6qtn9f9bQsAwFshPjnND
         cgCnQ3NETxai5VKggqgsKUp+/P7bVq3SJwAJOvvUQ0xGwKTIF22tav58kOBmYFwewh//
         2D/UudC/9FAklQVj87XCyTsmp3sivcvr06m5SjzDKNlx1o/eEWThrwZDcBsssz0D1vkO
         bHBHb0zFuwxcQ01PUP1jwJzcbmTZqJPW44ASMS4qDXeMesCAsI8PjqSZpfdePH8fxNQK
         BhiczlnZtjFQl6ey6aCivepsob6NY4hUpD/klXMGiO+NIsyE4j/swRrN16z7EVSUZE3T
         y1JQ==
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
Subject: [PATCH v2 32/75] staging: ks7010: Remove trailing _t from 'struct hostif_ps_adhoc_set_request_t'.
Date: Fri, 30 Mar 2018 23:08:12 -0700
Message-Id: <20180331060855.9452-32-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:LE/zWdn8pfIlY2d4Fbv9q8pzAuyfVx/qCQKbEzmPw8Iz3UcWDM7
 oORL0ZNlYYOrCF2cYCQMZN13kQPCe1YGUOss7RvcdrDxpQxlous9vuKNN/AN3YZf/9s9msZ
 aTvkDwUaGGMVBtRIxW1v7UVayBFeM1F5Darnx3nDPbt/nLf9OH46dY422iF8uOVnSypbDmN
 mmc2BQkaVbKmktbAL4WWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D3gclWTxE/4=:wDmlvMe/sfT3e/pVJ2reCQ
 eDn34E1bNfAE5uNLZDqypSozYpPzHuGjbdLNVoydagCCXdPxIluOKWypqJPq28FaB46spUM84
 2whiGgs0YGwO/WrVWPhMj/RdBuwkwKBuqpr9Hv49as5h1iSwGzHf1MyFD+3FyYVJ0c/9JBZa5
 uIxB/L9GuLCgq9pZfOONulvFDARP3k330aDyZHfGG+AJYzsmfSs9mhTvqBwtcBi0pj6kzzO5t
 67NA+q5vcSWx6FRREnM2/lBleN2M1gm0rLSy6OJPyibJuZaFbXJFYbI5nvlkMzu0/qa76jEGc
 H+h5a+eO+hLvK3ulxiH5RD9qOu7G3Ko2wn8DPp+ytEBGZXf6CH7dBVCj0rEDuyDRrRI69bL8m
 3kUpC2zqVg8d3U25S3lyt97oL3DEex6na1l9wNO6+jSCwbpJpVu6DClFRf/FcH/XSTuK2BUpw
 /2y0LmTl84zZtX+v7KNO7lOVrVKXHTCiUT+iDZ8mG82pPUGlooDRz2cKLWQlkSf8kNq8leGYS
 ldXB+dDla62vv5CijBj2iSYVaA8zn87FVmoG4a+ArVK1DFTUgWR5TkSUNQIk90WiH4XRX/DTj
 fY2DhPH5AZVU5Ns8ZNPNtjChZaVOveX5shTjFBek8iAMUI5UJnbfyzlR1lclU3wMLJjooPk9c
 ualE0LjZtur2WHwsEMuhgU6SHfn4FQlf0sBDlKiea7EApyETPFOCRCSPjTmO+1hgSOZxwkyll
 OE+MPjG+srsEJWsdAvrgAgEwI7mQ34wpos61Qg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432414416350623?=
X-GMAIL-MSGID: =?utf-8?q?1596432414416350623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_ps_adhoc_set_request_t' with 'struct
hostif_ps_adhoc_set_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 9798e2427f36..8be5d64f291b 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1327,7 +1327,7 @@ static void init_request(struct ks_wlan_private *priv, struct hostif_request *re
 static
 void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 {
-	struct hostif_ps_adhoc_set_request_t *pp;
+	struct hostif_ps_adhoc_set_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_PS_ADH_SET_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 443a528fef1e..3faa28c77446 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -309,13 +309,13 @@ struct hostif_request {
 } __packed;
 
 /**
- * struct hostif_ps_adhoc_set_request_t - pseudo adhoc mode
+ * struct hostif_ps_adhoc_set_request - pseudo adhoc mode
  * @capability: bit5  : preamble
  *              bit6  : pbcc - Not supported always 0
  *              bit10 : ShortSlotTime
  *              bit13 : DSSS-OFDM - Not supported always 0
  */
-struct hostif_ps_adhoc_set_request_t {
+struct hostif_ps_adhoc_set_request {
 	struct hostif_hdr header;
 	struct hostif_request request;
 	__le16 channel;
-- 
2.16.3
