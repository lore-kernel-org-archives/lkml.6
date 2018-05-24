Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156576-2-15939839681378474811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156575; b=F2TRNqHvkTCa3eC7ERIRK949fEOvYQoFwfLYT5W9PwKnGCRyQf
    ekSEGss6/nPGZURqHGFhEwIYMPR3qdr1nhvlcJ0oU6aqws0Z7pgd3X4kMbOuMO1U
    6lNdA9lHdk7iBWuM06OVsElL+kuDFHUwt8T89L69RgyYA6c9z9CUYOGv4HbiYNEN
    D8dS1emo44q6i+D7NzirXqdWdQgnAI6Kbj+bSHG215cgkLOQ7ttrEzymXCw35qcK
    r9x4PAtmKcM2tRD0Horwu+bqbJjeHx29YEErPVCZqbjW889Zci+a6MnDVjY9WlK+
    +H2/rKif2kXGAarBnyM06Ja11+zMu5wTJTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156575; bh=RL4D6LLXsF0e7ICbSRkNxPzuxzKbVE
    A+ljofZbYtZzQ=; b=iHs8AfFEC0t0r6XEtYEYG5qoOYGw+jh+Nl1q4Tba97kF/S
    pih9SE5dSYvGqLkpLqJXwjoxmrY3iXEgjjsKm5/+39AeIOOAABfXmauXIyDyIG7N
    jk1KG7Y3wZoZsJEqsvys8sFu4A9J4CaUZad8XjywYxHrdYlk5CsyKXqwaP5yzSkQ
    xYhZTgxABQFYZo6bU6P/ogrvpL+kLLUVfpkVxwveaA0FGKhoqzO44NNGnPCWoZ8j
    CDwfxkfKk+9xmTmznK8J733b4QxbdwDqw0UrDxL7DKykaazVueMC5cR18gKv1uOz
    xSaYED60yB1ycLScm6t6s/TBbOzg2OuHFmoMKEOw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=mGEOPlhp x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=mGEOPlhp x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB4nDlrqqT18e1WG30Frop24yZbltHqUNp4gslHjXr20Ws9qZAHfT+amlWgarNorQldN+pGNutYCewgS7khRoJe5wOF5k5gpbIw94GjbVzjA8k3A6kfQ
    besbfABDWwxP7CiRqby85ZywSd8mtnkvfuvHtmzvM9htLgCr5TU8eqs9Kg2aeL4ZlMsSVk62AeQNo/ATRiUl+H8KGfBGISydWxBxv84Yesc4uwQRWQewAMOV
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=jMSxsYAmotoHhWNEieEA:9
    a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031725AbeEXKJU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031645AbeEXKF4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:05:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 157/161] rtc: rk808: fix possible race condition
Date: Thu, 24 May 2018 11:39:42 +0200
Message-Id: <20180524093037.019031273@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 201fac95e799c3d0304ec724d555e1251b9f6e84 ]

The probe function is not allowed to fail after registering the RTC because
the following may happen:

CPU0:                                CPU1:
sys_load_module()
 do_init_module()
  do_one_initcall()
   cmos_do_probe()
    rtc_device_register()
     __register_chrdev()
     cdev->owner = struct module*
                                     open("/dev/rtc0")
    rtc_device_unregister()
  module_put()
  free_module()
   module_free(mod->module_core)
   /* struct module *module is now
      freed */
                                      chrdev_open()
                                       spin_lock(cdev_lock)
                                       cdev_get()
                                        try_module_get()
                                         module_is_live()
                                         /* dereferences already
                                            freed struct module* */

Switch to devm_rtc_allocate_device/rtc_register_device to register the rtc
as late as possible.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-rk808.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -416,12 +416,11 @@ static int rk808_rtc_probe(struct platfo
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	rk808_rtc->rtc = devm_rtc_device_register(&pdev->dev, "rk808-rtc",
-						  &rk808_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rk808_rtc->rtc)) {
-		ret = PTR_ERR(rk808_rtc->rtc);
-		return ret;
-	}
+	rk808_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rk808_rtc->rtc))
+		return PTR_ERR(rk808_rtc->rtc);
+
+	rk808_rtc->rtc->ops = &rk808_rtc_ops;
 
 	rk808_rtc->irq = platform_get_irq(pdev, 0);
 	if (rk808_rtc->irq < 0) {
@@ -438,9 +437,10 @@ static int rk808_rtc_probe(struct platfo
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ %d: %d\n",
 			rk808_rtc->irq, ret);
+		return ret;
 	}
 
-	return ret;
+	return rtc_register_device(rk808_rtc->rtc);
 }
 
 static struct platform_driver rk808_rtc_driver = {
