Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A0ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACDE20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACDE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeJZAJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:09:34 -0400
Received: from mr301.theemaillaundry.net ([109.169.43.93]:54360 "EHLO
        mr301.theemaillaundry.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeJZAJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:09:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mr301.theemaillaundry.net (Postfix) with ESMTP id 5994580A63;
        Thu, 25 Oct 2018 16:36:14 +0100 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mr301.theemaillaundry.net
X-Virus-Scanned: amavisd-new at theemaillaundry.net
Received: from mr301.theemaillaundry.net ([127.0.0.1])
        by localhost (mr301.theemaillaundry.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KnTFKyCGk_sv; Thu, 25 Oct 2018 16:36:06 +0100 (IST)
Received: from statler.emutex.com (unknown [92.51.199.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mr301.theemaillaundry.net (Postfix) with ESMTPS id 4DC6081047;
        Thu, 25 Oct 2018 16:36:06 +0100 (IST)
Received: from [10.10.68.81] (helo=dan-Latitude-E5450.emutex.com)
        by statler.emutex.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.84)
        (envelope-from <dan@emutex.com>)
        id 1gFhg2-0008BR-FH; Thu, 25 Oct 2018 16:36:02 +0100
From:   Dan O'Donovan <dan@emutex.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v3 3/3] iio: adc128s052: use SPDX-License-Identifier
Date:   Thu, 25 Oct 2018 16:35:42 +0100
Message-Id: <1540481742-23596-4-git-send-email-dan@emutex.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540481742-23596-1-git-send-email-dan@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the ti-adc128s052.c file to use SPDX-License-Identifier
instead of more verbose license text.

Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/iio/adc/ti-adc128s052.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index c2d1453..7d2861f 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 Angelo Compagnucci <angelo.compagnucci@gmail.com>
  *
@@ -6,10 +7,6 @@
  * http://www.ti.com/lit/ds/symlink/adc128s052.pdf
  * http://www.ti.com/lit/ds/symlink/adc122s021.pdf
  * http://www.ti.com/lit/ds/symlink/adc124s021.pdf
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/acpi.h>
-- 
2.7.4


------
This email has been scanned for spam and malware by The Email Laundry.

