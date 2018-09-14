Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F27C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41E720866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41E720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeINNrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:47:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34052 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeINNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:47:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id c29-v6so7162800lfj.1;
        Fri, 14 Sep 2018 01:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LyoU4bQEGudsJlLrwE1nHlFKHoOx2W5+y2PvgatmyhU=;
        b=jScaevpeJDglQEe7Qe8XQqgbmr1sEnJxO4dGS+z4PsXLCag34qBQOoUgVoOkaVe8ux
         pfw2mGtTV/iVJKYxFpkQQ9JTZBDzeusGcY6yLpxU5VKaKmTX+9/SySL/Kwm76RTTcitG
         Giosis6UIZqLLsflwpAhcX1tDzg86Y1abnrbSjhjKR7j7M1WDdBeJKuMQ54szEOxS3Rh
         TxHEry9fguNMu4i9LEpUb8EjruNWX7079KaZwELl6lXKxrXUe3zNKjEqNBOOYfTsj56D
         l5AhJ057ijAPJoAC82AfiVkwhkqFSRjmuYY7TZJ+Dw8VLG6E81ihuNdzNMt8AT4/5UsB
         7iHw==
X-Gm-Message-State: APzg51DYQ/cZkp2qceEQGQ2KRKqxziVX1c8oRzaOZC0ZCL9Dd6WfTdD2
        Zv0rXXoCKRcD7OWzCe4FoI4=
X-Google-Smtp-Source: ANB0VdbI/bWFUVApo5ZeOguXUntVipxpjPe6Vt1czWkJ0lJ36WyYyiO6RNjPQHar8Yzq5X757MD4Ug==
X-Received: by 2002:a19:1065:: with SMTP id f98-v6mr7308812lfi.88.1536914055348;
        Fri, 14 Sep 2018 01:34:15 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id i1-v6sm1078206ljg.43.2018.09.14.01.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 01:34:14 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:34:02 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, sboyd@kernel.org,
        mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 7/7] regulator: bd718xx: rename bd71837 to 718xx
Message-ID: <6b3e7b3aeef67d85083f49894e0b0fe482fc08c4.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rename bd71837-regulator.c to bd718x7-regulator.c to reflect the
fact that also BD71847 is now supported by the driver.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/Kconfig                                      | 2 +-
 drivers/regulator/Makefile                                     | 2 +-
 drivers/regulator/{bd71837-regulator.c => bd718x7-regulator.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/regulator/{bd71837-regulator.c => bd718x7-regulator.c} (100%)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 329cdd33ed62..6e96ef1bd74a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -189,7 +189,7 @@ config REGULATOR_BD718XX
 	  and LDO regulators.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called bd71837-regulator.
+	  will be called bd718x7-regulator.
 
 config REGULATOR_BD9571MWV
 	tristate "ROHM BD9571MWV Regulators"
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 801d9a34a203..eac4d794f3b8 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
 obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
-obj-$(CONFIG_REGULATOR_BD718XX) += bd71837-regulator.o
+obj-$(CONFIG_REGULATOR_BD718XX) += bd718x7-regulator.o
 obj-$(CONFIG_REGULATOR_BD9571MWV) += bd9571mwv-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
 obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd718x7-regulator.c
similarity index 100%
rename from drivers/regulator/bd71837-regulator.c
rename to drivers/regulator/bd718x7-regulator.c
-- 
2.14.3

