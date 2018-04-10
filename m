Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx49FAA17pv4GedQElBZmyEXIHcWlL1Iat+4+1PLw50paVkcNl9A1jOM/cbO2+Quo42Jdc0wg
ARC-Seal: i=1; a=rsa-sha256; t=1523385181; cv=none;
        d=google.com; s=arc-20160816;
        b=R59ddlyEDribUpLwejtjBvm7+0cErB/26nySb+RlKZplN3XqwhS8FKNUVm4GBHcdt4
         Qk08i8zAtk0hrx8XaFgYIas+xNo+1rrHf4ROq2cdc7iuPEvBicTMpXBspKISiktXWLu0
         bIGM47eUoEuZBRx5CGbvDgSPrVeIQ1NHQBflplzE0Bo1cUgSQS3DV1CA9SE6cwctaQHD
         6nfJdXfmUgyD2bByeb7QYcVObo9+BK8aJkwyuWWwGnI3NXZMsgD1wn6QkkTF37eLPdbl
         TPLr5ip2IEb1OkShwb6d6bsrGp9JANEaqpp72uDScIlZy/2HDCiE/A043rhIw3IxVoTQ
         vOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=TPpAiCWmXaR0LeLHhX2E2eQEEAJ9dY87OQlovNlN20A=;
        b=FK3AeqM49F0apNVQc9ZCchwFJcOUHXW8JYmpxKmSE9GKVwRSElx3XqjVKTCUhZpb51
         ybHYDnuHLpkc9kzZE6cIqCKLJCI+Mny/3yIpM45LpPCZ+fAbKgJ7x0qwlK7zrt4guwIU
         +i7fr0mzgNc3EOzC5qLQOW8DYlONUPddB2ZNzNLr9PUSq8iBAyYd4kppS6EbDy7qjbaJ
         LcUyNsYgHDA0QQqXG2FRLDwnH8HyPiwBT+DZmpRcK/0J7Apq7p0h/UcppZPoe2v7bM56
         s1mNE7bYMLukRyWlybghC1GK6nRbl8acYES07UR6/pf2ip/guDutpYtu+SlXzxZKB1CN
         vunw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="219323772"
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
Subject: [PATCH v3 07/10] Documentation: dt-bindings: Add documents for PECI hwmon client drivers
Date: Tue, 10 Apr 2018 11:32:09 -0700
Message-Id: <20180410183212.16787-8-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385139320717723?=
X-GMAIL-MSGID: =?utf-8?q?1597385139320717723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds dt-bindings documents for PECI cputemp and dimmtemp client
drivers.

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
 .../devicetree/bindings/hwmon/peci-cputemp.txt     | 24 +++++++++++++++++++++
 .../devicetree/bindings/hwmon/peci-dimmtemp.txt    | 25 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt

diff --git a/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
new file mode 100644
index 000000000000..d5530ef9cfd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
@@ -0,0 +1,24 @@
+Bindings for Intel PECI (Platform Environment Control Interface) cputemp driver.
+
+Required properties:
+- compatible : Should be "intel,peci-cputemp".
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
+		peci-cputemp@cpu0 {
+			compatible = "intel,peci-cputemp";
+			reg = <0x30>;
+		};
+
+		peci-cputemp@cpu1 {
+			compatible = "intel,peci-cputemp";
+			reg = <0x31>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt b/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
new file mode 100644
index 000000000000..56e5deb61e5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
@@ -0,0 +1,25 @@
+Bindings for Intel PECI (Platform Environment Control Interface) dimmtemp
+driver.
+
+Required properties:
+- compatible : Should be "intel,peci-dimmtemp".
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
+		peci-dimmtemp@cpu0 {
+			compatible = "intel,peci-dimmtemp";
+			reg = <0x30>;
+		};
+
+		peci-dimmtemp@cpu1 {
+			compatible = "intel,peci-dimmtemp";
+			reg = <0x31>;
+		};
+	};
-- 
2.16.2
