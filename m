Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3617087-1524602069-2-11851743401914154049
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524602068; b=aJ/3tNcn3NKIFvsdRh8Zd+bi6bWJGM+xfB06jmI1AIsMOrKZFr
    vLunFJzcsJoU5V+Xirjdh8zrvbI60zE+zBV5lsmUpBHI7xaBXk7MYz0XmdZ2GPRX
    QtaHy1fehbqiz9PNaxTQCojFVJBgPdRkpOh62d0IA8ppcYSZime09rkYlBRM8K9P
    qPO6/Apey4acK1CvZpErbiVwFcW8fauCbHod80Xyh+gTt4UVUOOFTYr0XoTzP9d2
    iEgQuttNOa/X+KacBPjazeGAr9dRFQxBBTEbS6O7mZws3MN1XvOK3pxbpLu7cgpO
    1Rte6vW3auGWhIKao8MYB438cntyzTZP9aSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524602068; bh=
    cXrFt0SHGBNNWPIckyliEsSQEHwfeVySbKTqV+Cwx/g=; b=s6I3va6CQG6pLvsD
    BMhP8c/Lm8Vs5fArZkJjay/xvAqWQ8RMvS2XRu4ses23wiltFg+D1NAnlecVOsOb
    LlWs5EDYqi04UAAbmF3VOFHYal8ljJUJHb9LazlQgfP9f6VKY+ufORpn1tx7ksx8
    H2JhMiGndm1f2tWGiypuGYBemWWY3WwyKBo2DKan1PLxWN+haZEK0s1zhU+DJTsh
    y5r9Tu0gTLOZPe4vSbhfS+VqxDNQKY9X2pW5GHdRQMpNopdCVGz2786sA/AuOnJH
    B2i9nnxSy3a3Nkh3kCLc6ZDUKbE9XuHEC+Q252POFe7NTJfTdWjghhoigTUnDwZL
    kagEEg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGli+au1pENZV4hAlcURBSc/DWIlQuOmjSzwz50JaQcVFxFdBvzzGPm3qym9l57gIt9v8ktQKm+jh7s3gOKZUwKPppUGfLd0WHwdsdFVvdBNRnOt/3Q+
    Tax1576beYYWUz0ebCQye4tSV1AG/tLJkNOlA0HxiwaQV/JyMdkFpfz2Vgwo8gBA8Xyy+kWTPNGIv13PrZcMrGbn52MXOkIV1K5BQqtUScM79g7cQFKAYWCM
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=cqNmB-S35C9VADX0hDMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeDXUeY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 16:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbeDXUeO (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 24 Apr 2018 16:34:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F90217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC 09/10] usb: host: exynos: Remove support for Exynos5440
Date: Tue, 24 Apr 2018 22:32:38 +0200
Message-Id: <20180424203239.21885-10-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/host/ehci-exynos.c | 7 -------
 drivers/usb/host/ohci-exynos.c | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index d9145a8f35d2..8e3bab1e0c1f 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -161,16 +161,10 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 	}
 	exynos_ehci = to_exynos_ehci(hcd);
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-					"samsung,exynos5440-ehci"))
-		goto skip_phy;
-
 	err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
 	if (err)
 		goto fail_clk;
 
-skip_phy:
-
 	exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
 
 	if (IS_ERR(exynos_ehci->clk)) {
@@ -304,7 +298,6 @@ static const struct dev_pm_ops exynos_ehci_pm_ops = {
 #ifdef CONFIG_OF
 static const struct of_device_id exynos_ehci_match[] = {
 	{ .compatible = "samsung,exynos4210-ehci" },
-	{ .compatible = "samsung,exynos5440-ehci" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_ehci_match);
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index a39fae41bc70..c0c4dcca6f3c 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -130,15 +130,10 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 
 	exynos_ohci = to_exynos_ohci(hcd);
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-					"samsung,exynos5440-ohci"))
-		goto skip_phy;
-
 	err = exynos_ohci_get_phy(&pdev->dev, exynos_ohci);
 	if (err)
 		goto fail_clk;
 
-skip_phy:
 	exynos_ohci->clk = devm_clk_get(&pdev->dev, "usbhost");
 
 	if (IS_ERR(exynos_ohci->clk)) {
@@ -270,7 +265,6 @@ static const struct dev_pm_ops exynos_ohci_pm_ops = {
 #ifdef CONFIG_OF
 static const struct of_device_id exynos_ohci_match[] = {
 	{ .compatible = "samsung,exynos4210-ohci" },
-	{ .compatible = "samsung,exynos5440-ohci" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_ohci_match);
-- 
2.14.1

