Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031448AbeEXRuu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:50:50 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33466 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031152AbeEXRui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:50:38 -0400
X-Google-Smtp-Source: AB8JxZqEtT8IK7+qjqCfLBYXK/QxzW4DMNurCPIYQYdOLKFHXEWmAvHTt5AYuqsrtwUz4oEwPjk3Rg==
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/8] arm: dts: bcm283x: mark the UART pin muxing nodes with pinctrl-use-default
Date: Thu, 24 May 2018 12:50:20 -0500
Message-Id: <20180524175024.19874-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/bcm283x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index ac00e730f898..c8b8ede3d273 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -321,6 +321,7 @@
 			};
 
 			uart0_gpio14: uart0_gpio14 {
+				pinctrl-use-default;
 				brcm,pins = <14 15>;
 				brcm,function = <BCM2835_FSEL_ALT0>;
 			};
@@ -353,6 +354,7 @@
 			};
 
 			uart1_gpio14: uart1_gpio14 {
+				pinctrl-use-default;
 				brcm,pins = <14 15>;
 				brcm,function = <BCM2835_FSEL_ALT5>;
 			};
-- 
2.17.0
