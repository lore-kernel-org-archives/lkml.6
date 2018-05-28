Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424812AbeE1LT2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424686AbeE1LQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:16:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henry Zhang <henryzhang62@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 236/272] ARM: dts: bcm283x: Fix pin function of JTAG pins
Date: Mon, 28 May 2018 12:04:29 +0200
Message-Id: <20180528100300.176717942@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henry Zhang <henryzhang62@gmail.com>

[ Upstream commit 1a012cb2569f2031b3636232c3ab21c20c92d281 ]

BCM2835 ARM Peripherals doc shows gpio pins 4, 5, 6, 12 and 13
carry altenate function, ALT5 for ARM JTAG

Fixes: 21ff843931b2 ("ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.")

Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/bcm283x.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -252,7 +252,7 @@
 
 			jtag_gpio4: jtag_gpio4 {
 				brcm,pins = <4 5 6 12 13>;
-				brcm,function = <BCM2835_FSEL_ALT4>;
+				brcm,function = <BCM2835_FSEL_ALT5>;
 			};
 			jtag_gpio22: jtag_gpio22 {
 				brcm,pins = <22 23 24 25 26 27>;
