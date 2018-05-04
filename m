Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeEDXsu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:48:50 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43203 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeEDXst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:48:49 -0400
X-Google-Smtp-Source: AB8JxZrQp5aRpz2NPCFyvAGq7WZOeSEEC3b9AgzhtqTluQyTOB6hzm1py+hzqmgA3YOuNvRY/76ym3yNAe+IDuqlo1s=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 5 May 2018 09:48:47 +1000
Message-ID: <CAPM=9tx6rL9hnWn-kq0KdmE=1Sbz57k6-WBGURYEhp=trdFsLw@mail.gmail.com>
Subject: [git pull] drm fixes for 4.17-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This seems eerily quiet, so I expect it will explode next week or something.

One i915 moduel firmware, two vmwgfx fixes, one vc4 fix and one bridge leak fix.

Dave.

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.17-rc4

for you to fetch changes up to a02cbe2e34c576cdc5e7846a3cd55245ab81db47:

  Merge branch 'vmwgfx-fixes-4.17' of
git://people.freedesktop.org/~thomash/linux into drm-fixes (2018-05-04
10:03:27 +1000)

----------------------------------------------------------------
vmwgfx, i915, vc4, vga dac fixes

----------------------------------------------------------------
Boris Brezillon (1):
      drm/vc4: Make sure vc4_bo_{inc,dec}_usecnt() calls are balanced

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2018-05-02' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2018-05-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'vmwgfx-fixes-4.17' of
git://people.freedesktop.org/~thomash/linux into drm-fixes

Ian W MORRISON (1):
      drm/i915/glk: Add MODULE_FIRMWARE for Geminilake

Sean Paul (1):
      drm/bridge: vga-dac: Fix edid memory leak

Thomas Hellstrom (2):
      drm/vmwgfx: Clean up fbdev modeset locking
      drm/vmwgfx: Fix a buffer object leak

 drivers/gpu/drm/bridge/dumb-vga-dac.c |  4 ++-
 drivers/gpu/drm/i915/intel_csr.c      |  1 +
 drivers/gpu/drm/vc4/vc4_crtc.c        | 46 ++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c    | 31 ++++++++---------------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c   | 14 ++++++++---
 5 files changed, 70 insertions(+), 26 deletions(-)
