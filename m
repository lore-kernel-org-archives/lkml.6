Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FC020837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FC020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeH3WkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:40:00 -0400
Received: from smtprelay0051.hostedemail.com ([216.40.44.51]:48569 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726592AbeH3WkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:40:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D471618027FC3;
        Thu, 30 Aug 2018 18:36:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: page50_1b89bdde1cf14
X-Filterd-Recvd-Size: 1203
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Aug 2018 18:36:29 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/nouveau: Use more standard logging styles
Date:   Thu, 30 Aug 2018 11:36:25 -0700
Message-Id: <cover.1535654026.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduces object size ~4kb

Joe Perches (2):
  drm/nouveau: Add new logging function nv_cli_printk
  drm/nouveau: Convert NV_PRINTK macros and uses to new nv_cli_<level> macros

 drivers/gpu/drm/nouveau/nouveau_abi16.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c  | 12 +++----
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 21 +++++++++++
 drivers/gpu/drm/nouveau/nouveau_drv.h   | 44 ++++++++++++++---------
 drivers/gpu/drm/nouveau/nouveau_gem.c   | 62 ++++++++++++++++-----------------
 5 files changed, 87 insertions(+), 54 deletions(-)

-- 
2.15.0

