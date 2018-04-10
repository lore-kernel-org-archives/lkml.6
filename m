Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx49dH/prU3c+nkcNZ80Td78sNYATpQkL6y1nXSx2euRDRcnYsDNHyG6CZsNrRYIh5Azr9VfK
ARC-Seal: i=1; a=rsa-sha256; t=1523385166; cv=none;
        d=google.com; s=arc-20160816;
        b=kZG8plME/iImkHGBvg/Cdj49WnVIbqO4tWF6UpSqs9EZwJGZ2iKhvMRDATwW+B2ljP
         ENpLxCzl11SHe9NDMsyM6oObS2bjHCmK7Yp6ABgtbLV5hTOPVf/FgrzT5CnjeCNwU7DJ
         a4y91fZNU536HmarOEr7NrmDCOttHo3s+qCDWXcU5QJUipLr5aziNwMKKIcYdaa2Xsci
         rv5UWYxHbZEkzQ9lAql1PwJzDeIgD/e4lnA952DSqDqzSOX8XHusLiUkZpbyq1+ZQahO
         dogBzUY2o/SmM8zsFBACEV7n+8+v1wE7jeI41BVD8RJXWYuAabV191W2cc1AkjCK/6Bi
         W33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=C9kBqNWlbKVZh7Udk83kWNH3RvZW+NkMD8qwzFPiuNY=;
        b=pYApTC/Z0elfbI+gJGiDyb/haDqPErpFS43MJXcOP3d2edyezNG37hwv7alsWJaATs
         gdOAmqA2/ZCqS8OTpVx5Hiv7jRbU3D8jP+1+OacJgdep9lszRDVzlH1fA1WPPKi6BCjQ
         JUIKLsoUjEF1SgPAOJFh6Cvs2FnezS1C9dnTWvTSWSb3r/VY75ZrNuU+tEE22mhgnE/x
         WKzdt2CWsbFxOWG1ACCK/xVphhDLVnxK5geHBGbUTKwIWtlECMLDqWiX6jqkp1IBi33s
         u3mdQN8CSAaSQLlYnjc36PFodDJMPVQuFDeudjMv9sYf4vUE5g2lpr5tIFiDoEIKO3dE
         M8jA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="219323705"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: Alan Cox <alan@linux.intel.com>,
	Andrew Jeffery <andrew@aj.id.au>,
	Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Haiyue Wang <haiyue.wang@linux.intel.com>,
	James Feist <james.feist@linux.intel.com>,
	Jason M Biils <jason.m.bills@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Joel Stanley <joel@jms.id.au>,
	Julia Cartwright <juliac@eso.teric.us>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Milton Miller II <miltonm@us.ibm.com>,
	Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stef van Os <stef.van.os@prodrive-technologies.com>,
	Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
	Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v3 01/10] Documentations: dt-bindings: Add documents of generic PECI bus, adapter and client drivers
Date: Tue, 10 Apr 2018 11:32:03 -0700
Message-Id: <20180410183212.16787-2-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385124256903080?=
X-GMAIL-MSGID: =?utf-8?q?1597385124256903080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds documents of generic PECI bus, adapter and client drivers.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
Reviewed-by: James Feist <james.feist@linux.intel.com>
Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jason M Biils <jason.m.bills@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Julia Cartwright <juliac@eso.teric.us>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Milton Miller II <miltonm@us.ibm.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stef van Os <stef.van.os@prodrive-technologies.com>
Cc: Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>
---
 .../devicetree/bindings/peci/peci-adapter.txt      | 23 ++++++++++++++++++++
 .../devicetree/bindings/peci/peci-bus.txt          | 15 +++++++++++++
 .../devicetree/bindings/peci/peci-client.txt       | 25 ++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci-adapter.txt
 create mode 100644 Documentation/devicetree/bindings/peci/peci-bus.txt
 create mode 100644 Documentation/devicetree/bindings/peci/peci-client.txt

diff --git a/Documentation/devicetree/bindings/peci/peci-adapter.txt b/Documentation/devicetree/bindings/peci/peci-adapter.txt
new file mode 100644
index 000000000000..9221374f6b11
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci-adapter.txt
@@ -0,0 +1,23 @@
+Generic device tree configuration for PECI adapters.
+
+Required properties:
+- compatible     : Should contain hardware specific definition strings that can
+		   match an adapter driver implementation.
+- reg            : Should contain PECI controller registers location and length.
+- #address-cells : Should be <1>.
+- #size-cells    : Should be <0>.
+
+Example:
+	peci: peci@10000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10000000 0x1000>;
+
+		peci0: peci-bus@0 {
+			compatible = "soc,soc-peci";
+			reg = <0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/peci/peci-bus.txt b/Documentation/devicetree/bindings/peci/peci-bus.txt
new file mode 100644
index 000000000000..90bcc791ccb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci-bus.txt
@@ -0,0 +1,15 @@
+Generic device tree configuration for PECI buses.
+
+Required properties:
+- compatible     : Should be "simple-bus".
+- #address-cells : Should be <1>.
+- #size-cells    : Should be <1>.
+- ranges         : Should contain PECI controller registers ranges.
+
+Example:
+	peci: peci@10000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10000000 0x1000>;
+	};
diff --git a/Documentation/devicetree/bindings/peci/peci-client.txt b/Documentation/devicetree/bindings/peci/peci-client.txt
new file mode 100644
index 000000000000..8e2bfd8532f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci-client.txt
@@ -0,0 +1,25 @@
+Generic device tree configuration for PECI clients.
+
+Required properties:
+- compatible : Should contain target device specific definition strings that can
+	       match a client driver implementation.
+- reg        : Should contain address of a client CPU. Address range of CPU
+	       clients is starting from 0x30 based on PECI specification.
+	       <0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)
+
+Example:
+	peci-bus@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		< more properties >
+
+		function@cpu0 {
+			compatible = "device,function";
+			reg = <0x30>;
+		};
+
+		function@cpu1 {
+			compatible = "device,function";
+			reg = <0x31>;
+		};
+	};
-- 
2.16.2
