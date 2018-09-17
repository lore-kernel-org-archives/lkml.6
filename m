Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7E3ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14D62147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14D62147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mxic.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeIQNGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:06:54 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:42592 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIQNGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:06:54 -0400
X-Greylist: delayed 1433 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2018 09:06:53 EDT
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id w8H7Gsb5078613
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:16:54 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id w8H7GmMZ078541;
        Mon, 17 Sep 2018 15:16:48 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   masonccyang@mxic.com.tw
To:     broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     boris.brezillon@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw, masonccyang@mxic.com.tw
Subject: [PATCH 0/2] spi: Add Macronix controller driver
Date:   Mon, 17 Sep 2018 15:16:17 +0800
Message-Id: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com w8H7GmMZ078541
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mason Yang <masonccyang@mxic.com.tw>

Hi Mark and Trent,

I patched spi-mxic.c and add the run time PM function.

thanks & best regards,
Mason

Mason Yang (2):
  spi: Add MXIC controller driver
  dt-binding: spi: Document Macronix controller bindings

 Documentation/devicetree/bindings/spi/spi-mxic.txt |  34 ++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mxic.c                             | 674 +++++++++++++++++++++
 4 files changed, 715 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
 create mode 100644 drivers/spi/spi-mxic.c

-- 
1.9.1

