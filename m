Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3836EC5ACBA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEB7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEB7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeJPRJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:09:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:8740 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeJPRJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:09:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 02:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="81809970"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2018 02:20:16 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     gregkh@linuxfoundation.org, paul.burton@mips.com, jslaby@suse.com,
        Songjun Wu <songjun.wu@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [RESEND PATCH 10/14] serial: lantiq: Reorder the head files
Date:   Tue, 16 Oct 2018 17:19:11 +0800
Message-Id: <20181016091915.19909-11-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181016091915.19909-1-songjun.wu@linux.intel.com>
References: <20181016091915.19909-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the head files according to the coding style.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 88210de00f35..c983694ba24d 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -8,22 +8,22 @@
  * Copyright (C) 2010 Thomas Langer, <thomas.langer@lantiq.com>
  */
 
-#include <linux/slab.h>
-#include <linux/ioport.h>
-#include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/console.h>
-#include <linux/sysrq.h>
 #include <linux/device.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
-#include <linux/of_platform.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/gpio.h>
+#include <linux/of_platform.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/sysrq.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 
 #include <lantiq_soc.h>
 
-- 
2.11.0

