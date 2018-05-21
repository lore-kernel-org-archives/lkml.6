Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeEUUAP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 16:00:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:20317 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751253AbeEUUAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 16:00:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,427,1520924400";
   d="scan'208";a="201237654"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>
Subject: [v4 11/11] Add maintainers for the PECI subsystem
Date: Mon, 21 May 2018 13:00:10 -0700
Message-Id: <20180521200010.28161-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds maintainer information for the PECI subsystem.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
Reviewed-by: James Feist <james.feist@linux.intel.com>
Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: Jason M Biils <jason.m.bills@linux.intel.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9051a9ca24a2..e85a95f6fb08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11073,6 +11073,16 @@ L:	platform-driver-x86@vger.kernel.org
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
2.17.0
