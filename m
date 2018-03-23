Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELuTnI7PMfS2VazvDiyM/CEE54N7yLmvDHkWGFH3wbA8hl7NEGskTtYQAOOGT2KcWHhaCp5h
ARC-Seal: i=1; a=rsa-sha256; t=1521799941; cv=none;
        d=google.com; s=arc-20160816;
        b=ST1lTsNF4a2QZ/Om/7QINT3vekPOosbvJ11Q1duVCNMrtOJ6IVuK++Wyotx6zwx7cc
         QXLDl/hC5rUhMU9v2VyqM1TEkUSnejnNzJ3V7jOFzMMSdAr0Ww3bQ9FQiW4W5glRqKy2
         5e7bIcYyaFK7dGmKUrhRH1Go7Yfg0sjviEv3f4z2mX9IYIB9wTN4AmYkA7qRdi7rHHag
         Nxo+i/lvHTHEx/FVzFUApBWu/vIqPhxOYAHYiaV76I5pEptBhine1m+HQwJyPP6Yc3Ax
         R/rF63BIp/9NsBWn/uYaibOtQm0zEywHQ+HXwErbU3ox3nCl6csP5TMqrPAG0pxaDNC8
         qRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:cc:to:subject:date:from:message-id
         :arc-authentication-results;
        bh=TjijfiyF3jaJTj4N9c/crpTf1PRv0UXLuTT8DwojBvI=;
        b=SpkpePIAqHdD4HHOl7vQ0FJfsnD/laRRI8D15/U0mY/O1NZtCYCMBcHF/d6YTlmF73
         +UoQgYPQe6jIgKuslKarhxlLGMXldwjAHM70+1TO32V89VZrP2RYGP0++5fdlmAfMdZ3
         8maJu5O3KwQApwZ/uy1pfG6mRTG2bgScgjrXf65Y6pOo/3y4PxneEqiLxLr3lXM8OLUN
         dzbseGOxMIycI0w8OjisuYxQrMjWpInAOSc8YRyDtO/hyj4PhQfgg/Cu1OBpzTpSdZsg
         0jfolxrjmwEm+JgWciZXlYPeX8rwbFGua3tcq+9x7Je8S/JqPAxdkZbo1NkAce+v1JPq
         IO+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.112 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.112 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRWlGSWpSXmKPExsUSt3OpsS7L5S1
  RBuvmqVg0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGbPPPGYvmKxW8
  a3jE3sD4z65LkYuDiGB9YwSvzZPYO9i5ARyKiQevb7OBmLzCrhJzP9/EMxmE7CQmHziAZjNIq
  AqcfDyF0YQW1jASeL8nPtMIINEBN4zSnx6/IEFJMEsUCfR+/stC8QgQYmTM59AxSUkDr54wQy
  xzEDi9IJGsLiEgL3E9PdXgeIcQLa+ROOxWIiwocT3Wd+gSswlZp3dwTaBkX8WkqmzkExdwMi0
  itEyqSgzPaMkNzEzR9fQwEDX0NBY11TX0NJcL7FKN0kvtVQ3OTWvpCgRKKuXWF6sV1yZm5yTo
  peXWrKJERgXDECwg3HTl8RDjJIcTEqivJnHt0QJ8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuDluQ
  SUEyxKTU+tSMvMAUYoTFqCg0dJhFcLJM1bXJCYW5yZDpE6xajLcePF6zZmIZa8/LxUKXFefpA
  iAZCijNI8uBGwZHGJUVZKmJcR6CghnoLUotzMElT5V4ziHIxKwrzfLgJN4cnMK4Hb9AroCCag
  I3ymgB1RkoiQkmpg3B/45MHzI0/N+epi6hY6Vl1QD3OJP3BiQoctR2rA0qP//CXc29STeVIyl
  CREFJfVNqVLixQvCl00c6bHw9z1vzjUmL4xyTp+2v59RlX2AuWjTLtrdzVaTFh59VKT0ra5P4
  q+JF4T90uf/P9/j8oWu02My/efamH8u6WoQPNWC+N6oVDFCTM0lViKMxINtZiLihMBnPV5axE
  DAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-26.tower-239.messagelabs.com!1521799940!577028!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 23 Mar 2018 10:12:19 +0000
Subject: [PATCH v7 0/6] typec: tcpm: Add sink side support for PPS
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
X-GMAIL-THRID: =?utf-8?q?1595722895403408333?=
X-GMAIL-MSGID: =?utf-8?q?1595722895403408333?=
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

Changes in v7:
 - Further tidy up with bracket usage and unwanted initialisation.
 - Stop using else if statement after break.
 - Added NULL checking of psy_name after devm_kzalloc().
 - Reinstate PD_ROLE_SWAP_TIMEOUT and revert role swap functions to use this.
 - Add PD_PPS_CTRL_TIMEOUT for PPS related control functions.

Changes in v6:
 - Remove unnecessary use of 'data' variable and associated kzalloc/kfree call
   for extended message handling.
 - Add patch for error checking psy_desc struct in psy register code.
 - Add error checking of usb_type property in psy register code.
 - Cosmetic () and initialisation changes as requested by Guenter.
 - Removed Acked-by and Reviewed-by, from Heikki and Sebastian respectively, on
   patch 04 as there have been changes to error handling with regards to
   usb_type, so didn't feel appropriate to keep them.

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

Adam Thomson (6):
  typec: tcpm: Add core support for sink side PPS
  Documentation: power: Initial effort to document power_supply ABI
  power: supply: Add error checking of psy desc during registration
  power: supply: Add 'usb_type' property and supporting code
  typec: tcpm: Represent source supply through power_supply
  typec: tcpm: Add support for sink PPS related messages

 Documentation/ABI/testing/sysfs-class-power | 455 ++++++++++++++
 MAINTAINERS                                 |   1 +
 drivers/power/supply/power_supply_core.c    |  11 +-
 drivers/power/supply/power_supply_sysfs.c   |  45 ++
 drivers/usb/typec/Kconfig                   |   1 +
 drivers/usb/typec/fusb302/Kconfig           |   2 +-
 drivers/usb/typec/fusb302/fusb302.c         |  63 +-
 drivers/usb/typec/tcpm.c                    | 903 +++++++++++++++++++++++++++-
 include/linux/power_supply.h                |  16 +
 include/linux/usb/pd.h                      |   4 +-
 include/linux/usb/tcpm.h                    |   1 +
 11 files changed, 1417 insertions(+), 85 deletions(-)

-- 
1.9.1
