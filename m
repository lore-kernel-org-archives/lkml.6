Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx48GScgjRBrDetmyH2BMfL+PKa0oyNkmWSRdUljqeO1zFwYxSIG3mrE1RRwM9xo6YdygsSXT
ARC-Seal: i=1; a=rsa-sha256; t=1523385183; cv=none;
        d=google.com; s=arc-20160816;
        b=jXAstXsbD/+GhUB19KeRaNr9nEfQbZrQ6fG91xhPGMczVxyHcUDUsvWoxHyAppN6Ho
         Yi0UF1AFIQL0+I1fFGxcixYKkRrR8PPG5bLP7DSnZhvk9PTg3TOBnISLVpml0iRdIUBR
         0G41NI7xLKWPNtWKHsWMJyat+2PNWdy6KftTdO6K4MC0G0CRe3oiKRyEBwoZH6BN4wyO
         2uCGO2c9GpizZjqgXJHSfqNMiKH8xOH/bfdahzvg49VWw5oHikUu8UM/ZH5htjgRjRrQ
         jyzvUx7w93E9jscHC+MQpY2fzzfcYUDSLsdHYla/0SnN+uw7Dc6PKgeuVbcOlPB5UerK
         kGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=E1txUEkcB48EefOkw+2X736u8fKOOiLwfB+2vZzlI04=;
        b=MR/InROGbEBfKYOTAh/AzT2Sj9AIg5J3eZUIfKKI2Qe72p2oQXwNxISGkQcYguyZR+
         BEmH/bDuF9LYdZuRfYph7E4ojFPupp1288oiRbsBvFRvljtJeuqx7ToP8/VHjPP4/uef
         ZI9Yvz4H0LARG+hPlYFRskAW6ioHoV+0c8H6JJAz82BGDZtb+35Ns9i67VyJefkfVepl
         VHMji3dcg8GShiSvx+T0IWaZSASAAORRztm5KorFpwaXR3e9NF+cv2F9dkcaVc4zVeuS
         uz4f5HmwhmfI5BzPwGQgE46dwx2IBoOjL6OqXBU0tvOka1ZTkYuyJzmPgFJGvvdkYqha
         qhPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="219323785"
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
Subject: [PATCH v3 08/10] Documentation: hwmon: Add documents for PECI hwmon client drivers
Date: Tue, 10 Apr 2018 11:32:10 -0700
Message-Id: <20180410183212.16787-9-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385142356118267?=
X-GMAIL-MSGID: =?utf-8?q?1597385142356118267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds hwmon documents for PECI cputemp and dimmtemp drivers.

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
 Documentation/hwmon/peci-cputemp  | 88 +++++++++++++++++++++++++++++++++++++++
 Documentation/hwmon/peci-dimmtemp | 50 ++++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/hwmon/peci-cputemp
 create mode 100644 Documentation/hwmon/peci-dimmtemp

diff --git a/Documentation/hwmon/peci-cputemp b/Documentation/hwmon/peci-cputemp
new file mode 100644
index 000000000000..cdd5ea49a4a2
--- /dev/null
+++ b/Documentation/hwmon/peci-cputemp
@@ -0,0 +1,88 @@
+Kernel driver peci-cputemp
+==========================
+
+Supported chips:
+	One of Intel server CPUs listed below which is connected to a PECI bus.
+		* Intel Xeon E5/E7 v3 server processors
+			Intel Xeon E5-14xx v3 family
+			Intel Xeon E5-24xx v3 family
+			Intel Xeon E5-16xx v3 family
+			Intel Xeon E5-26xx v3 family
+			Intel Xeon E5-46xx v3 family
+			Intel Xeon E7-48xx v3 family
+			Intel Xeon E7-88xx v3 family
+		* Intel Xeon E5/E7 v4 server processors
+			Intel Xeon E5-16xx v4 family
+			Intel Xeon E5-26xx v4 family
+			Intel Xeon E5-46xx v4 family
+			Intel Xeon E7-48xx v4 family
+			Intel Xeon E7-88xx v4 family
+		* Intel Xeon Scalable server processors
+			Intel Xeon Bronze family
+			Intel Xeon Silver family
+			Intel Xeon Gold family
+			Intel Xeon Platinum family
+	Addresses scanned: PECI client address 0x30 - 0x37
+	Datasheet: Available from http://www.intel.com/design/literature.htm
+
+Author:
+	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+
+Description
+-----------
+
+This driver implements a generic PECI hwmon feature which provides Digital
+Thermal Sensor (DTS) thermal readings of the CPU package and CPU cores that are
+accessible using the PECI Client Command Suite via the processor PECI client.
+
+All temperature values are given in millidegree Celsius and will be measurable
+only when the target CPU is powered on.
+
+sysfs attributes
+----------------
+
+temp1_label		"Die"
+temp1_input		Provides current die temperature of the CPU package.
+temp1_max		Provides thermal control temperature of the CPU package
+			which is also known as Tcontrol.
+temp1_crit		Provides shutdown temperature of the CPU package which
+			is also known as the maximum processor junction
+			temperature, Tjmax or Tprochot.
+temp1_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of
+			the CPU package.
+
+temp2_label		"DTS margin"
+temp2_input		Provides current DTS thermal margin to Tcontrol of the
+			CPU package. Value 0 means it reaches to Tcontrol
+			temperature. Sub-zero value means the die temperature
+			goes across Tconrtol to Tjmax.
+temp2_min		Provides the minimum DTS thermal margin to Tcontrol of
+			the CPU package.
+temp2_lcrit		Provides the value when the CPU package temperature
+			reaches to Tjmax.
+
+temp3_label		"Tcontrol"
+temp3_input		Provides current Tcontrol temperature of the CPU
+			package which is also known as Fan Temperature target.
+			Indicates the relative value from thermal monitor trip
+			temperature at which fans should be engaged.
+temp3_crit		Provides Tcontrol critical value of the CPU package
+			which is same to Tjmax.
+
+temp4_label		"Tthrottle"
+temp4_input		Provides current Tthrottle temperature of the CPU
+			package. Used for throttling temperature. If this value
+			is allowed and lower than Tjmax - the throttle will
+			occur and reported at lower than Tjmax.
+
+temp5_label		"Tjmax"
+temp5_input		Provides the maximum junction temperature, Tjmax of the
+			CPU package.
+
+temp[6-*]_label		Provides string "Core X", where X is resolved core
+			number.
+temp[6-*]_input		Provides current temperature of each core.
+temp[6-*]_max		Provides thermal control temperature of the core.
+temp[6-*]_crit		Provides shutdown temperature of the core.
+temp[6-*]_crit_hyst	Provides the hysteresis value from Tcontrol to Tjmax of
+			the core.
diff --git a/Documentation/hwmon/peci-dimmtemp b/Documentation/hwmon/peci-dimmtemp
new file mode 100644
index 000000000000..c54f2526188c
--- /dev/null
+++ b/Documentation/hwmon/peci-dimmtemp
@@ -0,0 +1,50 @@
+Kernel driver peci-dimmtemp
+===========================
+
+Supported chips:
+	One of Intel server CPUs listed below which is connected to a PECI bus.
+		* Intel Xeon E5/E7 v3 server processors
+			Intel Xeon E5-14xx v3 family
+			Intel Xeon E5-24xx v3 family
+			Intel Xeon E5-16xx v3 family
+			Intel Xeon E5-26xx v3 family
+			Intel Xeon E5-46xx v3 family
+			Intel Xeon E7-48xx v3 family
+			Intel Xeon E7-88xx v3 family
+		* Intel Xeon E5/E7 v4 server processors
+			Intel Xeon E5-16xx v4 family
+			Intel Xeon E5-26xx v4 family
+			Intel Xeon E5-46xx v4 family
+			Intel Xeon E7-48xx v4 family
+			Intel Xeon E7-88xx v4 family
+		* Intel Xeon Scalable server processors
+			Intel Xeon Bronze family
+			Intel Xeon Silver family
+			Intel Xeon Gold family
+			Intel Xeon Platinum family
+	Addresses scanned: PECI client address 0x30 - 0x37
+	Datasheet: Available from http://www.intel.com/design/literature.htm
+
+Author:
+	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+
+Description
+-----------
+
+This driver implements a generic PECI hwmon feature which provides Digital
+Thermal Sensor (DTS) thermal readings of DIMM components that are accessible
+using the PECI Client Command Suite via the processor PECI client.
+
+All temperature values are given in millidegree Celsius and will be measurable
+only when the target CPU is powered on.
+
+sysfs attributes
+----------------
+
+temp[N]_label		Provides string "DIMM CI", where C is DIMM channel and
+			I is DIMM index of the populated DIMM.
+temp[N]_input		Provides current temperature of the populated DIMM.
+
+Note:
+	DIMM temperature attributes will appear when the client CPU's BIOS
+	completes memory training and testing.
-- 
2.16.2
