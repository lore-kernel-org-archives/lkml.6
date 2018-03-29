Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeC2BFt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 21:05:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44634 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeC2BFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 21:05:48 -0400
X-Google-Smtp-Source: AIpwx4/LqFrFpA1NanrHUrFf17fCDSWEgMK8IPF6mfcigBnnXMg3EFYENnsLJQDoKYox42E3Y4Wso3cGThi63APR8GI=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 29 Mar 2018 11:05:45 +1000
Message-ID: <CAPM=9tzkse4DkAtPiUhorkO+fie+5c3W9rZPBQdvX3qZqcBOHw@mail.gmail.com>
Subject: [git pull] drm fixes for 4.16 final
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Nothing serious, two amdkfd and two tegra fixes.

I'll be submitting -next early, in the next couple of hours.

Dave.

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.16-rc8

for you to fetch changes up to ef55d1538dfb823a4475bd690f78b5edc0d2a6fd:

  Merge tag 'drm/tegra/for-4.16-fixes' of
git://anongit.freedesktop.org/tegra/linux into drm-fixes (2018-03-29
09:57:09 +1000)

----------------------------------------------------------------
tegra + amdkfd final fixes

----------------------------------------------------------------
Dave Airlie (2):
      Merge tag 'drm-amdkfd-fixes-2018-03-25' of
git://people.freedesktop.org/~gabbayo/linux into drm-fixes
      Merge tag 'drm/tegra/for-4.16-fixes' of
git://anongit.freedesktop.org/tegra/linux into drm-fixes

Felix Kuehling (2):
      drm/amdkfd: Fix scratch memory with HWS enabled
      drm/amdkfd: Deallocate SDMA queues correctly

Stefan Agner (1):
      drm/tegra: dc: Use correct format array for Tegra124

Wei Yongjun (1):
      drm/tegra: dc: Using NULL instead of plain integer

 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 20 ++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c      |  3 +--
 drivers/gpu/drm/tegra/dc.c                           |  6 +++---
 3 files changed, 18 insertions(+), 11 deletions(-)
