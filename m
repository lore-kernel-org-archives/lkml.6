Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbeCFPNi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:13:38 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39744 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeCFPNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:13:37 -0500
X-Google-Smtp-Source: AG47ELuxjAnX7L1bg9knU4QmA15wWz0y5tF/nI9MDtObEV4nhG90bFu2HnPGQDqvTVp9KFHZjlgU6w==
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] MAINTAINERS: Add linux/of_*.h headers to appropriate subsystems
Date: Tue,  6 Mar 2018 09:13:34 -0600
Message-Id: <20180306151334.28720-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DeviceTree support code for specific subsystems are maintained by
the respective subsystem maintainers. However, only the DT
maintainers are listed for most of the linux/of_*.h headers. Fix this
and add the headers to the appropriate subsystem maintainer.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a12af4f180..248f4266c6bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4333,6 +4333,7 @@ Q:	https://patchwork.kernel.org/project/linux-dmaengine/list/
 S:	Maintained
 F:	drivers/dma/
 F:	include/linux/dmaengine.h
+F:	include/linux/of_dma.h
 F:	Documentation/devicetree/bindings/dma/
 F:	Documentation/driver-api/dmaengine/
 T:	git git://git.infradead.org/users/vkoul/slave-dma.git
@@ -6033,6 +6034,7 @@ F:	Documentation/ABI/obsolete/sysfs-gpio
 F:	drivers/gpio/
 F:	include/linux/gpio/
 F:	include/linux/gpio.h
+F:	include/linux/of_gpio.h
 F:	include/asm-generic/gpio.h
 F:	include/uapi/linux/gpio.h
 F:	tools/gpio/
@@ -7321,6 +7323,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iommu/
 F:	drivers/iommu/
 F:	include/linux/iommu.h
+F:	include/linux/of_iommu.h
 F:	include/linux/iova.h
 
 IP MASQUERADING
@@ -10712,6 +10715,7 @@ F:	drivers/acpi/pci*
 F:	drivers/pci/
 F:	include/asm-generic/pci*
 F:	include/linux/pci*
+F:	include/linux/of_pci.h
 F:	include/uapi/linux/pci*
 F:	lib/pci*
 F:	arch/x86/pci/
-- 
2.14.1
