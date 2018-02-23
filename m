Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeBWOki (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:40:38 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38353 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeBWOkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:40:35 -0500
X-Google-Smtp-Source: AG47ELvByLnNiciUARXjKqESNZCG+neppvQdRoJ1UJJ71DroKNMegXgcGpFNYFA5l780T6dx3to3Dg==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/8] dt-bindings: xilinx: Add description for ZynqMP
Date: Fri, 23 Feb 2018 15:40:23 +0100
Message-Id: <0bff485b7ad09c0f1e23e82464382b43a918b84d.1519396753.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1519396753.git.michal.simek@xilinx.com>
References: <cover.1519396753.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1519396753.git.michal.simek@xilinx.com>
References: <cover.1519396753.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record xlnx,zynqmp compatible string.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

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
