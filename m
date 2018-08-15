Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CB4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085252150A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085252150A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeHOWIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:08:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727330AbeHOWIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:08:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DC6540201DB;
        Wed, 15 Aug 2018 19:15:18 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 866C82166BA0;
        Wed, 15 Aug 2018 19:15:16 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>
Subject: [PATCH v3 0/3] Cleanup drm_kms_helper_poll_enable/disable() calls
Date:   Wed, 15 Aug 2018 15:15:10 -0400
Message-Id: <20180815191513.6266-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 15 Aug 2018 19:15:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 15 Aug 2018 19:15:18 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next version of https://patchwork.freedesktop.org/series/48131/

Only changes are new A-Bs and R-Bs

Lyude Paul (3):
  drm/nouveau: Remove useless poll_enable() call in
    switcheroo_set_state()
  drm/nouveau: Remove useless poll_disable() call in
    switcheroo_set_state()
  drm/nouveau: Remove useless poll_enable() call in drm_load()

 drivers/gpu/drm/nouveau/nouveau_drm.c | 4 +---
 drivers/gpu/drm/nouveau/nouveau_vga.c | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

-- 
2.17.1

