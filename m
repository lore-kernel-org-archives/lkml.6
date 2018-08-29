Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A565C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19F520868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19F520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeH2Qgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:36:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42151 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2Qgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:36:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so4229054ljc.9;
        Wed, 29 Aug 2018 05:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LyoU4bQEGudsJlLrwE1nHlFKHoOx2W5+y2PvgatmyhU=;
        b=MA+SM4fMEwgYAWzUvn4NdgWxtX7nfPFg0MfwoqKBcrn2Sv2pWT8QFnWKJHB18gtMNd
         M8rEQefl8rvSlzJhn19pV1HqSniJ/XhVwqFctQWCuLpgdVL087moftRCZBLlPwsoLBum
         dQAutZz8POw55y1nbpigeb6DINVQaXeBsdoalE6go1swoxufUmanJ4sRgKGTCz+CE3h9
         TNynjU8tL4OhIaq1ZEawTfnOLY/bzEM1GYA7c5bAde4pkm/SlJLFlKc2w8i4r8PVH0s/
         UjlaQks8xSxc30u2J0SDIyu2KCkYUpTBPUnLGogJMNxGJPEe9kfkmVuHm86jtgiJjley
         kqQg==
X-Gm-Message-State: APzg51BD+Ipvkcx00WCGcMlJYO0vj+mbaRt77j4XkchzOx79/+L0E3v3
        gUdLQxePITrdBtoHPMYIuHo=
X-Google-Smtp-Source: ANB0VdZXFy+NSIOPNYlaPc8f2xx8AjsROkWf+M8Pdh2MHPiRU3N7q0BgseYUyV0mFWTVKpqFDvQJeA==
X-Received: by 2002:a2e:9d0c:: with SMTP id t12-v6mr4171536lji.75.1535546407173;
        Wed, 29 Aug 2018 05:40:07 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f14-v6sm753491lfm.29.2018.08.29.05.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 05:40:06 -0700 (PDT)
Date:   Wed, 29 Aug 2018 15:39:54 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH 8/8] regulator: bd718xx: renme bd71837 to 718xx
Message-ID: <9b442ffad56fad12a726dc9c0e4b07985adb8b8d.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
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

