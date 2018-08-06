Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3F6C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CDF21A50
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Dvzprzxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CDF21A50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbeHFQss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:48:48 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35522 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbeHFQsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:48:37 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1633C1BD7;
        Mon,  6 Aug 2018 16:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533566350;
        bh=y7NYldyBaqoeUjytg0EfghoR7DLDMTgVlFcS71/sbTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvzprzxfEFwJZ5O5hrOKN2f37E2Bfb3SfPlchgf+dyRiJT4DaxheEmwoUtOx4zTgO
         lJH8a8J1z1g1MgfwSav/8EL5rjijyiIIeUjfcxiwrqiSwOicSoK9g3ry/q41evgXnb
         p3lVxqYnq+eHYALf0T8cTmxmenJgTbik7xVWYDTc=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        kbingham@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, jan.kiszka@siemens.com
Subject: [PATCH 4/4] MAINTAINERS: GDB: Update e-mail address
Date:   Mon,  6 Aug 2018 15:39:04 +0100
Message-Id: <20180806143904.4716-4-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
References: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kbingham@kernel.org>

This entry was created with my personal e-mail address. Update this
entry to my open-source kernel.org account.

Signed-off-by: Kieran Bingham <kbingham@kernel.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: jan.kiszka@siemens.com

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 174c0c3da67e..c25060e995b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5931,7 +5931,7 @@ F:	Documentation/dev-tools/gcov.rst
 
 GDB KERNEL DEBUGGING HELPER SCRIPTS
 M:	Jan Kiszka <jan.kiszka@siemens.com>
-M:	Kieran Bingham <kieran@bingham.xyz>
+M:	Kieran Bingham <kbingham@kernel.org>
 S:	Supported
 F:	scripts/gdb/
 
-- 
2.17.1

