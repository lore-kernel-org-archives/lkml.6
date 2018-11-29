Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063D4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20BC20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20BC20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeK2UGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:06:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34625 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbeK2UG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:06:29 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 106B020CFC; Thu, 29 Nov 2018 10:01:49 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id B814A207A8;
        Thu, 29 Nov 2018 10:01:38 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 0/1] media: cedrus: Remove global IRQ spin lock from the driver
Date:   Thu, 29 Nov 2018 10:00:47 +0100
Message-Id: <20181129090048.16482-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
* Reworked commit message as suggested by Maxime.

Paul Kocialkowski (1):
  media: cedrus: Remove global IRQ spin lock from the driver

 drivers/staging/media/sunxi/cedrus/cedrus.c       |  1 -
 drivers/staging/media/sunxi/cedrus/cedrus.h       |  2 --
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c   |  9 ---------
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c    | 13 +------------
 drivers/staging/media/sunxi/cedrus/cedrus_video.c |  5 -----
 5 files changed, 1 insertion(+), 29 deletions(-)

-- 
2.19.1

