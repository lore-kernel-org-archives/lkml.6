Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CB686C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3C1208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3C1208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964858AbeFMVKc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:10:32 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:54991 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935931AbeFMVJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:09:17 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 Jun 2018 14:09:12 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 112E540961;
        Wed, 13 Jun 2018 14:09:16 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 7/7] vmw_balloon: update maintainers list
Date:   Wed, 13 Jun 2018 06:54:12 -0700
Message-ID: <20180613135412.81660-8-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180613135412.81660-1-namit@vmware.com>
References: <20180613135412.81660-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Moltman is no longer a maintainer of the VMware balloon. Setting
Nadav Amit as one instead.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 MAINTAINERS                | 2 +-
 drivers/misc/vmw_balloon.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c374d97c967..78009d21293a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15136,7 +15136,7 @@ F:	include/linux/vme*
 
 VMWARE BALLOON DRIVER
 M:	Xavier Deguillard <xdeguillard@vmware.com>
-M:	Philip Moltmann <moltmann@vmware.com>
+M:	Nadav Amit <namit@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index b982059ce7b7..a10eab56a47c 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -15,7 +15,7 @@
  * details.
  *
  * Maintained by:	Xavier Deguillard <xdeguillard@vmware.com>
- *			Philip Moltmann <moltmann@vmware.com>
+ *			Nadav Amit <namit@vmware.com>
  */
 
 /*
-- 
2.17.0

