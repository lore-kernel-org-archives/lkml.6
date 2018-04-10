Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx49EBZinq7CzsIrl9qvKwgDPKWUvbHxe5sSJ0z6z6ktDOZ9NcFZ7f9tLKrtEArJQByMGnHt6
ARC-Seal: i=1; a=rsa-sha256; t=1523385187; cv=none;
        d=google.com; s=arc-20160816;
        b=MgBihX3XMM/4Xwye00FR9HSouOd7cIfTZtoqNEgZ8eYZ1BTm+2ALZsVtUm9vcmTqqq
         RRAUiWwdWtxM2NbG1seKrkX2b6h4Vzv1LMQiEJsbFeUhwvyK3Fo5CGOQvoV0FpOxCvQO
         t1J9zK6EeWCyO1J3kjDeuf6AZdEWESsDbELtHP3c8LhhMIBixM0pLXkdI6c1Es71i9cE
         NdmgehqNsLAW1kgWPHYR1wyeHs5idKPvouaFF5U0LrS7hSs3uZ/hzYHCgjuqNFdFjQRl
         uDGtQVkFlrLWp8VZ2xS8lcJVxRRnO4mMEV1aojEcgWzBJEKS9PLxysuHvxXjnpeSQrwe
         MeVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=CT+iVw53VhZtxdav+/O8yS9aLiCP6qk9zhLpSfOHoWA=;
        b=sxmd46y+R17kF+sugxZtcUO+9tJPSLNPGATy5ZjRsPU37y8l0X1Zevil17xMFFFb0w
         fkA72t+5H0C630Irz3poTD0FhKs+SfL+fa+E0HtOB+PmweYaNtMwmNtBUAXEV5W6fRA6
         uFRZ4zEPRLgv3Fmy+5dNFAhBeI6mXlK+frq40oPpuN+rk7xma1dOiJwDsUe/R50pBehM
         ZmRZik21+1c8/WJN48/916+8gBDMuZ66tHpyahxlYXsM7pGUQXgb/oNVy0i8dIiPrgqp
         zQK1iaHF4uC62uINj5kWvgWjH+/QtpUQ2Hd1iVqdg0tohsKf2ygXCfX/Xt9Hr8szMNEa
         mv5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="219323803"
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
Subject: [PATCH v3 10/10] Add a maintainer for the PECI subsystem
Date: Tue, 10 Apr 2018 11:32:12 -0700
Message-Id: <20180410183212.16787-11-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385146666746404?=
X-GMAIL-MSGID: =?utf-8?q?1597385146666746404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds a maintainer information for the PECI subsystem.

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
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cd5ff0e4428..3e6917e1ad31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10965,6 +10965,16 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/peaq-wmi.c
 
+PECI SUBSYSTEM
+M:	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+M:	Jason M Biils <jason.m.bills@linux.intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/peci/
+F:	drivers/peci/
+F:	drivers/hwmon/peci-*.c
+F:	include/linux/peci.h
+F:	include/uapi/linux/peci-ioctl.h
+
 PER-CPU MEMORY ALLOCATOR
 M:	Tejun Heo <tj@kernel.org>
 M:	Christoph Lameter <cl@linux.com>
-- 
2.16.2
