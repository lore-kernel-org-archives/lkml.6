Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeEYFpk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:45:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39459 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeEYFpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:45:39 -0400
X-Google-Smtp-Source: ADUXVKLbGay4KES/wb87WBw875a3wpK7TqidZYcBK4glMgu5HGJakAyTMKAL8yzqLz/Wq6EsF6jvOsd2089ILy4n0YM=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 25 May 2018 15:45:37 +1000
Message-ID: <CAPM=9tx3ZU0mRzwuHCmfVjNi9-=g7BeF5OJr5f2nZbEp9cBzWg@mail.gmail.com>
Subject: [git pull] drm fixes for v4.17-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Only two sets of drivers fixes, one rcar-du lvds regression fix, and a
group of fixes for vmwgfx.

Regards,
Dave.

The following changes since commit 771c577c23bac90597c685971d7297ea00f99d11:

  Linux 4.17-rc6 (2018-05-20 15:31:38 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.17-rc7

for you to fetch changes up to 4bc6f777952cf2d5b39e0c5a97a18caa743f03b7:

  Merge branch 'vmwgfx-fixes-4.17' of
git://people.freedesktop.org/~thomash/linux into drm-fixes (2018-05-25
09:47:56 +1000)

----------------------------------------------------------------
vmwgfx, rcar-du fixes

----------------------------------------------------------------
Dave Airlie (2):
      Merge branch 'drm/du/fixes' of git://linuxtv.org/pinchartl/media
into drm-fixes
      Merge branch 'vmwgfx-fixes-4.17' of
git://people.freedesktop.org/~thomash/linux into drm-fixes

Laurent Pinchart (1):
      drm: rcar-du: lvds: Fix crash in .atomic_check when disabling connector

Thomas Hellstrom (3):
      drm/vmwgfx: Fix 32-bit VMW_PORT_HB_[IN|OUT] macros
      drm/vmwgfx: Fix host logging / guestinfo reading error paths
      drm/vmwgfx: Schedule an fb dirty update after resume

 drivers/gpu/drm/rcar-du/rcar_lvds.c |  3 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c |  5 ----
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |  1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c  | 22 ++++++-----------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 48 ++++++++++++++++++++++++-------------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h | 25 ++++++++++++-------
 6 files changed, 58 insertions(+), 46 deletions(-)
