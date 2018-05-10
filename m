Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934581AbeEJKtH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:49:07 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:29303 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756988AbeEJKtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:49:05 -0400
X-IronPort-AV: E=Sophos;i="5.49,385,1520924400";
   d="scan'208";a="11917215"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v5 1/9] MAINTAINERS: add generic resistive touchscreen adc
Date: Thu, 10 May 2018 13:45:06 +0300
Message-ID: <1525949114-29263-2-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
References: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
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
