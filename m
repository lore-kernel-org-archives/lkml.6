Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeCWNFR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:05:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50339 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752880AbeCWNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:05:06 -0400
X-Google-Smtp-Source: AG47ELt2FS6ctH3T7iCC7F8af/ji2KkPBNxXg9cAJBSDgMbO8usAgzL6JHNGVb4kqDb5SUji4LFNFg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 3/8] ARM: davinci: dts: add a reset control to the dsp node
Date: Fri, 23 Mar 2018 14:04:50 +0100
Message-Id: <20180323130455.11470-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180323130455.11470-1-brgl@bgdev.pl>
References: <20180323130455.11470-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The davinci-rproc driver will soon use the reset framework. Add the
resets property to the dsp node in da850.dtsi.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index dad64dbf1f23..5b485e44b83e 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -109,6 +109,7 @@
 		interrupt-parent = <&intc>;
 		interrupts = <28>;
 		clocks = <&psc0 15>;
+		resets = <&psc0 15>;
 		status = "disabled";
 	};
 	soc@1c00000 {
-- 
2.16.1
