Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753729AbeFASXo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:23:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:8640 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753123AbeFASWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:22:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="54069855"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH linux-next v5 09/13] dt-bindings: hwmon: Add documents for PECI hwmon client drivers
Date: Fri,  1 Jun 2018 11:22:35 -0700
Message-Id: <20180601182235.23983-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds dt-bindings documents for PECI hwmon client drivers.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
Reviewed-by: James Feist <james.feist@linux.intel.com>
Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason M Biils <jason.m.bills@linux.intel.com>
Cc: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/hwmon/peci-cputemp.txt      | 11 +++++++++++
 .../devicetree/bindings/hwmon/peci-dimmtemp.txt     | 13 +++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt

diff --git a/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
new file mode 100644
index 000000000000..19c7da57deab
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
@@ -0,0 +1,11 @@
+Bindings for Intel PECI (Platform Environment Control Interface) cputemp driver.
+
+Required properties:
+- compatible : Should be "intel,peci-cputemp".
+
+This node is a subnode of the PECI client MFD.
+
+Example:
+	peci-cputemp {
+		compatible = "intel,peci-cputemp";
+	};
diff --git a/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt b/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
new file mode 100644
index 000000000000..f390900a62b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
@@ -0,0 +1,13 @@
+Bindings for Intel PECI (Platform Environment Control Interface) dimmtemp
+driver.
+
+Required properties:
+- compatible : Should be "intel,peci-dimmtemp".
+
+This node is a subnode of the PECI client MFD.
+
+Example:
+	peci-dimmtemp@30 {
+		compatible = "intel,peci-dimmtemp";
+		reg = <0x30>;
+	};
\ No newline at end of file
-- 
2.17.0
