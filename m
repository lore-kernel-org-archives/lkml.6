Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B789C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0212054F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0212054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbeHWRE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:04:57 -0400
Received: from sauhun.de ([88.99.104.3]:59952 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbeHWRE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:04:57 -0400
Received: from localhost (p54B337EB.dip0.t-ipconnect.de [84.179.55.235])
        by pokefinder.org (Postfix) with ESMTPSA id 1B8FF30146A;
        Thu, 23 Aug 2018 15:35:10 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        dmaengine@vger.kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 0/2] tree-wide: use SPDX identifier for Renesas drivers
Date:   Thu, 23 Aug 2018 15:34:53 +0200
Message-Id: <20180823133456.4748-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am resending only the patches which needed the s/GPL-2.0-or-later/GPL-2.0+/
replacement. I fixed that and checkpatch is still happy.

Wolfram Sang (2):
  dmaengine: use SPDX identifier for Renesas drivers
  can: rcar: use SPDX identifier for Renesas drivers

 drivers/dma/nbpfaxi.c             | 5 +----
 drivers/dma/sh/shdma-arm.h        | 5 +----
 drivers/dma/sh/shdma-base.c       | 5 +----
 drivers/dma/sh/shdma-of.c         | 5 +----
 drivers/dma/sh/shdma-r8a73a4.c    | 5 +----
 drivers/dma/sh/shdma.h            | 6 +-----
 drivers/dma/sh/shdmac.c           | 6 +-----
 drivers/dma/sh/sudmac.c           | 5 +----
 drivers/dma/sh/usb-dmac.c         | 5 +----
 drivers/net/can/rcar/rcar_can.c   | 6 +-----
 drivers/net/can/rcar/rcar_canfd.c | 6 +-----
 11 files changed, 11 insertions(+), 48 deletions(-)

-- 
2.11.0

