Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDPPpg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:45:36 -0400
Received: from mail.coding4coffee.org ([5.9.171.142]:36512 "EHLO
        mail.coding4coffee.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeDPPpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:45:34 -0400
From: Fabian Mewes <architekt@coding4coffee.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lukas Wunner <lukas@wunner.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabian Mewes <architekt@coding4coffee.org>
Subject: [PATCH] dt-bindings: iio: adc: mcp320x: Use vendor prefix compatible strings
Date: Mon, 16 Apr 2018 17:34:06 +0200
Message-Id: <1523892846-25000-1-git-send-email-architekt@coding4coffee.org>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the example to use the compatible string including the
vendor prefix instead of the ones deprecated in 3a872138e4b.

Signed-off-by: Fabian Mewes <architekt@coding4coffee.org>
---
 Documentation/devicetree/bindings/iio/adc/mcp320x.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
index 7d64753..56373d6 100644
--- a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
+++ b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
@@ -49,7 +49,7 @@ Required properties:
 Examples:
 spi_controller {
 	mcp3x0x@0 {
-		compatible = "mcp3002";
+		compatible = "microchip,mcp3002";
 		reg = <0>;
 		spi-max-frequency = <1000000>;
 		vref-supply = <&vref_reg>;
-- 
1.7.10.4
