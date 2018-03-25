Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753860AbeCYSCu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 14:02:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41368 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeCYSCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 14:02:48 -0400
X-Google-Smtp-Source: AIpwx4/FmufLHtDjBlWR9iL/9RWJsxnkzo91ZIS/n2RPIFEFKjLfCW+GJVI+jDCRmmcic+VqYddTIQ==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie,
        seanpaul@chromium.org, gustavo@padovan.org, daniel.vetter@intel.com,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH v2 0/2] drm: Replace list_entry
Date: Sun, 25 Mar 2018 23:31:31 +0530
Message-Id: <1522000893-5331-1-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace list_entry with list_{next/prev}_entry.

Arushi Singhal (2):
  gpu: drm/lease:: Use list_{next/prev}_entry instead of list_entry
  gpu: drm: nouveau: Use list_{next/prev}_entry instead of list_entry

 drivers/gpu/drm/drm_lease.c                    | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
changes in v2
*All the maintainers are added.
*More accurate coccinelle script is used
for this patch than the one used in previous version.
2.7.4
