Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5714C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8221021A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ufTN+14O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8221021A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbeHFQsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:48:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35516 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFQsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:48:36 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 94F2C1BD6;
        Mon,  6 Aug 2018 16:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533566349;
        bh=L5f8znX+Ln9uvLETeys7tb7Hra/peFDXpwk99mz4T3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufTN+14OmDu5ZbEJoAzZpioGR5FdWLyV5EPeLXAyAu270nZp6ljMgIn965Gb36IoM
         inWd1Kz2dIZHGhWMLVuDin2f612rw+msOLTNZm2+gagpzAuvIXNOIxS1ZBcJGMd8yT
         dz9R0i8fITXalzj5XEup3u4SZVgexaQJbjj4EIhk=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        kbingham@kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/4] MAINTAINERS: FDP1: Update e-mail address.
Date:   Mon,  6 Aug 2018 15:39:03 +0100
Message-Id: <20180806143904.4716-3-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
References: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

This entry was created with my personal e-mail address. Update with
the correct work related account.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
Cc: linux-media@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a30a5332b18..174c0c3da67e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8915,7 +8915,7 @@ F:	drivers/media/platform/rcar-fcp.c
 F:	include/media/rcar-fcp.h
 
 MEDIA DRIVERS FOR RENESAS - FDP1
-M:	Kieran Bingham <kieran@bingham.xyz>
+M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
 L:	linux-media@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
-- 
2.17.1

