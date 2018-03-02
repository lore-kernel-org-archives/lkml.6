Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428143AbeCBTEq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:04:46 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46975 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428129AbeCBTEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:04:42 -0500
X-Google-Smtp-Source: AG47ELvD5Nxdp+cG9mjk+i/t+8OxvYLKrekBfMiiEXwEkGifaGX6eIpn1NHy0xofBoi7d4Mxzshunw==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/8] dt-bindings: xilinx: Add description for ZynqMP
Date: Fri,  2 Mar 2018 20:04:27 +0100
Message-Id: <c6297bd755cd2eb5eea576c05ba2c9e68e7943d7.1520017397.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record xlnx,zynqmp compatible string.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3: None
Changes in v2:
- New patch in this series

 Documentation/devicetree/bindings/arm/xilinx.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 1f7995357888..549e70a022cb 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -5,3 +5,13 @@ shall have the following properties.
 
 Required root node properties:
     - compatible = "xlnx,zynq-7000";
+
+---------------------------------------------------------------
+
+Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
+
+Boards with ZynqMP SOC based on an ARM Cortex A53 processor
+shall have the following properties.
+
+Required root node properties:
+    - compatible = "xlnx,zynqmp";
-- 
1.9.1
