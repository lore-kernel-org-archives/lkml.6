Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeCIQif (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:38:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:42425 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeCIQie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:38:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,446,1515484800";
   d="scan'208";a="26649554"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH] MAINTAINERS: add coverage for drivers/block
Date: Fri,  9 Mar 2018 09:38:26 -0700
Message-Id: <20180309163826.25042-1-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-reply-to: <92dc07f1-dfbd-2449-ce76-502455f56136@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help folks like me that use scripts/get_maintainer.pl.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf8d72d..7ff83f4c9aeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2685,6 +2685,7 @@ L:	linux-block@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	block/
+F:	drivers/block/
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
-- 
2.14.3
