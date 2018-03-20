Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELui435ADUR8hIcKMVLDlPA3oQyUuOwMC764fA8aTiS4b8PuSeA/xsVNVmgt/o89lImpb3eR
ARC-Seal: i=1; a=rsa-sha256; t=1521556426; cv=none;
        d=google.com; s=arc-20160816;
        b=nMtG0x/JvklbeT23OyGIYFHTRKTaQMH2lhrsbkYOatlRz+yaHpWYboI19tAmGbTC2z
         cUkT5lNwaIQyCshXWEKeQQ+bX6rp8i8u3LmYKYcVV1VOl2Mp/j5l7OKX8CgXYMGMSZrT
         bHS9J615PYjVUOmPVodzYSZbn0j38Uys29fBkgkiCHi2yFcN4IfT8uBOIwLnSK+nUgLY
         kVcWDHM1Cy3rLUFGLyZQbfXhg1LI1n+dNjHn7vFPbAhqmoCgIdU9U7yhTY66TXPRV28h
         PEFzGjI2tP/nYvUl3VwC003YBEAqDJKhH2sQSX2YJAYK1Dc7sItxK8xZ76W0vDy6rum7
         nUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:cc:to:subject:date:from:references:in-reply-to
         :message-id:arc-authentication-results;
        bh=KCKnqx2oksFLJx8kmLsUBLd24uOD1lu24FkmCt6YJEk=;
        b=ZwtGPx73MRaoD8E/LS8bSI0/ztYrdpdmCO04QSoxsBeTzl8CTFNwOLigys6dbp21yt
         kmJvVZgICrF6gFmiQ5AGNIfX7KjoIWKSKyBGyrux0axgDqlHjjLrypXkERwv+/wzRK+I
         hyioNZmq2yryMQywdoH7oNiUP+EAK0yzS2i9h6tt6OscKefiBtAoEnnMXJVA7jBDZItn
         UWWZNe8IsBw3Q9dGsG9tk7+Q4LSw79hy1KNox1kAp44KeKsvAyuJ8ljAEqmRexpUtZxX
         4HPMmiZIvQ3TJHNx32Av77fsESSRWGEV30/8LlaWp78Y3sRoEFN0h8N0JjECUAA1nO81
         pEpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.231.152 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.231.152 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleJIrShJLcpLzFFi42KJ27nUWPeU9MY
  og5kPBS2aF69ns3hzfDqTRdfqnSwW1471Mllc3jWHzeJz7xFGi0XLWpktniw8w2RxeneJA6fH
  plWdbB7zTgZ67J+7ht1j47sdTB7v911l89j5vYHd4/MmuQD2KNbMvKT8igTWjOXLVrIXdBhVH
  Jm7m7WB8bhWFyMXh5DAekaJ5c27mLoYOYGcColrTduZuxg5OHgFMiXWLk0FCXMKuEu8+fmDHa
  LETeLArCNsIDabgIXE5BMPwGwWAVWJd49vg9UICwRL/O9vZAaZLyLwnlHi0+MPLCAJZoE6id7
  fb8FsXgFBiZMzn0DFJSQOvnjBDLHAQOL0gkawuISAvcT091fB7pEQ0JdoPBYLETaU+D7rG1SJ
  ucTCVSuZJjAKzkIydRaSqQsYmVYxqhenFpWlFuka6iUVZaZnlOQmZuboGhqY6uWmFhcnpqfmJ
  CYV6yXn525iBEZIPQMD4w7Gpl7nQ4ySHExKorydvzZECfEl5adUZiQWZ8QXleakFh9ilOHgUJ
  LgPSW1MUpIsCg1PbUiLTMHGKswaQkOHiUR3mKQNG9xQWJucWY6ROoUoy7HjRev25iFWPLy81K
  lxHl5gJEvJABSlFGaBzcCljYuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmvQWyiiczrwRu
  0yugI5iAjsieuQHkiJJEhJRUA2Nyj8pJhzfhH/v85HY4/PmwxPLVodp1ZkU3/2+YrcKj5Wwi9
  WLOxAypyjtuiTzbrj6c3OfwtmAh84VDxyYpSCe9My5ZuTxp+Z2zumcPPX/Z7p27LvPGN6VS7z
  d5M3rbbu7pn178OzdF2O1dYi7rqw0ygb90FT5Kb5Q0rjmkESm4ctdhGwGNJ2uUWIozEg21mIu
  KEwGSaryKFgMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-10.tower-179.messagelabs.com!1521556424!99990328!2
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <3774272cd49908e88b56a1c4bbf3b363b851ebdd.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 20 Mar 2018 14:33:45 +0000
Subject: [PATCH v5 3/5] power: supply: Add 'usb_type' property and supporting
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
X-KSE-Antivirus-Info: Clean, bases: 20/03/2018 12:34:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595467552152043580?=
X-GMAIL-MSGID: =?utf-8?q?1595467552152043580?=
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
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 Documentation/ABI/testing/sysfs-class-power | 12 +++++++
 drivers/power/supply/power_supply_sysfs.c   | 50 +++++++++++++++++++++++++++++
 include/linux/power_supply.h                | 16 +++++++++
 3 files changed, 78 insertions(+)

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
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5204f11..b68def4 100644
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
@@ -73,6 +78,46 @@
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
+	if ((!usb_types) || (num_usb_types <= 0)) {
+		dev_warn(dev, "driver has no valid connected types\n");
+		return -ENODATA;
+	}
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
@@ -115,6 +160,10 @@ static ssize_t power_supply_show_property(struct device *dev,
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
@@ -241,6 +290,7 @@ static ssize_t power_supply_store_property(struct device *dev,
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
