Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757179AbeEJKvx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:51:53 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:10636 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934744AbeEJKtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:49:11 -0400
X-IronPort-AV: E=Sophos;i="5.49,385,1520924400";
   d="scan'208";a="11917218"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v5 3/9] dt-bindings: input: touchscreen: add minimum pressure touchscreen property
Date: Thu, 10 May 2018 13:45:08 +0300
Message-ID: <1525949114-29263-4-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
References: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
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
Changes in v5:
 - Modified property name to touchscreen-min-pressure from
touchscreen-threshold-property

 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
index 537643e..d092d5d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
@@ -7,6 +7,9 @@ Optional properties for Touchscreens:
 				  (in pixels)
  - touchscreen-max-pressure	: maximum reported pressure (arbitrary range
 				  dependent on the controller)
+ - touchscreen-min-pressure	: minimum pressure on the touchscreen to be
+				  achieved in order for the touchscreen
+				  driver to report a touch event.
  - touchscreen-fuzz-x		: horizontal noise value of the absolute input
 				  device (in pixels)
  - touchscreen-fuzz-y		: vertical noise value of the absolute input
-- 
2.7.4
