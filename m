Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeCJKzD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 05:55:03 -0500
Received: from www.linux-watchdog.org ([185.87.125.42]:55592 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeCJKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 05:55:01 -0500
Date: Sat, 10 Mar 2018 11:44:09 +0100
From: wim@www.linux-watchdog.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Igor Pylypiv <igor.pylypiv@gmail.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [GIT PULL REQUEST] watchdog - v4.16 Fixes 2
Message-ID: <20180310104409.GA3963@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the watchdog fixes for the v4.16 release cycle.

This series contains:
* f71808e_wdt: Fix magic close handling
* sbsa: 32-bit read fix for WCV
* hpwdt: Remove legacy NMI sourcing

The output from git request-pull:
----------------------------------------------------------------

The following changes since commit a17f4f032b61abd998a1f81b206a4517e2e3db2f:

  watchdog: sp5100_tco.c: fix potential build failure (2018-02-19 17:44:05 +0100)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-4.16-fixes-2

for you to fetch changes up to 2b3d89b402b085b08498e896c65267a145bed486:

  watchdog: hpwdt: Remove legacy NMI sourcing. (2018-03-03 15:52:33 +0100)

----------------------------------------------------------------
linux-watchdog 4.16-fixes-2 merge window tag

----------------------------------------------------------------
Igor Pylypiv (1):
      watchdog: f71808e_wdt: Fix magic close handling

Jayachandran C (1):
      watchdog: sbsa: use 32-bit read for WCV

Jerry Hoemann (1):
      watchdog: hpwdt: Remove legacy NMI sourcing.

 drivers/watchdog/f71808e_wdt.c |   3 +-
 drivers/watchdog/hpwdt.c       | 501 +----------------------------------------
 drivers/watchdog/sbsa_gwdt.c   |   3 +-
 3 files changed, 13 insertions(+), 494 deletions(-)
