Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeBJTru (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 14:47:50 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:36172 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeBJTrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 14:47:49 -0500
X-Google-Smtp-Source: AH8x225u3wmI68pL7ie38FjPaPTYZJpVb7+YFUqswWCquMWmPqGoxtLcm0sDh+tfpEjo+EUckVm6bks7WTtiLRwlHXE=
MIME-Version: 1.0
From: Darren Hart <dvhart@gmail.com>
Date: Sat, 10 Feb 2018 11:47:47 -0800
Message-ID: <CAJuF2pwa1kt1egYTdrrrv9VOS3j1oco6bfcRrezCdQ9t0Fo5zg@mail.gmail.com>
Subject: [GIT PULL] platform-drivers-x86 for 4.16-3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This series can wait for the RC cycle if you prefer. It's ready now
and it simplifies branch management a bit on our end to merge it now. It
is isolated to the Mellanox hotplug and platform drivers, and is mostly
data for new system types with a correction and an uninitialized
variable fix.

Note: My usual mail and git services are down... right before sending this.
I'm sending you the email from gmail, and I fortunately mirrored the
signed tag to github. I've updated the Pull Request below to list both the
usual infradead URL as well as the github backup URL. Apologies if this
breaks some part of the process.

Thanks,

Darren Hart
VMware Open Source Technology Center

The following changes since commit 9a7c551ba7aae3648473179f234e960cfd46eaf4:

  platform/x86: samsung-laptop: Re-use DEFINE_SHOW_ATTRIBUTE() macro
(2018-02-07 12:50:23 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git
tags/platform-drivers-x86-v4.16-3
  Alternatively:
  https://github.com/dvhart/linux-pdx86.git tags/platform-drivers-x86-v4.16-3

for you to fetch changes up to 1bd42d94ccab4eab5dc9dc9d303a687a61cde9bd:

  platform/x86: mlx-platform: Add support for new 200G IB and Ethernet
systems (2018-02-09 17:23:20 -0800)

----------------------------------------------------------------
platform-drivers-x86 for v4.16-3

Mellanox fixes and new system type support.

The following is an automated git shortlog grouped by driver:

mlx-platform:
 -  Add support for new 200G IB and Ethernet systems
 -  Add support for new msn201x system type
 -  Add support for new msn274x system type
 -  Fix power cable setting for msn21xx family
 -  Add define for the negative bus
 -  Use defines for bus assignment

platform/mellanox:
 -  mlxreg-hotplug: Fix uninitialized variable

----------------------------------------------------------------
Geert Uytterhoeven (1):
      platform/mellanox: mlxreg-hotplug: Fix uninitialized variable

Vadim Pasternak (6):
      platform/x86: mlx-platform: Use defines for bus assignment
      platform/x86: mlx-platform: Add define for the negative bus
      platform/x86: mlx-platform: Fix power cable setting for msn21xx family
      platform/x86: mlx-platform: Add support for new msn274x system type
      platform/x86: mlx-platform: Add support for new msn201x system type
      platform/x86: mlx-platform: Add support for new 200G IB and
Ethernet systems

 drivers/platform/mellanox/mlxreg-hotplug.c |   2 +-
 drivers/platform/x86/mlx-platform.c        | 372 ++++++++++++++++++++++++++++-
 2 files changed, 363 insertions(+), 11 deletions(-)

-- 
Darren Hart
dvhart@gmail.com
