Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48qYbV5PUuBa1Lyjfml4Ma9NaMo36bV4F7xXNMnfccaA868zWMbd0n4V8kkY4zJ5HH2wNgj
ARC-Seal: i=1; a=rsa-sha256; t=1522476569; cv=none;
        d=google.com; s=arc-20160816;
        b=rnCbpPVq3dh3Ef/xMCk77riiUXOJuAtR/r03xtn0PCQquAsjPJ159PrxuTaMhihQBZ
         XpVdE8tDkd/J2ar/X8pfveLUGrYNsoCYlQ+bgzrFMFZijCjpAOc0E93HCOsgX7Xh+iaF
         GIrmwZgSiX1Ke+33Vhw/OVfa8fUSkT1NgUrtjyJ3btxsraoKZ+Szsn3Hv70jSd9lqfnG
         ptTLrv/sOVolFsVml5xVVg5hRN7+QEg4tDD95QK8tssky1XkQMdUzgQoalDc8+AiRGSZ
         ewFsPsFm93dUem0WWS0kGJX+4Wm7kbbvT04qJwEjSNh0Y3dkTyZ8eG/7KVhfKvBgJLPG
         s0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Hv17m3a3YOYvfvoA8mmAKOaN+OEhmtVj2jr+pPdxoIg=;
        b=0O4N+WHme6YO4fJ8YAJwXKLG+tfLozTAWowOlWIW0KOCvF2Qrg0HYNRNUP6cNL1sSh
         ENgyIFyNyR5p/qj6olwsNbla3ytrvoe5C0vC/vl9qs5ySzt5ksc8mNSfB4btb5I5bugs
         3JGvUZe2xQ0hPNAghMI0oiMvS7NxhopvaG0xVqYVBGbh4sHUeV8Hi/NlPzJPpkIEPOI5
         MgD4JTsSLqOBM0cq/6MXYD38Ovoa7fwX7JvNcIw48L508O/H0rWlgZH27PVV6n1WMvSI
         6XKXS3anFnyRlLl+TSBBU17JxY2VJ83o91ptNVwKPKv1vGljWW4+Wk/PuaLYC6x5YNHs
         Qv6w==
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
Subject: [PATCH v2 08/75] staging: ks7010: Remove trailing _t from 'struct hostif_mib_get_request_t'.
Date: Fri, 30 Mar 2018 23:07:48 -0700
Message-Id: <20180331060855.9452-8-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:oAe1vGrYjvpwajhx1A6aAUX7w4U+sFJ1aTLjfVK6lnxRrYVir2H
 bR522ZxlVgTNcS8dlTaV1/IvgMxYWJMZKBQDHJ+UVVc2eOv4cgd0fczRd58zkSlfVjRRoxv
 AjIlt9Jmhykh226v6mTxPrWseCBCrYfPYsGrcdy0UAWMKzPCBcF9S6zb+jC2/m1RkFk+zIF
 SKmj3kdubAuzYbWAaQ6rQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ch6dCYG9KQY=:1K66QK+2ImHAo7OZ9c9RKF
 SJaII9I+fbqHxaKW6sjYy5VMD0bwmrL+5lmBUqbm/b1DNc7QIJVUY2QHVOCvs351TSIjhn2qm
 NbgkXByLV2OB5idK1J2uz+O3ODWzcVJqBiaKrvDCjkWzRy4IFq09OKCaHr4FFEoFIG9gZBe9h
 x9J05/nXec4/jMmzg4FF90/id8WXUs16w0Upzp3guusCaHVc0j/KfWFJRDmJNpRLFPjuiSNeM
 OJ/J4Ow33yZsHdwp0EJ8Ly5E7J+FbugS5sHxeHlk41tF4gYNqPxXPrdHng6ihVFl/ZQv5hIuM
 4A7Mlur+GaoP7v+ITOlcaPtyWZsGjQ+SsuDB9uCLWaekieCxzcRY3Da2qmF9jhSswuvdwuVFp
 ZT0PbXvu8tQxRVW4ACTHkW/jqJRqp1Qqf8E+yZ8q2q8BIXdUlYkoXSxjCOfYEIj7/c+YNpJOt
 +Ovs/u9kXTbddwQRtOdX1x+02UJLoUJ8ViD/fJgmvyHQ1Za3y6BDlz/+acJB+N2q1VFSXQQoi
 dwT+Pke7xVGBKZZBrtW87qdIOqurUnJD6QbcGMZl5sPb+7TreHJ+dAmtDDWiqEICwCercbi0W
 SyGYd95LKtkpwidm0j1jRwaiaKMj0e1koNRMZLLmEXMsOyDlEbpHPLvxXMfMFDcDYZRnt54XP
 FO8o46wSFNFjTN3YzXgjbPC0awCIpr4e9X7DX9RIzBCzwZiAWfk8eybc6zF+gn4Bhmo+LGm61
 75EQ5rH6DAHTk9i7qXRKjOw660wHoRpdQlyXmA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432391374835874?=
X-GMAIL-MSGID: =?utf-8?q?1596432391374835874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_mib_get_request_t' with 'struct
hostif_mib_get_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 9e69009e2911..cc1e5f441cf0 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1240,7 +1240,7 @@ static
 void hostif_mib_get_request(struct ks_wlan_private *priv,
 			    unsigned long mib_attribute)
 {
-	struct hostif_mib_get_request_t *pp;
+	struct hostif_mib_get_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_MIB_GET_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 8017a85f95ad..0c2771861096 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -135,7 +135,7 @@ struct channel_list {
 #define LOCAL_GAIN                        0xF10D0100	/* Carrer sense threshold for demo ato show */
 #define LOCAL_EEPROM_SUM                  0xF10E0100	/* EEPROM checksum information */
 
-struct hostif_mib_get_request_t {
+struct hostif_mib_get_request {
 	struct hostif_hdr header;
 	__le32 mib_attribute;
 } __packed;
-- 
2.16.3
