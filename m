Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeEUKd2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:33:28 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:42781 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeEUKdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:33:20 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="12288588"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v6 1/9] MAINTAINERS: add generic resistive touchscreen adc
Date: Mon, 21 May 2018 13:27:49 +0300
Message-ID: <1526898477-9952-2-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526898477-9952-1-git-send-email-eugen.hristev@microchip.com>
References: <1526898477-9952-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for generic resistive touchscreen adc

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v3:
 - Changed source file name

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260..ce9720f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5943,6 +5943,12 @@ F:	drivers/base/power/domain*.c
 F:	include/linux/pm_domain.h
 F:	Documentation/devicetree/bindings/power/power_domain.txt
 
+GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
+M:	Eugen Hristev <eugen.hristev@microchip.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touchscreen/resistive-adc-touch.c
+
 GENERIC UIO DRIVER FOR PCI DEVICES
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	kvm@vger.kernel.org
-- 
2.7.4
