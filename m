Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920516-1522393949-2-6966589830062926793
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393948; b=pNrviZgoeKpJxmaz6QpFoyjsFbnKxstVEnbBYIAtznsBShuqg8
    uszFxY1WQTYDqqkoB1tV+V31doq2cQxQniTPcwhVM8Z/0Bcgwf12Wm/jo4rPWigU
    97CrxOpOO4/xhQyTAWF2TOBcCdwZEgt+zAlNqj3caQZtrAYxKWQILDC2uscn7i4P
    lJcb3aOM8MmxUeqnVEcbMbwNOgAYCMp7+xmr6YOwgKw1mTISn6YWCVjzKPLIHWUA
    dncVfpv7fD31avAMeZTmdfxi4/KM3JZWElNumQRJIDJKaF7K0iTZ7xKvgB/GCqPL
    RHM+9WphpXpB55IBpNTbidKF74U8E4JJ7vHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393948; bh=kAYsj
    cr11Ls6LjMV5bAB47RNQkILpdYDiZUnM1gmyrQ=; b=PUIK+gkXxV9ViVMRlh+Uj
    UBt9UcSBkAMn1XDML3PiAHa81VvrM9rH5Q8KFFcMb43Yf+imgNwTJzxSMrcD3Plk
    qnNU8UfjCpwFLMJmEOp+1Bufo315f8QuuB4ZvFre+IjQUgDkZIgR7AZ5zzXsu5/N
    Jm9p4wPD1/5JrCPAcTX27wUe9VX1QgI/xrnk4sL36l7TbNY2vbn3h7fbYbsf7jim
    vC8jgYie2AbdnCRVCHlWZK4ypI3Fk/mBU4pbeAux0mY63AOU3S53G2EpjqVKK6Pt
    C1Kfn3cuY/kPzQYmkJi7XgKa8nL4x6X2B/5SKDTtRQx2wC2n2WByJ6Nhumk9+Gcb
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEfSBqnLmPLRehT1hHGLz94ehiiI6E1kq78sArqF9cqEVF+ogt1ZZeWsO5v7VVBndEGo414R7MnkYogpzQUkixLPJI4/1Y3ZePYtCGh6qycqNoHu2gEE
    s5NY9XR7uz/IXXF+HT/js5+3Qx5hithQFbuX9cYY6tvOR41sihKLD96HzQSsyLlXRlXrkZNwUeY9hPCYASdlzE+VG4amOacH/ed2mWlQW8tfASI/RN62pbd9
    vBe6YNROgI+dhIFZPVlFtA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=pF25iSm20u65bnAoCTEA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 73/76] staging: ks7010: Change 'device_open_status' to a bool.
Date: Fri, 30 Mar 2018 00:08:39 -0700
Message-Id: <20180330070842.25224-76-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:sDJhvFZ53/mGnlyaMwaInQHK9xyud+1Cv/Qcg3Pos8R/1QSfN5I
 bl5NU/lwzffjh/rm0vl+OnyvRKS1F1Xr563yK378u5c2eyMqjlJbeLvFnBZs3/I6MkhUyzu
 VJU59bpKovq/zx47zzodmrUOSsK9GeFaSSRoXUV4P2fge9FVVcMkagJay5NU6BvLQh7Wh6r
 Y1DOE+mpkmOMr/TmXWz/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7ZQG3V48atQ=:YkKJpHPRd5pVYqgrmJTTdQ
 Kga807gwi02PCi1eFd8PDt2c0ZJ+/uLb5EI5RP0hlv3OOUrw09MA5YJsvop/T4/ppyleZ9nKl
 sZZGxkv3MA5u/4GUlFj9sDXw84G4rXXsYQf2eV9w4U6wzXSUPbZEQytvULzl8HCUtGLVX2H/y
 ddz7ZL8467sMNdem0tcaelFmj5cQPsaeA35J9C3ghN2I9dFM4uBir9J/B1wAkhnvyvxkPGs12
 ZnxSRp2W0JoXTszPIq4xJYUd5PXrAiH80tI8Rs6Bs2Egs4dDDYQn+sNwIYT/7blXwlaF5pO07
 R5/q3OgE/GVEyGbsKpYHiAW9rJINRDHBWujV5XZDs0Y+YCtOSdjAAhBLelpBX3PQEd6aVPEfz
 B0XlMG4qE5lTQnZq2zWsGoEXPfFIbg/q6APbZqUYpwyLK0q96UytkbKZo/K6ryh3zZfJhab5H
 cpExjOSFfEho4b0c0EQJEpxpQyH3SNtaxpjg6kXN9j0Zcoopn4jPiRVonwymfDIWXuE3QiAXB
 jkxXa/L/hJBazOqPBTQkTAxEN0BYuz07N7pIdIdrjK+EwnTWMu7LflSWiuVngPPiogXRCs18d
 ndo3E52/4/4FpQQ4lm4zyv5urKIOyNzSZBHzSNGQmk70PmiYRmHCLmPVZYd8JukbU+NLUyQWy
 EKuGZZSADLaN5MeAKPAw6DUS+R2Gsg80EVphw19ZL6evUK+RgQ5gxoGFEwKoN3iE9FCGqKGaM
 isXnR/f3JqhddoQyycKAymRw4NTEvRXeEM1Cqw==
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

The 'device_open_status' member of 'struct ks_wlan_private' is only
ever set to zero or one, so it makes more sense for it to be a bool
instead of an int.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h     | 2 +-
 drivers/staging/ks7010/ks_wlan_net.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 012e0fe2b60d..91231de5404f 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -441,7 +441,7 @@ struct ks_wlan_private {
 	unsigned int need_commit;	/* for ioctl */
 
 	/* DeviceIoControl */
-	int device_open_status;
+	bool device_open_status;
 	atomic_t event_count;
 	atomic_t rec_count;
 	int dev_count;
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index afbc472baa05..e1773e57cbb0 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2871,10 +2871,9 @@ int ks_wlan_net_start(struct net_device *dev)
 
 	priv = netdev_priv(dev);
 	priv->mac_address_valid = false;
+	priv->device_open_status = true;
 	priv->need_commit = 0;
 
-	priv->device_open_status = 1;
-
 	/* phy information update timer */
 	atomic_set(&update_phyinfo, 0);
 	timer_setup(&update_phyinfo_timer, ks_wlan_update_phyinfo_timeout, 0);
@@ -2893,7 +2892,7 @@ int ks_wlan_net_stop(struct net_device *dev)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
-	priv->device_open_status = 0;
+	priv->device_open_status = false;
 	del_timer_sync(&update_phyinfo_timer);
 
 	if (netif_running(dev))
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
