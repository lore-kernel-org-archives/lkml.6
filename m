Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id K+iqA79FGVu8JAAAmS7hNA
	; Thu, 07 Jun 2018 14:49:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 60D13608BA; Thu,  7 Jun 2018 14:49:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2C289601C3;
	Thu,  7 Jun 2018 14:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C289601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935132AbeFGOtG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:49:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40859 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934860AbeFGOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:49:02 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbj-0005Zv-6E; Thu, 07 Jun 2018 15:09:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002yk-Eo; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Andi Shyti" <andi.shyti@samsung.com>,
        "Marcus Folkesson" <marcus.folkesson@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.591046177@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 191/410] Input: mms114 - fix license module information
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Shyti <andi.shyti@samsung.com>

commit 498e7e7ed1fd72c275a682f0903c4a20cc538658 upstream.

The driver has been released with GNU Public License v2 as stated
in the header, but the module license information has been tagged
as "GPL" (GNU Public License v2 or later).

Fix the module license information so that it matches the one in
the header as "GPL v2".

Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
Reported-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/touchscreen/mms114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -592,4 +592,4 @@ module_i2c_driver(mms114_driver);
 /* Module information */
 MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
 MODULE_DESCRIPTION("MELFAS mms114 Touchscreen driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
