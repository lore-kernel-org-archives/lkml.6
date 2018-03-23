Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELsUGZgXUzq8MhfkBy+5bqCFIU0G56iTg5oNKB4p+O8hzlNvLHa5vNd69Z8Idtvo5+CfISzd
ARC-Seal: i=1; a=rsa-sha256; t=1521799944; cv=none;
        d=google.com; s=arc-20160816;
        b=gdazs0rnNukCP/CGPyhuEgoMTq7Yer+F6LdW9wmhAq5InA1x7odRa7tj42QzhT0QSm
         CpslR3cff3lTbg38Zb5Yg6Q3Ic4MCvfGI15FCAk0DhFidnY9N5MJntGB63sbFX44d2p4
         X4SfXTn9yL0+00suG9qHsas9mqHsie7uF/nFCs1g3LrMVvYgg6lU1TpH0YcSeLPQUxdW
         jG4a7vWeLhePUF7Mb7+TMoUQDbIw5ekXgqIt+xdqkxCZiqHaiq4ZM1t34Ah3Ey5D2/vY
         SovTuI/kSGqwzPig5AFDfwiKOES3M5vVn+w2j8e78qi9bCwyxI6ViaVxpGO2ocdD0avT
         hm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:cc:to:subject:date:from:references:in-reply-to
         :message-id:arc-authentication-results;
        bh=tG09lClptmkq1r46ZjfEvaP1UVhoySqs8Vk9mknnCsw=;
        b=pGVSZAyKEaF2iGSpyZpIlvTbvqm65qMjgtBpaOGFaeoGaMDTChi5FdaX3wzq0HPZar
         QbO4fTEk+dFaTGXvt8NFxP8vv5qcQLXq8AhooSTO28x9OoRZF1JXsNr9oWcsKuK3QWh+
         Wu3mwI37AF7Wr9tN+zjcZjtoasLwHPDQogm+O74U7kGipP0ZV/nWDFGnDaHwmG8CD0F1
         hLMIsk6lM5gQIas8q5Kzd5zLd/JXyldmTfxL+Sxxk68llHrzyAf2WGWUMndWa3O9EtlZ
         gfeOPPfrTsMygbnhfG/nC5+vLzPXn8V7XoU1iYOCMnklB0I1V9OJgf5pkG9jQWTPnGGm
         9Xyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.2 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.2 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRWlGSWpSXmKPExsUSt3OpsS775S1
  RBvceSFk0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGc86WAr+l1dsf
  /yTvYHxcWoXIxeHkMB6Rom2Pf2sXYycQE6FRP/JV4xdjBwcvAKZEu/3G4KEOQXcJe697GQCCQ
  sJuEns+cQMEmYTsJCYfOIBG4jNIqAq0bj7OlhcWCBKYv75I4wg40UE3jNKfHr8gQUkwSxQJ9H
  7+y2YzSsgKHFy5hOouITEwRcvmCFOMJA4vaARLC4hYC8x/f1VZpC9EgL6Eo3HYiHChhLfZ32D
  KjGXmHV2B9sERsFZSKbOQjJ1ASPTKkbLpKLM9IyS3MTMHF1DAwNdQ0NjXSNdI0NjvcQq3US91
  FLd5NS8kqJEoKxeYnmxXnFlbnJOil5easkmRmAEMQDBDsbDZxMPMUpyMCmJ8mYe3xIlxJeUn1
  KZkVicEV9UmpNafIhRhoNDSYKX5xJQTrAoNT21Ii0zBxjLMGkJDh4lEV4tkDRvcUFibnFmOkT
  qFKMux40Xr9uYhVjy8vNSpcR5+UGKBECKMkrz4EbA0solRlkpYV5GoKOEeApSi3IzS1DlXzGK
  czAqCfN+uwg0hSczrwRu0yugI5iAjvCZAnZESSJCSqqB0fTLcs/Slyf1/snu6/+xwITjE8vFN
  kunPd5ZC5l0JhX+Mz56a67ALnd/2QK+zYu5OxjOu9uq8V1c8DXygvv2hL9Hf28QmCB9xubcsd
  ApgU/8/yjdEcrumuiy7aDayo0/398yyJx0Ytu6K4v83SfWL/6YECC1RMHV65XlG245a8H4Azv
  3h35vklFiKc5INNRiLipOBABM+5FfJgMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-30.tower-223.messagelabs.com!1521799943!673353!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <0a26f379c29d65b6e0fa416a4b73aea010b9f718.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 23 Mar 2018 10:12:21 +0000
Subject: [PATCH v7 2/6] Documentation: power: Initial effort to document
 power_supply ABI
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun
 Li <jun.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 23/03/2018 08:40:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595722898272542995?=
X-GMAIL-MSGID: =?utf-8?q?1595722898272542995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds generic ABI information regarding power_supply
properties. This is an initial attempt to try and align the usage
of these properties between drivers. As part of this commit,
common Battery and USB related properties have been listed.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 443 ++++++++++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 2 files changed, 444 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index f85ce9e..e046566 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -1,3 +1,446 @@
+===== General Properties =====
+
+What:		/sys/class/power_supply/<supply_name>/manufacturer
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the name of the device manufacturer.
+
+		Access: Read
+		Valid values: Represented as string
+
+What:		/sys/class/power_supply/<supply_name>/model_name
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the name of the device model.
+
+		Access: Read
+		Valid values: Represented as string
+
+What:		/sys/class/power_supply/<supply_name>/serial_number
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the serial number of the device.
+
+		Access: Read
+		Valid values: Represented as string
+
+What:		/sys/class/power_supply/<supply_name>/type
+Date:		May 2010
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Describes the main type of the supply.
+
+		Access: Read
+		Valid values: "Battery", "UPS", "Mains", "USB"
+
+===== Battery Properties =====
+
+What:		/sys/class/power_supply/<supply_name>/capacity
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Fine grain representation of battery capacity.
+		Access: Read
+		Valid values: 0 - 100 (percent)
+
+What:		/sys/class/power_supply/<supply_name>/capacity_alert_max
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum battery capacity trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery discharging scenario where user-space needs to know the
+		battery has dropped to an upper level so it can take
+		appropriate action (e.g. warning user that battery level is
+		low).
+
+		Access: Read, Write
+		Valid values: 0 - 100 (percent)
+
+What:		/sys/class/power_supply/<supply_name>/capacity_alert_min
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum battery capacity trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery discharging scenario where user-space needs to know the
+		battery has dropped to a lower level so it can take
+		appropriate action (e.g. warning user that battery level is
+		critically low).
+
+		Access: Read, Write
+		Valid values: 0 - 100 (percent)
+
+What:		/sys/class/power_supply/<supply_name>/capacity_level
+Date:		June 2009
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Coarse representation of battery capacity.
+
+		Access: Read
+		Valid values: "Unknown", "Critical", "Low", "Normal", "High",
+			      "Full"
+
+What:		/sys/class/power_supply/<supply_name>/current_avg
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an average IBAT current reading for the battery, over a
+		fixed period. Normally devices will provide a fixed interval in
+		which they average readings to smooth out the reported value.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/current_max
+Date:		October 2010
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum IBAT current allowed into the battery.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/current_now
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an instant, single IBAT current reading for the battery.
+		This value is not averaged/smoothed.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/charge_type
+Date:		July 2009
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents the type of charging currently being applied to the
+		battery.
+
+		Access: Read
+		Valid values: "Unknown", "N/A", "Trickle", "Fast"
+
+What:		/sys/class/power_supply/<supply_name>/charge_term_current
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the charging current value which is used to determine
+		when the battery is considered full and charging should end.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/health
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the health of the battery or battery side of charger
+		functionality.
+
+		Access: Read
+		Valid values: "Unknown", "Good", "Overheat", "Dead",
+			      "Over voltage", "Unspecified failure", "Cold",
+			      "Watchdog timer expire", "Safety timer expire"
+
+What:		/sys/class/power_supply/<supply_name>/precharge_current
+Date:		June 2017
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the charging current applied during pre-charging phase
+		for a battery charge cycle.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/present
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports whether a battery is present or not in the system.
+
+		Access: Read
+		Valid values:
+			0: Absent
+			1: Present
+
+What:		/sys/class/power_supply/<supply_name>/status
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents the charging status of the battery. Normally this
+		is read-only reporting although for some supplies this can be
+		used to enable/disable charging to the battery.
+
+		Access: Read, Write
+		Valid values: "Unknown", "Charging", "Discharging",
+			      "Not charging", "Full"
+
+What:		/sys/class/power_supply/<supply_name>/technology
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Describes the battery technology supported by the supply.
+
+		Access: Read
+		Valid values: "Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe",
+			      "NiCd", "LiMn"
+
+What:		/sys/class/power_supply/<supply_name>/temp
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the current TBAT battery temperature reading.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_max
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum TBAT temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery charging scenario where user-space needs to know the
+		battery temperature has crossed an upper threshold so it can
+		take appropriate action (e.g. warning user that battery level is
+		critically high, and charging has stopped).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_min
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum TBAT temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery charging scenario where user-space needs to know the
+		battery temperature has crossed a lower threshold so it can take
+		appropriate action (e.g. warning user that battery level is
+		high, and charging current has been reduced accordingly to
+		remedy the situation).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_max
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum allowed TBAT battery temperature for
+		charging.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_min
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the minimum allowed TBAT battery temperature for
+		charging.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/voltage_avg,
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an average VBAT voltage reading for the battery, over a
+		fixed period. Normally devices will provide a fixed interval in
+		which they average readings to smooth out the reported value.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/voltage_max,
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum safe VBAT voltage permitted for the battery,
+		during charging.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/voltage_min,
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the minimum safe VBAT voltage permitted for the battery,
+		during discharging.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/voltage_now,
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an instant, single VBAT voltage reading for the battery.
+		This value is not averaged/smoothed.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+===== USB Properties =====
+
+What: 		/sys/class/power_supply/<supply_name>/current_avg
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an average IBUS current reading over a fixed period.
+		Normally devices will provide a fixed interval in which they
+		average readings to smooth out the reported value.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+
+What: 		/sys/class/power_supply/<supply_name>/current_max
+Date:		October 2010
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum IBUS current the supply can support.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What: 		/sys/class/power_supply/<supply_name>/current_now
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the IBUS current supplied now. This value is generally
+		read-only reporting, unless the 'online' state of the supply
+		is set to be programmable, in which case this value can be set
+		within the reported min/max range.
+
+		Access: Read, Write
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/input_current_limit
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Details the incoming IBUS current limit currently set in the
+		supply. Normally this is configured based on the type of
+		connection made (e.g. A configured SDP should output a maximum
+		of 500mA so the input current limit is set to the same value).
+
+		Access: Read, Write
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/online,
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Indicates if VBUS is present for the supply. When the supply is
+		online, and the supply allows it, then it's possible to switch
+		between online states (e.g. Fixed -> Programmable for a PD_PPS
+		USB supply so voltage and current can be controlled).
+
+		Access: Read, Write
+		Valid values:
+			0: Offline
+			1: Online Fixed - Fixed Voltage Supply
+			2: Online Programmable - Programmable Voltage Supply
+
+What:		/sys/class/power_supply/<supply_name>/temp
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the current supply temperature reading. This would
+		normally be the internal temperature of the device itself (e.g
+		TJUNC temperature of an IC)
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_max
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum supply temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		charging scenario where user-space needs to know the supply
+		temperature has crossed an upper threshold so it can take
+		appropriate action (e.g. warning user that the supply
+		temperature is critically high, and charging has stopped to
+		remedy the situation).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_min
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum supply temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		charging scenario where user-space needs to know the supply
+		temperature has crossed a lower threshold so it can take
+		appropriate action (e.g. warning user that the supply
+		temperature is high, and charging current has been reduced
+		accordingly to remedy the situation).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_max
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum allowed supply temperature for operation.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_min
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the mainimum allowed supply temperature for operation.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What: 		/sys/class/power_supply/<supply_name>/voltage_max
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum VBUS voltage the supply can support.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What: 		/sys/class/power_supply/<supply_name>/voltage_min
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the minimum VBUS voltage the supply can support.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What: 		/sys/class/power_supply/<supply_name>/voltage_now
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the VBUS voltage supplied now. This value is generally
+		read-only reporting, unless the 'online' state of the supply
+		is set to be programmable, in which case this value can be set
+		within the reported min/max range.
+
+		Access: Read, Write
+		Valid values: Represented in microvolts
+
+===== Device Specific Properties =====
+
 What:		/sys/class/power/ds2760-battery.*/charge_now
 Date:		May 2010
 KernelVersion:	2.6.35
diff --git a/MAINTAINERS b/MAINTAINERS
index 2bee7ac..5bb0a10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11098,6 +11098,7 @@ M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-power
 F:	Documentation/devicetree/bindings/power/supply/
 F:	include/linux/power_supply.h
 F:	drivers/power/supply/
-- 
1.9.1
