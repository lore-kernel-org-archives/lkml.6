Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D224AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CB720817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CB720817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeKRDRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 22:17:06 -0500
Received: from kozue.soulik.info ([108.61.200.231]:45120 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeKRDRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 22:17:06 -0500
Received: from misaki.sumomo.pri (unknown [192.168.0.134])
        by kozue.soulik.info (Postfix) with ESMTPA id 2345E100F77;
        Sun, 18 Nov 2018 01:54:29 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     dri-devel@lists.freedesktop.org
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, linux-kernel@vger.kernel.org,
        hjc@rock-chips.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, Randy Li <ayaka@soulik.info>
Subject: [PATCH v4 0/2] Add support for a YUV 10bits pixel format
Date:   Sun, 18 Nov 2018 00:53:44 +0800
Message-Id: <20181117165346.25091-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder why this patches are still not merged and well review.
So I just re-send them. I wish it is merged in a short time, or
I can't add a new pixel format to weston.

You can use the Gstreamer to verify this patch.

Randy Li (2):
  drm/fourcc: add a 10bits fully packed variant of NV12
  drm/rockchip: Support 10 bits yuv format in vop

 drivers/gpu/drm/drm_fourcc.c                |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 16 ++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  2 ++
 include/uapi/drm/drm_fourcc.h               |  8 ++++++++
 5 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.14.5

