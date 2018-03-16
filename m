Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2161282-1521181864-2-16930032548325651715
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521181863; b=ueBQM/PkucG60swryVBTzPCatJ2RLvbI/Cr1dLLZ3hfAxaJ
    k+Xo5+O8hl2DUrrnu2ebpZEXXvJXF3gQYM8HRsa4gFm4z0fXPg2kQq1fIV6XvAck
    2alVvZGYN6qPW6LPwm0YISrQpFlHRCsELX/88QoVdTZylMfcVygpWHsjoNrE1Y7C
    s6Cpbgcsv518qwqyjuZ7Htlu3EN/+ruw89bb4SvzKjmH/d1l898Qa308syuI6IpI
    2FAe8b1WU3o6ZDu0laToraDDoRRxavXY59pJS20W0hUUqxrvSJGq6r9x2Dk+01gv
    3i2YFXPUWJOg2YnFiF5fKMH4RGCiTikGdRjCCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521181863; bh=p
    6YgRKyuzJ1xt/4cJ7vQzVPDu8sZUfIbyYnicprkuQQ=; b=G/OMUu6nilqM8iib2
    EW0621UPV1Yhr42M14CMiTS0es0FEH/+hi1q3pr5wyuZuAdyxZA6hUo2WZlILc6q
    lGZQqCqa9mNpOc0rahf77Yj5psQy3yZ5fWfxoiJ19yVvmmfl8oo1mvAiPafhXloV
    voNX6RBl6tcl/2hedYxlR/sb4t6rLxTe0Uy7ISkAmq/yJTMriv7vdMGq/nx1J0bV
    wVbgBtvmEwYcuZJSbCA1qctUwaLil6XkGbOplGdKFPgCi5T6RZt5RrGDIJGVxxMq
    2JipHujmU4rx55NahotcDWy7IjVnZkafSL0DF/q3wkKTNMFkg+4h1RTixWlxTwTO
    g7emw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 3/6] staging: ks7010: Remove unnecessary parentheses.
Date: Thu, 15 Mar 2018 23:30:32 -0700
Message-Id: <20180316063035.3037-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316063035.3037-1-quytelda@tamalin.org>
References: <20180316063035.3037-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:TPTmWSO1TP0SjXtvj6FbnEjJkL/mlca8ka9W9J7NrVgse9aTID/
 clmJZ5caKtsR7OZnFcnwPmbvRXO/oqxm1uDsGx5qK2kUXWge+UHXwa5gAWdPKZyzoiptX93
 WVjMIxYyIcncwPB0XgB7A5tVYWCIcK2LXgOh6iC/sBJZ/XcHgGvLdUuiQ2Ib0AlgA6bsLnm
 MwcZFajoVIBZrPQfBKJ6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GQsGsON4E8Q=:at2xst4MccKStbb2Nm4BP3
 +LaQIQ0TIslFGLtlZG0ZU+Vm9OvDgRVgWKNcUoK8TAI0d9dBYn4lxvneM/pVRclzmBo+4lBhU
 fLNI/LcunwIP4nd7qF84XgAz1MlNKZXkHQswjSDkS2LVhFeSX2L+L11tLI3m9aNYKKqa0I0l0
 +H3vwuDkRYpypyV1T2Yecu+u+7Ba2uTzeEXN+mhgqdrNSkNu0GFzYEN0C0kMdSETl0q/CHSyb
 1SH7yPc7kAVMDsDmyv8Phv5Qw17PHFXc0NxycJ9mrdBoEN1pprvnwwGNlyPXotExDNoO3WFPU
 Dt6M2TbKy7hyFCJgoWVe5Q11FV56PB7dMMUwGQcpmPggGJslO0ua2I3ewb9EPdFWESIFEeYa6
 XBbbKFUsD4GSmjIDMn7KUh7ZPD9DdOIcwVkLXNldTvI3SVG/0wm/mFdP9u6PjG+q8h5Mxl+Vl
 T9XewVF67BkSr41k6goRxIWIYVTKd9bMZWFiOsMC2QZbWD0N/GqffuN/BIXnxVvIp9T9gzK9N
 pFyKmgfnWiR5/2sX2TVUsgyreQCU6QFVbQbBeaPLS2bIDpd4fJOEkkshN5RBHDss3MS1hhtLT
 By1LIAIpQFELI8zbofHfjJqzDZK2liGyxrfrtvyLswcLtuYBhAs9WTkvDHNR4SNsGu283VuZs
 h7qt3nzSV4HGsNr169AavpNBk4A42dBuNShjwavKiuIAUvtA/dT4WEuuK1hKTWypmRo3RdvG2
 ZaZBQ0gD5dz4CI1ff9LwiCNndmQ/JpA5J7vLZg==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove unnecessary parentheses highlighted by checkpatch.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 948d45280d18..00b97e8e9b4f 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -45,7 +45,7 @@ inline u8 get_BYTE(struct ks_wlan_private *priv)
 {
 	u8 data;
 
-	data = *(priv->rxp)++;
+	data = *priv->rxp++;
 	/* length check in advance ! */
 	--(priv->rx_size);
 	return data;
@@ -860,7 +860,7 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 		DPRINTK(4, " scan_ind_count=%d :: aplist.size=%d\n",
 			priv->scan_ind_count, priv->aplist.size);
 		get_ap_information(priv, (struct ap_info_t *)(priv->rxp),
-				   &(priv->aplist.ap[priv->scan_ind_count - 1]));
+				   &priv->aplist.ap[priv->scan_ind_count - 1]);
 		priv->aplist.size = priv->scan_ind_count;
 	} else {
 		DPRINTK(4, " count over :: scan_ind_count=%d\n",
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
