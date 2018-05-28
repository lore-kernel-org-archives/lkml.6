Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422967AbeE1LDw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422940AbeE1LDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:03:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@axis.com>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 451/496] pinctrl: artpec6: dt: add missing pin group uart5nocts
Date: Mon, 28 May 2018 12:03:56 +0200
Message-Id: <20180528100338.904174825@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@axis.com>

[ Upstream commit 7e065fb9ccce89fe667fdbd9a177eaec59a359fc ]

Add missing pin group uart5nocts (all pins except cts), which has been
supported by the artpec6 pinctrl driver since its initial submission.

Fixes: 00df0582eab1 ("pinctrl: Add pincontrol driver for ARTPEC-6 SoC")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
@@ -20,7 +20,8 @@ Required subnode-properties:
 		gpio: cpuclkoutgrp0, udlclkoutgrp0, i2c1grp0, i2c2grp0,
 		      i2c3grp0, i2s0grp0, i2s1grp0, i2srefclkgrp0, spi0grp0,
 		      spi1grp0, pciedebuggrp0, uart0grp0, uart0grp1, uart1grp0,
-		      uart2grp0, uart2grp1, uart3grp0, uart4grp0, uart5grp0
+		      uart2grp0, uart2grp1, uart3grp0, uart4grp0, uart5grp0,
+		      uart5nocts
 		cpuclkout: cpuclkoutgrp0
 		udlclkout: udlclkoutgrp0
 		i2c1: i2c1grp0
@@ -37,7 +38,7 @@ Required subnode-properties:
 		uart2: uart2grp0, uart2grp1
 		uart3: uart3grp0
 		uart4: uart4grp0
-		uart5: uart5grp0
+		uart5: uart5grp0, uart5nocts
 		nand: nandgrp0
 		sdio0: sdio0grp0
 		sdio1: sdio1grp0
