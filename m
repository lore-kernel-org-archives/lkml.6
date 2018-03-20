Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELt/MlRsNhxCB52BtVF502nE0urVtlaNDGXbXaK1qYvs8KhsT64RoRQBBwFHg3cI8XvtCxEL
ARC-Seal: i=1; a=rsa-sha256; t=1521556424; cv=none;
        d=google.com; s=arc-20160816;
        b=DYGTk37O7h3yMd8HFT5lngft6HbTGxKxHpJGmxwj5wzH6+1DWxefZ7HFakjIxGnI7O
         R2s+1fltttjGDF9DYKR9wm5IdyxuieOuyDypT3WI3ySq/V0eLXCul/ESm0dyrSsVigKt
         9alhZMr5LancWQXUbDB+fyZjp1WE5wRM4pLhX4idficfX9OSrDGBvGhmg1rjeAZHLcm6
         OfydbOUsszy8oXW8ItYiGUPANeB+E03Zb/K9KbCwHewHZj9j2H7klipsa0+oG6A1B8XI
         +8I5O+eK6o/GI/mD3BY+YCNwA+Ipa8LE3SB1Zsj/luGoUDep0OhsWQHMPdfdU0+/1VO8
         1Rlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:cc:to:subject:date:from:message-id
         :arc-authentication-results;
        bh=eA71wl5MV3eLZRfipbBSC65DlYnaLvoCVG8LSGNvZ8E=;
        b=hRcWVlbLzY7/ASQxasyc2F3PuOGvvGu9CDhjA7kYV8ev+qGMpd3nhUf5fuTpfSFgAJ
         PpT0FP7B1MtDlS9Or2nu0VwMPrTsHevhoNbHyZ6uKZcfJGd0evCoIqvJS9W70N3Pl7fk
         80Jwt3bR7YQB7gVPbldEJGi8VqvYfTY3TM/QizznfHjvnleUCh6fowJZp64KcCVYp7Pd
         9It9y642vuTUHnQwaqjPCcxCgksTu+Qki5v/8bu7SdgOQZho5T37T0sJPU901nsaLg5n
         f2NHLFeC7Z9VHGR0ZXPqZyNNmydYqtNXB/y5AMtCAAaTTR6zESwyRIIZFE/0gCjtI6Ds
         /Sww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.231.144 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 195.245.231.144 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRWlGSWpSXmKPExsUSt3Opse5x6Y1
  RBgdXM1o0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGdebjzMV7Jare
  DJ/L1sD42SJLkYuDiGB9YwSC9+tZuxi5ARyKiT+3nnACmLzCrhJ/N6+gh3EZhOwkJh84gEbiM
  0ioCrRsXUrUJyDQ1jASeLOdTGQOSIC7xklPj3+wAJSwyxQJ9H7+y0LxBxBiZMzn0DFJSQOvnj
  BDLHLQOL0gkawuISAvcT091eZQWZKCOhLNB6LhQgbSnyf9Q2qxFxi4aqVTBMY+WchmToLydQF
  jEyrGNWLU4vKUot0TfWSijLTM0pyEzNzdA0NTPVyU4uLE9NTcxKTivWS83M3MQIDngEIdjB+6
  Xc+xCjJwaQkytv5a0OUEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQneU1Ibo4QEi1LTUyvSMnOAsQ
  eTluDgURLhtQRJ8xYXJOYWZ6ZDpE4x6nLcePG6jVmIJS8/L1VKnPcSSJEASFFGaR7cCFgauMQ
  oKyXMywh0lBBPQWpRbmYJqvwrRnEORiVh3nkgU3gy80rgNr0COoIJ6IjsmRtAjihJREhJNTCu
  e3R2fo7uI4kPtRoGD7JSeF9alt/U4eH2+n/9SAKrScyR6jWSm3bUeNYv/7Zo4ncVJe/rD0UWR
  i7dxycatPAQM9OGWG7eub5nTstfL7++yz2eaSJbZUjAh+BikUf13LPV5l0MMOLhYDE6PdP73p
  +r155UVDd8eDuh76Dg9OsTQ1VeXT69xFJfiaU4I9FQi7moOBEAEH9/Qf4CAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-2.tower-180.messagelabs.com!1521556422!107047431!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 20 Mar 2018 14:33:42 +0000
Subject: [PATCH v5 0/5] typec: tcpm: Add sink side support for PPS
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
X-GMAIL-THRID: =?utf-8?q?1595467548600805831?=
X-GMAIL-MSGID: =?utf-8?q?1595467548600805831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set adds sink side support for the PPS feature introduced in the
USB PD 3.0 specification.

The source PPS supply is represented using the Power Supply framework to provide
access and control APIs for dealing with it's operating voltage and current,
and switching between a standard PDO and PPS APDO operation. During standard PDO
operation the voltage and current is read-only, but for APDO PPS these are
writable as well to allow for control.

It should be noted that the keepalive for PPS is not handled within TCPM. The
expectation is that the external user will be required to ensure re-requests
occur regularly to ensure PPS remains and the source does not hard reset.

Changes in v5:
 - Rebase on branch with 'Revert "typec: tcpm: Only request matching pdos"' and
   header changes already included.
 - Update power_supply registration to make power_supply names unique per port,
   to avoid errors creating duplicate psy instances. New name uses port
   dev name as a suffix.
 - Renamed 'connected_type' psy property to 'usb_type', as requested by
   maintainer.
 - Added initial attempt at generic ABI documentation for common psy class
   properties for Battery and USB type supplies.
 - Small update to PPS APDO selection code to limit maximum current requested
   based on sink maximum allowed current. Have left Heikki's 'Acked-by' tag as
   it's a minor change, but can remove if that's not deemed appropriate.

Changes in v4:
 - For PD 3.0 definitions patch, make it benign with regards to existing TCPM
   code so build isn't broken if this one patch is applied, as suggested by
   kbuild robot. Update for dynamic revision is moved to be part of sink side
   PPS support patch.
 - Use PTR_ERR_OR_ZERO macro to simplify return of devm_tcpm_psy_register()
   function, as suggested by kbuild robot.
 - Make devm_tcpm_psy_register() static as not used outside this file.

Changes in v3:
 - Drop 'RFC' from patch series titles
 - Rename PPS related defines to be PPS specific rather than generic APDO titles
 - Update source caps logging to only print PPS APDOs, and for others report as
   undefined.
 - Add ABI documentation for tcpm-source-psy sysfs properties
 - Rebase PDO selection on top of 'typec: tcpm: Only request matching pdos'
   patch.
 - Update capabilities validation introduced in
   'typec: tcpm: Validate source and sink caps' to support PPS APDOs.
 - Dropped power_supply 'type' property update for PPS addition
 - Added 'connected_type' property to power_supply framework, to support
   supplies which can report multiple connected types (e.g. USB), as discussed
   with Heikki.

Changes in v2:
 - Use USB_PD and usb_pd prefixes for macros and inline functions in headers.
 - Negotiate spec revision of PD headers during initial contract agreement.
 - New headers now use SPDX tags for referencing correct license.

NOTE: Code changes based on usb-next (027bd6cafd9a1e3a109b5e5682c85ac84e804a8d)

Adam Thomson (5):
  typec: tcpm: Add core support for sink side PPS
  Documentation: power: Initial effort to document power_supply ABI
  power: supply: Add 'usb_type' property and supporting code
  typec: tcpm: Represent source supply through power_supply
  typec: tcpm: Add support for sink PPS related messages

 Documentation/ABI/testing/sysfs-class-power | 455 ++++++++++++++
 MAINTAINERS                                 |   1 +
 drivers/power/supply/power_supply_sysfs.c   |  50 ++
 drivers/usb/typec/Kconfig                   |   1 +
 drivers/usb/typec/fusb302/Kconfig           |   2 +-
 drivers/usb/typec/fusb302/fusb302.c         |  63 +-
 drivers/usb/typec/tcpm.c                    | 916 +++++++++++++++++++++++++++-
 include/linux/power_supply.h                |  16 +
 include/linux/usb/pd.h                      |   4 +-
 include/linux/usb/tcpm.h                    |   2 +-
 10 files changed, 1422 insertions(+), 88 deletions(-)

-- 
1.9.1
