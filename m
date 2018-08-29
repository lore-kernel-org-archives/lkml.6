Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06882C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B8720850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B8720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeH2Qex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:34:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45212 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2Qex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:34:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id u83-v6so4198572lje.12;
        Wed, 29 Aug 2018 05:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8wFaVwJDACO/Wpj2nhZNpv3v3aOBc2CLh46qDjkeFuk=;
        b=LGxaSsmySDvZU9MQao9VThWI7uRIa2L9IuQT+UNg0uL1LwlDmJkFPlna9oNHuq/bS7
         fOY7JzmvBvEUcDOBKqMR1h783I5ezR+4alsa/J0mDvhvLppv5VqIOrPw/a7ZYlWkhZiP
         JApMaFZzGq8l8bAem0R7zGTnjnAN4+UBP8w3370MOwH50wCBb59yDK0bx/DyKxhis1w+
         CsTyeO0ocUWyYk2QZLpOwpUGnj9cyueXMxGP5VldLmMVPq93yq1I4xjA5m/o1aTFWtMQ
         YdF829qAaQ1M3icSRmMStgAvevWmsVI4YUzjaaDhD1BkxORAUbIRGsLTZrvehD3xgk0d
         291Q==
X-Gm-Message-State: APzg51BKihaxLeiXYbp+ePAzuAOX/zGCPHZIHSYuJK4wuGVyx35a6ss5
        yxhr+Lyz3rVjZSULCTrLCT4=
X-Google-Smtp-Source: ANB0VdbKUDG+SXkqU0Ji9r/USli74gDc5bgJh4Xd/r8NLNiprzy8RBk3VnloHOLo+j5IG18QBm3zAg==
X-Received: by 2002:a2e:29da:: with SMTP id p87-v6mr4059596ljp.12.1535546287911;
        Wed, 29 Aug 2018 05:38:07 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d4-v6sm694041lfc.57.2018.08.29.05.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 05:38:07 -0700 (PDT)
Date:   Wed, 29 Aug 2018 15:37:55 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH 4/8] mfd: dt bindings: add BD71847 device-tree binding
 documentation
Message-ID: <09eceb20f4f05ac48c6767d5f3359743e5b98985.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
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

Add ROHM BD71847 Power Management IC MFD binding information to
device-tree binding documents.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt       | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
index 3ca56fdb5ffe..d78172878faa 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -1,16 +1,17 @@
-* ROHM BD71837 Power Management Integrated Circuit bindings
+* ROHM BD71837 and BD71847 Power Management Integrated Circuit bindings
 
-BD71837MWV is a programmable Power Management IC for powering single-core,
-dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for
-low BOM cost and compact solution footprint. It integrates 8 Buck
-egulators and 7 LDOs to provide all the power rails required by the SoC and
-the commonly used peripherals.
+BD71837MWV and BD71847MWV are programmable Power Management ICs for powering
+single-core, dual-core, and quad-core SoCs such as NXP-i.MX 8M. They are
+optimized for low BOM cost and compact solution footprint. BD71837MWV
+integrates 8 Buck regulators and 7 LDOs. BD71847MWV contains 6 Buck regulators
+and 6 LDOs.
 
-Datasheet for PMIC is available at:
+Datasheet for BD71837 is available at:
 https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
 
 Required properties:
- - compatible		: Should be "rohm,bd71837".
+ - compatible		: Should be "rohm,bd71837" for bd71837 and
+			  "rohm,bd71847" for bd71847.
  - reg			: I2C slave address.
  - interrupt-parent	: Phandle to the parent interrupt controller.
  - interrupts		: The interrupt line the device is connected to.
-- 
2.14.3

