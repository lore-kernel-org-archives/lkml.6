Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KPcHOnkBGFsJbwAAmS7hNA
	; Wed, 06 Jun 2018 15:45:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BD961607CF; Wed,  6 Jun 2018 15:45:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2BFEF60555;
	Wed,  6 Jun 2018 15:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BFEF60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=s-opensource.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932270AbeFFPpO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:45:14 -0400
Received: from osg.samsung.com ([64.30.133.232]:51040 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932148AbeFFPpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:45:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 9318F3B81B;
        Wed,  6 Jun 2018 08:45:07 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3dhTDWgG7A_g; Wed,  6 Jun 2018 08:45:03 -0700 (PDT)
Received: from smtp.s-opensource.com (177.43.29.180.dynamic.adsl.gvt.net.br [177.43.29.180])
        by osg.samsung.com (Postfix) with ESMTPSA id 90F503B807;
        Wed,  6 Jun 2018 08:45:03 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.87)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1dAbPD-0000yW-5A; Tue, 16 May 2017 09:16:47 -0300
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        linux-mtd@lists.infradead.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 51/53] usb: fix the comment with regards to DocBook
Date: Tue, 16 May 2017 09:16:43 -0300
Message-Id:
 <ce4a23cca5f809a588bd53c3289e6b953bb7ccc3.1494935649.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1494935649.git.mchehab@s-opensource.com>
References: <cover.1494935649.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1494935649.git.mchehab@s-opensource.com>
References: <cover.1494935649.git.mchehab@s-opensource.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20170516121643.7yY2t-5Lu7tdiG__zcjX1IeK1-8YDxMZMKVb7zt-sYc@z>

The USB gadget documentation is not at DocBook anymore.
The main file was converted to ReST, and stored at
Documentation/driver-api/usb/gadget.rst, but there are
still several plain text files related to gadget under
Documentation/usb.

So, be generic and just mention documentation
without specifying where it is.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/usb/gadget/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index c164d6b788c3..b3c879b75a39 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -41,7 +41,7 @@ menuconfig USB_GADGET
 	   don't have this kind of hardware (except maybe inside Linux PDAs).
 
 	   For more information, see <http://www.linux-usb.org/gadget> and
-	   the kernel DocBook documentation for this API.
+	   the kernel documentation for this API.
 
 if USB_GADGET
 
-- 
2.9.3
