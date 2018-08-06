Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E178C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBD221A50
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="elDk9oAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBD221A50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbeHFQsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:48:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35504 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbeHFQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:48:35 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0E0711BC0;
        Mon,  6 Aug 2018 16:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533566349;
        bh=ONHxEc0poXW6VhcJYuZ+1ipWEFGUxokGbKrwhPmGQhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elDk9oAnx806OSrYKOAMLo+8kZFnAdbfYR6gPTbzmKZ5FvRi/nXXtAombw5AvMyCC
         WTSe4SUrf69vUA4p3qS1gvjhrn8t7TVvRShx2kSYhg0zWFpY/gRc/VdXntmJ6cliiT
         H/t9oFH7bkN1DkcAEDVWSwdX/NOMW9A84m+Yklyc=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        kbingham@kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/4] MAINTAINERS: VSP1: Add co-maintainer
Date:   Mon,  6 Aug 2018 15:39:02 +0100
Message-Id: <20180806143904.4716-2-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
References: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Add myself as a co-maintainer for the Renesas VSP driver.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c7cecb9201b3..6a30a5332b18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8935,6 +8935,7 @@ F:	drivers/media/platform/rcar-vin/
 
 MEDIA DRIVERS FOR RENESAS - VSP1
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
 L:	linux-media@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
-- 
2.17.1

