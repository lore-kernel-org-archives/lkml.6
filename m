Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8982077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8982077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeIGVQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:16:05 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:60412 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeIGVQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:16:04 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id CBB41C025E;
        Fri,  7 Sep 2018 18:34:21 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 3D974C0F67; Fri,  7 Sep 2018 18:34:20 +0200 (CEST)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 14BF8C0F44;
        Fri,  7 Sep 2018 18:33:55 +0200 (CEST)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 0/2] Follow-up patches for Cedrus v9
Date:   Fri,  7 Sep 2018 18:33:45 +0200
Message-Id: <20180907163347.32312-1-contact@paulk.fr>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings the requested modifications on top of version 9 of the
Cedrus VPU driver, that implements stateless video decoding using the
Request API.

Paul Kocialkowski (2):
  media: cedrus: Fix error reporting in request validation
  media: cedrus: Add TODO file with tasks to complete before unstaging

 drivers/staging/media/sunxi/cedrus/TODO     |  7 +++++++
 drivers/staging/media/sunxi/cedrus/cedrus.c | 15 ++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)
 create mode 100644 drivers/staging/media/sunxi/cedrus/TODO

-- 
2.18.0

