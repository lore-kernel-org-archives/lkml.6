Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELuqInGtFIi7LPiNxXrT3n/OxAlgZFoWW9F9E213SIkhQ8AGCzChyltiFvuHvTVEhLuPscbb
ARC-Seal: i=1; a=rsa-sha256; t=1521799946; cv=none;
        d=google.com; s=arc-20160816;
        b=grbvv+XXLkbuI0f1Ol8RSC57hCMWpmbvFwmyCK3Muvc2NWWC2iair1kO/LDfbhgB+v
         3Zk8EIBBmffD/47SN/T/APj22pnPbyq77ngpiUcfLOTmHkUF+ax5lUAU8ZmhdhUc8m2t
         e4yPHmc8+jJo2LuefcDbK2Jeun/E96c3ua5OLZvUIz9cvUSi/aM/hl7+fJqBYXZnqNCg
         jziJ9+iAq7fA82cE0cdkl4LHvdMnK/Dt10WgfQIRze/jT2ryTwFigGjtGVkD0kuru03F
         eDg7dnKEzn+9isEoM6x8qSpweBGEN9GCq/YyMeasdPSqS7PHOoWPsF7v5vhRJxsdM08s
         POng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:cc:to:subject:date:from:references:in-reply-to
         :message-id:arc-authentication-results;
        bh=UvxaEU3j2wL2Kz4OMtiy/kLvPdh78QaTsZyS/o/QCiE=;
        b=nabLhCCMxIcLfprk7SSuK77lgqMEXJpJ2vMfV6E8LKI3mz0wyk9xpBrlmp0PMToonA
         wyaMEleqp8068oUU2dhMcollZQwInBeaBMr+sIL8WIu/irIeX8Io/6ULpd7prcMekcjB
         J7nX+Yc2o7MgHD/m+Yr3/W5a7G5/1xYQJ2FeNPwocEECervSRqiGWdKzH6rxQLTmVHCH
         bjJH7+o3MMp7Sb15OmNRXr9VifpsAZwju0XmkHs5iUgS/o9hvAd00BSFnoEo5ZaLA79E
         sTa+VE23XEPh+aKtgZGj3si9PGTndSlPJbDF2P3ytQn3ZGjVuSG2ZX/xCqPIm/FFI7HZ
         wQGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.231.147 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.231.147 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleJIrShJLcpLzFFi42KJ27nUWJfz8pY
  og7WTFC2aF69ns3hzfDqTRdfqnSwW1471Mllc3jWHzeJz7xFGi0XLWpktniw8w2RxeneJA6fH
  plWdbB7zTgZ67J+7ht1j47sdTB7v911l89j5vYHd4/MmuQD2KNbMvKT8igTWjJcvt7IXPDavm
  DR7BXMD41b9LkYuDiGB9YwSfycdYepi5ARyKiRWPV3A1sXIwcErkCnx5KoSSJhTwF3i3stOJp
  CwkICbxJ5PzCBhNgELicknHrCB2CwCqhLTJ65nBbGFBYIldr1rYQMZLyLwnlHi0+MPLCAJZoE
  6id7fb8FsXgFBiZMzn0DFJSQOvnjBDHGCgcTpBY1gcQkBe4np768yg+yVENCXaDwWCxE2lPg+
  6xtUibnErLM72CYwCs5CMnUWkqkLGJlWMWoUpxaVpRbpGlnoJRVlpmeU5CZm5ugaGpjq5aYWF
  yemp+YkJhXrJefnbmIERkg9AwPjDsa+VX6HGCU5mJREeTOPb4kS4kvKT6nMSCzOiC8qzUktPs
  Qow8GhJMF77SJQTrAoNT21Ii0zBxirMGkJDh4lEd73IGne4oLE3OLMdIjUKUZdjhsvXrcxC7H
  k5eelSonzrgApEgApyijNgxsBSxuXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzNoBM4cnM
  K4Hb9AroCCagI3ymgB1RkoiQkmpgVFmf9+FOxNsqQc0nnrvcLru1d0R63b8YmLT80eGX3qEvF
  kR1Pn1rfaaNZar5xmtT+Nwncs+Z+ynw9Kf0uK6afFXXG6p7d5g0cfivi5w144zzmkfH+HwnrJ
  H9dz+o5MbJnz2RwUz50nusFqQ2+cVu2q9TtFcpSuVdnnGz+vGa4yqNUxuuyXu+UGIpzkg01GI
  uKk4EAGrXP6QWAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-16.tower-178.messagelabs.com!1521799945!113435845!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <c7704e7434bdf8567137ec239d33dbf4a34b2ff0.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 23 Mar 2018 10:12:24 +0000
Subject: [PATCH v7 4/6] power: supply: Add 'usb_type' property and supporting
 code
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
X-GMAIL-THRID: =?utf-8?q?1595722900301621749?=
X-GMAIL-MSGID: =?utf-8?q?1595722900301621749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds the 'usb_type' property to represent USB supplies
which can report a number of different types based on a connection
event.

Examples of this already exist in drivers whereby the existing 'type'
property is updated, based on an event, to represent what was
connected (e.g. USB, USB_DCP, USB_ACA, ...). Current implementations
however don't show all supported connectable types, so this knowledge
has to be exlicitly known for each driver that supports this.

The 'usb_type' property is intended to fill this void and show users
all possible USB types supported by a driver. The property, when read,
shows all available types for the driver, and the one currently chosen
is highlighted/bracketed. It is expected that the 'type' property
would then just show the top-level type 'USB', and this would be
static.

Currently the 'usb_type' enum contains all of the USB variant types
that exist for the 'type' enum at this time, and in addition has
SDP and PPS types. The mirroring is intentional so as to not impact
existing usage of the 'type' property.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 12 ++++++++
 drivers/power/supply/power_supply_core.c    |  8 ++++-
 drivers/power/supply/power_supply_sysfs.c   | 45 +++++++++++++++++++++++++++++
 include/linux/power_supply.h                | 16 ++++++++++
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index e046566..5e23e22 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -409,6 +409,18 @@ Description:
 		Access: Read
 		Valid values: Represented in 1/10 Degrees Celsius
 
+What: 		/sys/class/power_supply/<supply_name>/usb_type
+Date:		March 2018
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports what type of USB connection is currently active for
+		the supply, for example it can show if USB-PD capable source
+		is attached.
+
+		Access: Read-Only
+		Valid values: "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
+			      "PD_DRP", "PD_PPS", "BrickID"
+
 What: 		/sys/class/power_supply/<supply_name>/voltage_max
 Date:		January 2008
 Contact:	linux-pm@vger.kernel.org
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 64f6449..dff2bbb 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -843,7 +843,7 @@ static void psy_unregister_cooler(struct power_supply *psy)
 {
 	struct device *dev;
 	struct power_supply *psy;
-	int rc;
+	int i, rc;
 
 	if (!parent)
 		pr_warn("%s: Expected proper parent device for '%s'\n",
@@ -852,6 +852,12 @@ static void psy_unregister_cooler(struct power_supply *psy)
 	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
 		return ERR_PTR(-EINVAL);
 
+	for (i = 0; i < desc->num_properties; ++i) {
+		if ((desc->properties[i] == POWER_SUPPLY_PROP_USB_TYPE) &&
+		    (!desc->usb_types || !desc->num_usb_types))
+			return ERR_PTR(-EINVAL);
+	}
+
 	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
 	if (!psy)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5204f11..1350068 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -46,6 +46,11 @@
 	"USB_PD", "USB_PD_DRP", "BrickID"
 };
 
+static const char * const power_supply_usb_type_text[] = {
+	"Unknown", "SDP", "DCP", "CDP", "ACA", "C",
+	"PD", "PD_DRP", "PD_PPS", "BrickID"
+};
+
 static const char * const power_supply_status_text[] = {
 	"Unknown", "Charging", "Discharging", "Not charging", "Full"
 };
@@ -73,6 +78,41 @@
 	"Unknown", "System", "Device"
 };
 
+static ssize_t power_supply_show_usb_type(struct device *dev,
+					  enum power_supply_usb_type *usb_types,
+					  ssize_t num_usb_types,
+					  union power_supply_propval *value,
+					  char *buf)
+{
+	enum power_supply_usb_type usb_type;
+	ssize_t count = 0;
+	bool match = false;
+	int i;
+
+	for (i = 0; i < num_usb_types; ++i) {
+		usb_type = usb_types[i];
+
+		if (value->intval == usb_type) {
+			count += sprintf(buf + count, "[%s] ",
+					 power_supply_usb_type_text[usb_type]);
+			match = true;
+		} else {
+			count += sprintf(buf + count, "%s ",
+					 power_supply_usb_type_text[usb_type]);
+		}
+	}
+
+	if (!match) {
+		dev_warn(dev, "driver reporting unsupported connected type\n");
+		return -EINVAL;
+	}
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+
 static ssize_t power_supply_show_property(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf) {
@@ -115,6 +155,10 @@ static ssize_t power_supply_show_property(struct device *dev,
 	else if (off == POWER_SUPPLY_PROP_TYPE)
 		return sprintf(buf, "%s\n",
 			       power_supply_type_text[value.intval]);
+	else if (off == POWER_SUPPLY_PROP_USB_TYPE)
+		return power_supply_show_usb_type(dev, psy->desc->usb_types,
+						  psy->desc->num_usb_types,
+						  &value, buf);
 	else if (off == POWER_SUPPLY_PROP_SCOPE)
 		return sprintf(buf, "%s\n",
 			       power_supply_scope_text[value.intval]);
@@ -241,6 +285,7 @@ static ssize_t power_supply_store_property(struct device *dev,
 	POWER_SUPPLY_ATTR(time_to_full_now),
 	POWER_SUPPLY_ATTR(time_to_full_avg),
 	POWER_SUPPLY_ATTR(type),
+	POWER_SUPPLY_ATTR(usb_type),
 	POWER_SUPPLY_ATTR(scope),
 	POWER_SUPPLY_ATTR(precharge_current),
 	POWER_SUPPLY_ATTR(charge_term_current),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 79e90b3..4ca8876 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -145,6 +145,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_TYPE, /* use power_supply.type instead */
+	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
@@ -170,6 +171,19 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 };
 
+enum power_supply_usb_type {
+	POWER_SUPPLY_USB_TYPE_UNKNOWN = 0,
+	POWER_SUPPLY_USB_TYPE_SDP,		/* Standard Downstream Port */
+	POWER_SUPPLY_USB_TYPE_DCP,		/* Dedicated Charging Port */
+	POWER_SUPPLY_USB_TYPE_CDP,		/* Charging Downstream Port */
+	POWER_SUPPLY_USB_TYPE_ACA,		/* Accessory Charger Adapters */
+	POWER_SUPPLY_USB_TYPE_C,		/* Type C Port */
+	POWER_SUPPLY_USB_TYPE_PD,		/* Power Delivery Port */
+	POWER_SUPPLY_USB_TYPE_PD_DRP,		/* PD Dual Role Port */
+	POWER_SUPPLY_USB_TYPE_PD_PPS,		/* PD Programmable Power Supply */
+	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
+};
+
 enum power_supply_notifier_events {
 	PSY_EVENT_PROP_CHANGED,
 };
@@ -196,6 +210,8 @@ struct power_supply_config {
 struct power_supply_desc {
 	const char *name;
 	enum power_supply_type type;
+	enum power_supply_usb_type *usb_types;
+	size_t num_usb_types;
 	enum power_supply_property *properties;
 	size_t num_properties;
 
-- 
1.9.1
