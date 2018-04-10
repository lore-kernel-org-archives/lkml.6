Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753666AbeDJJLC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:11:02 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:47501 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbeDJJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:06:12 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517900400";
   d="scan'208";a="10408595"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 04/11] dt-bindings: input: touchscreen: add pressure threshold touchscreen property
Date: Tue, 10 Apr 2018 11:57:50 +0300
Message-ID: <1523350677-27106-5-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common touchscreen optional property that will specify
the minimum pressure applied to the screen that is needed
such that the driver will report the touch event.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
index 537643e..c84047a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
@@ -7,6 +7,9 @@ Optional properties for Touchscreens:
 				  (in pixels)
  - touchscreen-max-pressure	: maximum reported pressure (arbitrary range
 				  dependent on the controller)
+ - touchscreen-threshold-pressure: minimum pressure on the touchscreen to be
+				  achieved in order for the touchscreen
+				  driver to report a touch event.
  - touchscreen-fuzz-x		: horizontal noise value of the absolute input
 				  device (in pixels)
  - touchscreen-fuzz-y		: vertical noise value of the absolute input
-- 
2.7.4
