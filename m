Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx4+J0sLkePaRwpAfZU5JlOBLRV47xx+SiNkvmGVdR6IxJT9jzIBl4xHOa7MKuFosdXn5yJGE
ARC-Seal: i=1; a=rsa-sha256; t=1522963308; cv=none;
        d=google.com; s=arc-20160816;
        b=XE3dJLAEOUudTHWJ+V9TxmKo91aLeG3JIcC+BS6Yf4g4CTkzF6ZePRUukmFYie/u4C
         sSKrlFOIOFCwWiobPLdHwplr9nzsLbQ+iBaEYza60GVMQzkHm/7x7X/AWpFGVmDZObLJ
         8+BY+y1KJVPFLvQiirvuL+WnSvyVSqU+fPrEhxT1mSz7eu+f6vVOXqO7x3j9ZToXiUYb
         onjfavdlV1W/nQ8r7itKJiLo9hP+NL6DKJnFU5wIgG/EOZgTxZOmhWx5HexNvMlYUl5I
         Puj/RekgfSJfwxFc5xCMo/JknoHv8kf9tlI9dFEvqMzKqALUU8+OBFWMB3eSpunVmnwq
         O8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=pXkCfvItOjL5xGTAnu5T6kfSLQ1mcnDfAbOSZezWG+c=;
        b=gYonUS8ltxBu4MZeRBQ2Fo6Y8a5hEjfgZTXBEHKtaj14g7IOmPzD8BJphzfEOll7Xy
         MIe3xF6LEwO7Tu3OWq1wPC2QYjDGEQ5CAp84s3+xVc3c5MQ06jGnh//ED8uwwMejeJtV
         pXRCAGnKXdhIdrJwWrioHZqajwVOgLaEJ8WRwomOcwB2PWPhVR6m787fM9/xyNPQ+Gmo
         i5vV1I7kN+YtZQxVQNtZxHt4ZiUkB6I5vP5/IbUEJOcrUS5Ev5NjIg8Ynx58qIlat99q
         dO5I8raRQEGGmdWlwlO9zxiZuu0YhwigIkxekXPOTsk7sh2ChTIIDkdcqfhVmDQ50aCP
         p7mA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=ZXLwGrYW;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.93 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=ZXLwGrYW;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.93 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,412,1517875200";
   d="scan'208";a="94261359"
Date: Thu, 5 Apr 2018 14:24:33 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: [PATCH 10/10] staging: fnic2 add build and config
Message-ID: <20180405212433.GK12584@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405211519.GA12584@osmithde-lnx.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942774504895551?=
X-GMAIL-MSGID: =?utf-8?q?1596942774504895551?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files contain build and config files.

Signed-off-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Anil Chintalapati <achintal@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-Developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Oliver Smith-Denny <osmithde@cisco.com>
---
 drivers/staging/Kconfig            |  2 ++
 drivers/staging/Makefile           |  1 +
 drivers/staging/fnic2/Kconfig      |  6 ++++++
 drivers/staging/fnic2/LICENSE      | 13 +++++++++++++
 drivers/staging/fnic2/Makefile     |  3 +++
 drivers/staging/fnic2/TODO         | 14 ++++++++++++++
 drivers/staging/fnic2/src/Makefile | 28 ++++++++++++++++++++++++++++
 7 files changed, 67 insertions(+)
 create mode 100644 drivers/staging/fnic2/Kconfig
 create mode 100644 drivers/staging/fnic2/LICENSE
 create mode 100644 drivers/staging/fnic2/Makefile
 create mode 100644 drivers/staging/fnic2/TODO
 create mode 100644 drivers/staging/fnic2/src/Makefile

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index d5926f0..239e322 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -132,4 +132,6 @@ source "drivers/staging/mt7621-eth/Kconfig"
 
 source "drivers/staging/mt7621-dts/Kconfig"
 
+source "drivers/staging/fnic2/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 919753c..fdd9a63 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_SOC_MT7621)	+= mt7621-dma/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-mmc/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-eth/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
+obj-$(CONFIG_FNIC2)		+= fnic2/
diff --git a/drivers/staging/fnic2/Kconfig b/drivers/staging/fnic2/Kconfig
new file mode 100644
index 0000000..3983c30
--- /dev/null
+++ b/drivers/staging/fnic2/Kconfig
@@ -0,0 +1,6 @@
+config FNIC2
+        tristate "FNIC2 - CISCO FCoE HBA Driver"
+        depends on PCI && X86 && TARGET_CORE
+        help
+         This enables support for the Cisco FNIC2 FCoE HBA Driver
+         with SCSI Target Mode.
diff --git a/drivers/staging/fnic2/LICENSE b/drivers/staging/fnic2/LICENSE
new file mode 100644
index 0000000..1889afb
--- /dev/null
+++ b/drivers/staging/fnic2/LICENSE
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+This program is free software; you may redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; version 2 of the License.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+SOFTWARE.
diff --git a/drivers/staging/fnic2/Makefile b/drivers/staging/fnic2/Makefile
new file mode 100644
index 0000000..8f14039
--- /dev/null
+++ b/drivers/staging/fnic2/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+obj-$(CONFIG_FNIC2)	+= src/
diff --git a/drivers/staging/fnic2/TODO b/drivers/staging/fnic2/TODO
new file mode 100644
index 0000000..5d93ec3
--- /dev/null
+++ b/drivers/staging/fnic2/TODO
@@ -0,0 +1,14 @@
+* Add multiqueue support
+* Integrate vnic files with other drivers
+* Coding style changes (already ran smatch, sparse, checkpatch)
+* run them + coccinelle after further changes
+* Add NVME over FC support
+* Check per cmd locking to see if needed
+* Change statically allocated cmd pool to mempool
+* Add function headers
+
+Send patches to:
+	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+	Arulprabhu Ponnusamy <arulponn@cisco.com>
+	Gian Carlo Boffa <gcboffa@cisco.com>
+	Oliver Smith-Denny <osmithde@cisco.com>
diff --git a/drivers/staging/fnic2/src/Makefile b/drivers/staging/fnic2/src/Makefile
new file mode 100644
index 0000000..0d22ffc
--- /dev/null
+++ b/drivers/staging/fnic2/src/Makefile
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2018 Cisco Systems, Inc.
+# Makefile_wrap
+# This file prepended for out-of-kernel make by ofc/release/*/Makefile
+
+#
+# Add -I for building a set of modules out-of-kernel where they have
+# their own set of include files for include/scsi, for example.
+#
+CPPFLAGS := $(SUBTREE_INCLUDE) $(CPPFLAGS)
+# end of Makefile_wrap
+obj-$(CONFIG_FNIC2) += fnic2.o
+
+fnic2-y := \
+        fnic2_isr.o \
+	fnic2_main.o \
+	fnic2_res.o \
+	vnic_cq.o \
+	vnic_dev.o \
+	vnic_intr.o \
+	vnic_rq.o \
+	vnic_wq_copy.o \
+	vnic_wq.o \
+        fdls_if.o \
+	fip.o \
+	fdls_disc.o \
+	fnic2_cmd.o	\
+	fnic2_lio.o
-- 
1.8.3.1
