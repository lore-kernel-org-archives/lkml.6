Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeDMUrm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 16:47:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:23692 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeDMUrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 16:47:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,446,1517904000";
   d="scan'208";a="31885352"
Subject: [PATCH] MAINTAINERS: Adding backup maintainers for libnvdimm and DAX
From: Dave Jiang <dave.jiang@intel.com>
To: dan.j.williams@intel.com
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Date: Fri, 13 Apr 2018 13:47:40 -0700
Message-ID: <152365245998.33329.8224892765972973116.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding additional maintainers to libnvdimm related code and DAX.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 MAINTAINERS |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73d83416d852..958f75ad4193 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4246,6 +4246,9 @@ F:	include/trace/events/fs_dax.h
 
 DEVICE DIRECT ACCESS (DAX)
 M:	Dan Williams <dan.j.williams@intel.com>
+M:	Dave Jiang <dave.jiang@intel.com>
+M:	Ross Zwisler <ross.zwisler@linux.intel.com>
+M:	Vishal Verma <vishal.l.verma@intel.com>
 L:	linux-nvdimm@lists.01.org
 S:	Supported
 F:	drivers/dax/
@@ -8034,6 +8037,9 @@ F:	tools/lib/lockdep/
 
 LIBNVDIMM BLK: MMIO-APERTURE DRIVER
 M:	Ross Zwisler <ross.zwisler@linux.intel.com>
+M:	Dan Williams <dan.j.williams@intel.com>
+M:	Vishal Verma <vishal.l.verma@intel.com>
+M:	Dave Jiang <dave.jiang@intel.com>
 L:	linux-nvdimm@lists.01.org
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 S:	Supported
@@ -8042,6 +8048,9 @@ F:	drivers/nvdimm/region_devs.c
 
 LIBNVDIMM BTT: BLOCK TRANSLATION TABLE
 M:	Vishal Verma <vishal.l.verma@intel.com>
+M:	Dan Williams <dan.j.williams@intel.com>
+M:	Ross Zwisler <ross.zwisler@linux.intel.com>
+M:	Dave Jiang <dave.jiang@intel.com>
 L:	linux-nvdimm@lists.01.org
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 S:	Supported
@@ -8049,6 +8058,9 @@ F:	drivers/nvdimm/btt*
 
 LIBNVDIMM PMEM: PERSISTENT MEMORY DRIVER
 M:	Ross Zwisler <ross.zwisler@linux.intel.com>
+M:	Dan Williams <dan.j.williams@intel.com>
+M:	Vishal Verma <vishal.l.verma@intel.com>
+M:	Dave Jiang <dave.jiang@intel.com>
 L:	linux-nvdimm@lists.01.org
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 S:	Supported
@@ -8064,6 +8076,9 @@ F:	Documentation/devicetree/bindings/pmem/pmem-region.txt
 
 LIBNVDIMM: NON-VOLATILE MEMORY DEVICE SUBSYSTEM
 M:	Dan Williams <dan.j.williams@intel.com>
+M:	Ross Zwisler <ross.zwisler@linux.intel.com>
+M:	Vishal Verma <vishal.l.verma@intel.com>
+M:	Dave Jiang <dave.jiang@intel.com>
 L:	linux-nvdimm@lists.01.org
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
