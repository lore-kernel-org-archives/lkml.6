Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754426AbeBGNsI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:48:08 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52411 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754145AbeBGNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:46:07 -0500
X-Google-Smtp-Source: AH8x227utEs0OLEQ98JQ8xL2wwRalBYGsXeXgCasjdnw0DndqOQEQMWg6wik/gyx+uMTwItaHTUunw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/7] dt-bindings: soc: new driver for DaVinci genpd
Date: Wed,  7 Feb 2018 14:45:47 +0100
Message-Id: <20180207134553.13510-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180207134553.13510-1-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a simple document for the DaVinci genpd driver. We use clock pm
exclusively hence no reg property.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/soc/ti,davinci-pm-domains.txt       | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt

diff --git a/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
new file mode 100644
index 000000000000..935d063c7b35
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
@@ -0,0 +1,13 @@
+Device tree bindings for the genpd driver for Texas Instruments DaVinci SoCs
+
+Required properties:
+
+- compatible:           must be "ti,davinci-pm-domains"
+- #power-domain-cells:  must be 0
+
+Example:
+
+pwc1: power-controller@227000 {
+	compatible = "ti,davinci-pm-domains";
+	#power-domain-cells = <0>;
+};
-- 
2.16.1
