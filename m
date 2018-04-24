Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3617087-1524602059-2-9811122249015588348
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES encaro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524602058; b=Gv93OgQVHbWOsKtf/I8g1L0k74kpARMwpmUTWj0uiP+GaKtqde
    gBUOqQfI70jWGqHJJHR7w54RXHwksZb6ODrjDDJtc2ZsDid/XnKUSuCtFWMiYCsS
    W/g986jLdak0Nhpxhu0uxcXKXZYC/MgBKWFw9M1TuK9mylYaBt5CGb7axq9IM6Qr
    dk7yOSSXPGE/I+Fgn62G6iOG7yqN+5nrFQVt4v3BYhXQhkGY2BOBBPvtnWjEujwY
    Om9BOG1m3biaLn2QwUKmoDDRr6neSkeow/4kjkIA4X+FRZNfMtCK8+p5+zu2pH1q
    P6bKIXO7E8LKi4adYWf/rpjpKW0TQW+cd0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524602058; bh=
    lUN2CVmp/JvcROn/d7Qo0F/KkkIIxVBXoBG639XpA/0=; b=p0ooaXCYeDSb86UI
    LR5E/JmwBlV3qM15fsivG/nBpy7c85kea0Ra0zjATHXw4SQ8cjs8WVy4vKZNrR8F
    lcE2aK6B7frr1WMB3dAm7ic+UAmzRUC8YpYb4CpsYqFrXdrr4GOQUfgxNwUVqs9w
    JtNSvczV1a67wzOtbhEBAnjyvJnGb7dzCNleakQzF1GTFpmDU9UL3Rf7KTvDDCba
    txgndyzzFUFblVeT0peAtYXA9uWxKBnzasnzM4gtueY+VTuHfZj6mnOulzNV3Wwk
    SOVkHxUdQXtGKFUTtm5hbdrpwtZmdW2sDv5InhNL66t25NSEAj286TwmFOVFRBnj
    CGUD1Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfK6fq+q7jkGIhDAV0H7nNtkWcl7ZNCNyTmi2pbr9lDWqG62Vvl7AsxXtnyHTyL1GAx01Cz2rHAnkgh0V6ZFJ+ZP10gALLHwqBt45Fc9unuPIyXOYrs8C
    bYxoHde/49GBeLZSS/qidz+4D/wY5h0Zr/Db6rhU77SifySt6JA7QdonERNLq6wtgzkBpXY0kqTtZ5Fa3h/r6L/D6icmfBewaIg3WgNSGsOFMSuvgFdINY5m
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=v_aFM6XbzrSpdwGTRdgA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeDXUeO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 16:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751654AbeDXUeH (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 24 Apr 2018 16:34:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C365721835
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
Subject: [RFC 08/10] spi: s3c64xx: samsung: Remove support for Exynos5440
Date: Tue, 24 Apr 2018 22:32:37 +0200
Message-Id: <20180424203239.21885-9-krzk@kernel.org>
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
 drivers/spi/spi-s3c64xx.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 755ab2dc6969..f55dc78957ad 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1376,15 +1376,6 @@ static struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 	.clk_from_cmu	= true,
 };
 
-static struct s3c64xx_spi_port_config exynos5440_spi_port_config = {
-	.fifo_lvl_mask	= { 0x1ff },
-	.rx_lvl_offset	= 15,
-	.tx_st_done	= 25,
-	.high_speed	= true,
-	.clk_from_cmu	= true,
-	.quirks		= S3C64XX_SPI_QUIRK_POLL,
-};
-
 static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F, 0x7F, 0x7F, 0x1ff},
 	.rx_lvl_offset	= 15,
@@ -1428,9 +1419,6 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,exynos4210-spi",
 			.data = (void *)&exynos4_spi_port_config,
 	},
-	{ .compatible = "samsung,exynos5440-spi",
-			.data = (void *)&exynos5440_spi_port_config,
-	},
 	{ .compatible = "samsung,exynos7-spi",
 			.data = (void *)&exynos7_spi_port_config,
 	},
-- 
2.14.1

