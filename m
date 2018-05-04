Return-Path: <yong.deng@magewell.com>
X-Google-Smtp-Source: AB8JxZoTKrDe8K2kYXOgXKgjpDo7bOjdJZxQgvZJ4+iB35ycei9Xcsho5ODRkFyJVJksmFVgIdIP
ARC-Seal: i=1; a=rsa-sha256; t=1525416455; cv=none;
        d=google.com; s=arc-20160816;
        b=KLPiGcNX5JfzICG1QH9AJK9sfA5MOBrSbhhUKmBxJAd2SKuxBECJf0fK7x1VtyQaXC
         MfeKxYxWuZnkGCZkzzcgm1fSCeQYTChAdR6GMicgfJCrlbBLUXhR5jFY3C8sRTAzl8NR
         8So1fom9oAeg0h04OZUhbKGlre7OoUASg6enIIpInz29zQTy+XEClUZNt6WE3/OPdcKX
         mVbePUAbnH7RFh6fNhHGkSoxqgOTU2rP7eEq2REJDKzOpgCPgc5ISd5xtm9h8sFmnWEO
         1Su953w/bUYhyzUX+xscBtgop3r1Pl1cQ8qHolwROQfKOB6dfn7V1ZD6bhOEkwQlS6Vo
         Sw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=As5qJin095uKzz2X+5kh6TDdZejHT3iaLxJGloUt/rY=;
        b=KTqfWlOEObwWqLXzgtslkJXNF2zw3yAppkovsR78advnIjez5+FEfT8M4LPI+hFQ8M
         kDnAGqlr55NHfShNIRbZ4wUHHROhsjp386kSnvSFfwWNPKloHfkpEAFoS+mZjeydc8OL
         wi4O9pr9qDhr1TGvkDCCSFWd3NmXYTbKbew45/8Rl+GSHSlpMiwUab7nXhW5NJfao3H/
         t55GuJJfZ/y6vLL0CVN7E1Ep+BSvEqfntK3segnrXKhZCNmXSSBE3pg7R54ITphW/bqt
         3XuYSWgYOtu4nlFCfaYbPohtWo00T83gyvtV76TgLzrKJovi/yMp0yesf7XviKdrJ+PA
         vDmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yong.deng@magewell.com designates 198.11.139.37 as permitted sender) smtp.mailfrom=yong.deng@magewell.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yong.deng@magewell.com designates 198.11.139.37 as permitted sender) smtp.mailfrom=yong.deng@magewell.com
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09522017|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03272;MF=yong.deng@magewell.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.BvOavZg_1525416427;
From: Yong Deng <yong.deng@magewell.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Yong Deng <yong.deng@magewell.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Jacob Chen <jacob-chen@iotwrt.com>,
	Yannick Fertre <yannick.fertre@st.com>,
	Thierry Reding <treding@nvidia.com>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Todor Tomov <todor.tomov@linaro.org>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: [PATCH v10 1/2] dt-bindings: media: Add Allwinner V3s Camera Sensor Interface (CSI)
Date: Fri,  4 May 2018 14:46:23 +0800
Message-Id: <1525416383-36184-1-git-send-email-yong.deng@magewell.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599515084978539237?=
X-GMAIL-MSGID: =?utf-8?q?1599515084978539237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add binding documentation for Allwinner V3s CSI.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yong Deng <yong.deng@magewell.com>
---
 .../devicetree/bindings/media/sun6i-csi.txt        | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
new file mode 100644
index 000000000000..2ff47a9507a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -0,0 +1,59 @@
+Allwinner V3s Camera Sensor Interface
+-------------------------------------
+
+Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
+interface and CSI1 is used for parallel interface.
+
+Required properties:
+  - compatible: value must be "allwinner,sun8i-v3s-csi"
+  - reg: base address and size of the memory-mapped region.
+  - interrupts: interrupt associated to this IP
+  - clocks: phandles to the clocks feeding the CSI
+    * bus: the CSI interface clock
+    * mod: the CSI module clock
+    * ram: the CSI DRAM clock
+  - clock-names: the clock names mentioned above
+  - resets: phandles to the reset line driving the CSI
+
+Each CSI node should contain one 'port' child node with one child 'endpoint'
+node, according to the bindings defined in
+Documentation/devicetree/bindings/media/video-interfaces.txt. As mentioned
+above, the endpoint's bus type should be MIPI CSI-2 for CSI0 and parallel or
+Bt656 for CSI1.
+
+Endpoint node properties for CSI1
+---------------------------------
+
+- remote-endpoint	: (required) a phandle to the bus receiver's endpoint
+			   node
+- bus-width:		: (required) must be 8, 10, 12 or 16
+- pclk-sample		: (optional) (default: sample on falling edge)
+- hsync-active		: (only required for parallel)
+- vsync-active		: (only required for parallel)
+
+Example:
+
+csi1: csi@1cb4000 {
+	compatible = "allwinner,sun8i-v3s-csi";
+	reg = <0x01cb4000 0x1000>;
+	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&ccu CLK_BUS_CSI>,
+		 <&ccu CLK_CSI1_SCLK>,
+		 <&ccu CLK_DRAM_CSI>;
+	clock-names = "bus", "mod", "ram";
+	resets = <&ccu RST_BUS_CSI>;
+
+	port {
+		/* Parallel bus endpoint */
+		csi1_ep: endpoint {
+			remote-endpoint = <&adv7611_ep>;
+			bus-width = <16>;
+
+			/* If hsync-active/vsync-active are missing,
+			   embedded BT.656 sync is used */
+			hsync-active = <0>; /* Active low */
+			vsync-active = <0>; /* Active low */
+			pclk-sample = <1>;  /* Rising */
+		};
+	};
+};
-- 
1.8.3.1
