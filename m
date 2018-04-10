Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx4//2vfCx4fljoW3s/gILwCRPUOMTpjXSCyM/CMtmZuOJ3rp2KHm8N/OU6CnwZJyAfZqasK4
ARC-Seal: i=1; a=rsa-sha256; t=1523385177; cv=none;
        d=google.com; s=arc-20160816;
        b=JXgKiFtV+pee6d1XkgmovEDK80eVpIvgttvTLjUPVq/EA5PElufph3EQ1wPJhLcFHB
         zJlsINPyjlPRSGAULetVQuFUtUlOBxQHiQbE6XWaVyULCQAf0feRbXlRdqDBbZqq47TW
         Eir7l1hKfVx7y/SmGaUQj/v2YDZSJ3EezlaP7t562LDqH1ccMRiZ6o6rVdoLlfXVYTnG
         mp6cJtQFVpp/1EwfzJQ7ATs9PO4vhweNsswVBGFJfB00ny/tnXMX5qMl0rSjtKAceVfd
         bX7j1fI2rk5VfS1CXWM1no4pUJHtr5KGalxsbRa0p9VmZ+83LqMOcKrYUL/NylMHtuz+
         qC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=VM0b6/FbKsXsA9NEIzcEkRnUeF4o/EDxe9PEbAFQyQc=;
        b=jLCC4k1w2TvLnuh1IaTy4u+UN4ozAvhp2RmbotL7+luLweY0sM7GJAQXu0LZ5f+89T
         GH8wUdkxz9eth8tUxNHL4t+UlNImT504mS8x2AHU6fkVECSABkKSvv9gRgi4tw5Qop4m
         mQdAlWfn4TCV+EnC2jqUqVFvAoKUh56r1hjTJHjw0jOFb636rQ+/xUDonwCPOWeGq4Y5
         vTJo17o+V7dl8t1VqwpOVxG68+Ol2FgujK4sx4N/y4yyd4Zlw2ZVVaP23lAlearKTUbU
         l/gMt8DgMohEWJj/bLq2mdXkxQAj+y0R/j5A4A7JZBb8QoVSzpEG8odnJjs8dt87oJLB
         C+pw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="219323751"
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
Subject: [PATCH v3 04/10] Documentations: dt-bindings: Add a document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
Date: Tue, 10 Apr 2018 11:32:06 -0700
Message-Id: <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135853793781?=
X-GMAIL-MSGID: =?utf-8?q?1597385135853793781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds a dt-bindings document of PECI adapter driver for Aspeed
AST24xx/25xx SoCs.

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
 .../devicetree/bindings/peci/peci-aspeed.txt       | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt

diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
new file mode 100644
index 000000000000..4598bb8c20fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
@@ -0,0 +1,60 @@
+Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
+
+Required properties:
+- compatible        : Should be "aspeed,ast2400-peci" or "aspeed,ast2500-peci"
+		      - aspeed,ast2400-peci: Aspeed AST2400 family PECI
+					     controller
+		      - aspeed,ast2500-peci: Aspeed AST2500 family PECI
+					     controller
+- reg               : Should contain PECI controller registers location and
+		      length.
+- #address-cells    : Should be <1>.
+- #size-cells       : Should be <0>.
+- interrupts        : Should contain PECI controller interrupt.
+- clocks            : Should contain clock source for PECI controller.
+		      Should reference clkin.
+- clock_frequency   : Should contain the operation frequency of PECI controller
+		      in units of Hz.
+		      187500 ~ 24000000
+
+Optional properties:
+- msg-timing-nego   : Message timing negotiation period. This value will
+		      determine the period of message timing negotiation to be
+		      issued by PECI controller. The unit of the programmed
+		      value is four times of PECI clock period.
+		      0 ~ 255 (default: 1)
+- addr-timing-nego  : Address timing negotiation period. This value will
+		      determine the period of address timing negotiation to be
+		      issued by PECI controller. The unit of the programmed
+		      value is four times of PECI clock period.
+		      0 ~ 255 (default: 1)
+- rd-sampling-point : Read sampling point selection. The whole period of a bit
+		      time will be divided into 16 time frames. This value will
+		      determine the time frame in which the controller will
+		      sample PECI signal for data read back. Usually in the
+		      middle of a bit time is the best.
+		      0 ~ 15 (default: 8)
+- cmd_timeout_ms    : Command timeout in units of ms.
+		      1 ~ 60000 (default: 1000)
+
+Example:
+	peci: peci@1e78b000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x1e78b000 0x60>;
+
+		peci0: peci-bus@0 {
+			compatible = "aspeed,ast2500-peci";
+			reg = <0x0 0x60>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <15>;
+			clocks = <&clk_clkin>;
+			clock-frequency = <24000000>;
+			msg-timing-nego = <1>;
+			addr-timing-nego = <1>;
+			rd-sampling-point = <8>;
+			cmd-timeout-ms = <1000>;
+		};
+	};
-- 
2.16.2
