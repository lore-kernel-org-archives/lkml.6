Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5365AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA23218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfAXTar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:30:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:48320 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbfAXTam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:30:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 11:30:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="112404822"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2019 11:30:41 -0800
Subject: [PATCH] MAINTAINERS: Update filesystem-dax and NVDIMM entries
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Matthew Wilcox <willy@infradead.org>, linux-nvdimm@lists.01.org
Date:   Thu, 24 Jan 2019 11:17:59 -0800
Message-ID: <154835747897.2884847.389054528444820204.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ross has moved on to other areas.

Matthew and Jan are trusted reviewers for DAX.

Dan is now coordinating filesystem-dax pull requests.

Ira and Keith are now involved with the NVDIMM and Device-DAX
sub-systems.

The linux-nvdimm mailing hosts a patchwork instance for both DAX and
NVDIMM patches.

Cc: Jan Kara <jack@suse.cz>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a425dbe..5f43ee438a74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4535,10 +4535,11 @@ S:	Maintained
 F:	drivers/i2c/busses/i2c-diolan-u2c.c
 
 FILESYSTEM DIRECT ACCESS (DAX)
-M:	Matthew Wilcox <willy@infradead.org>
-M:	Ross Zwisler <zwisler@kernel.org>
-M:	Jan Kara <jack@suse.cz>
+M:	Dan Williams <dan.j.williams@intel.com>
+R:	Matthew Wilcox <willy@infradead.org>
+R:	Jan Kara <jack@suse.cz>
 L:	linux-fsdevel@vger.kernel.org
+L:	linux-nvdimm@lists.01.org
 S:	Supported
 F:	fs/dax.c
 F:	include/linux/dax.h
@@ -4546,9 +4547,9 @@ F:	include/trace/events/fs_dax.h
 
 DEVICE DIRECT ACCESS (DAX)
 M:	Dan Williams <dan.j.williams@intel.com>
-M:	Dave Jiang <dave.jiang@intel.com>
-M:	Ross Zwisler <zwisler@kernel.org>
 M:	Vishal Verma <vishal.l.verma@intel.com>
+M:	Keith Busch <keith.busch@intel.com>
+M:	Dave Jiang <dave.jiang@intel.com>
 L:	linux-nvdimm@lists.01.org
 S:	Supported
 F:	drivers/dax/
@@ -8641,7 +8642,6 @@ S:	Maintained
 F:	tools/lib/lockdep/
 
 LIBNVDIMM BLK: MMIO-APERTURE DRIVER
-M:	Ross Zwisler <zwisler@kernel.org>
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
@@ -8654,7 +8654,6 @@ F:	drivers/nvdimm/region_devs.c
 LIBNVDIMM BTT: BLOCK TRANSLATION TABLE
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dan Williams <dan.j.williams@intel.com>
-M:	Ross Zwisler <zwisler@kernel.org>
 M:	Dave Jiang <dave.jiang@intel.com>
 L:	linux-nvdimm@lists.01.org
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
@@ -8662,7 +8661,6 @@ S:	Supported
 F:	drivers/nvdimm/btt*
 
 LIBNVDIMM PMEM: PERSISTENT MEMORY DRIVER
-M:	Ross Zwisler <zwisler@kernel.org>
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
@@ -8681,9 +8679,10 @@ F:	Documentation/devicetree/bindings/pmem/pmem-region.txt
 
 LIBNVDIMM: NON-VOLATILE MEMORY DEVICE SUBSYSTEM
 M:	Dan Williams <dan.j.williams@intel.com>
-M:	Ross Zwisler <zwisler@kernel.org>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
+M:	Keith Busch <keith.busch@intel.com>
+M:	Ira Weiny <ira.weiny@intel.com>
 L:	linux-nvdimm@lists.01.org
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git

