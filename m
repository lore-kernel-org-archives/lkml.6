Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA51C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885612082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885612082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mxic.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeJYPQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:16:02 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:50695 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:16:01 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id w9P6iWAS037555;
        Thu, 25 Oct 2018 14:44:32 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   masonccyang@mxic.com.tw
To:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw
Cc:     masonccyang@mxic.com.tw
Subject: [PATCH] mtd: rawnand: Add all 1.8V AC chips have a broken GET_FEATURES(TIMINGS) 
Date:   Thu, 25 Oct 2018 14:44:30 +0800
Message-Id: <1540449871-7224-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com w9P6iWAS037555
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mason Yang <masonccyang@mxic.com.tw>

Hi Boris,
I patched this for Macronix all 1.8V AC chips.
Thanks for your review.

best regards,
Mason

Mason Yang (1):
  mtd: rawnand: Add All 1.8V AC chips have a broken
    GET_FEATURES(TIMINGS)

 drivers/mtd/nand/raw/nand_macronix.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
1.9.1

