Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeEDOSl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:18:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:5630 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbeEDORu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:17:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400";
   d="scan'208";a="196735537"
From: richard.gong@linux.intel.com
To: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org,
        mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        yves.vandervennet@linux.intel.com, richard.gong@linux.intel.com,
        richard.gong@intel.com
Subject: [PATCHv4 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
Date: Fri,  4 May 2018 09:21:34 -0500
Message-Id: <1525443697-31009-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525443697-31009-1-git-send-email-richard.gong@linux.intel.com>
References: <1525443697-31009-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Tull <atull@kernel.org>

Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.

Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: this patch is added in patch set version 2
v3: change to put fpga_mgr node under firmware/svc node
v4: s/fpga-mgr@0/fpga-mgr/ to remove unit_address
    Add Richard's signed-off-by
---
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt

diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
new file mode 100644
index 0000000..6e03f79
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
@@ -0,0 +1,17 @@
+Intel Stratix10 SoC FPGA Manager
+
+Required properties:
+The fpga_mgr node has the following mandatory property, must be located under
+firmware/svc node.
+
+- compatible : should contain "intel,stratix10-soc-fpga-mgr"
+
+Example:
+
+	firmware {
+		svc {
+			fpga_mgr: fpga-mgr {
+				compatible = "intel,stratix10-soc-fpga-mgr";
+			};
+		};
+	};
-- 
2.7.4
