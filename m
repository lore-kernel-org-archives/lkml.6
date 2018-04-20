Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbeDTS1d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:27:33 -0400
Received: from www.linux-watchdog.org ([185.87.125.42]:56062 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753678AbeDTS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:27:32 -0400
Date: Fri, 20 Apr 2018 20:14:24 +0200
From: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [GIT PULL REQUEST] watchdog - v4.17-rc2 patches
Message-ID: <20180420181424.GA19456@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following watchdog changes for the v4.17 release cycle.

This series contains:
- fall-through fixes
- MAINTAINER change for hpwdt
- renesas-wdt: Add support for WDIOF_CARDRESET
- aspeed: set bootstatus during probe

The output from git request-pull:
----------------------------------------------------------------

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-4.17-rc2

for you to fetch changes up to 49d4d277ca54e04170d39484c8758a0ea9bca37d:

  aspeed: watchdog: Set bootstatus during probe (2018-04-16 10:22:40 +0200)

----------------------------------------------------------------
linux-watchdog 4.17-rc2 tag

----------------------------------------------------------------
Eddie James (1):
      aspeed: watchdog: Set bootstatus during probe

Gustavo A. R. Silva (3):
      watchdog: sch311x_wdt: Mark expected switch fall-through
      watchdog: w83977f_wdt: Mark expected switch fall-through
      watchdog: wafer5823wdt: Mark expected switch fall-through

Jerry Hoemann (1):
      watchdog: hpwdt: change maintainer.

Veeraiyan Chidambaram (1):
      watchdog: renesas-wdt: Add support for WDIOF_CARDRESET

 MAINTAINERS                     | 2 +-
 drivers/watchdog/aspeed_wdt.c   | 7 +++++++
 drivers/watchdog/renesas_wdt.c  | 6 ++++--
 drivers/watchdog/sch311x_wdt.c  | 2 +-
 drivers/watchdog/w83977f_wdt.c  | 2 +-
 drivers/watchdog/wafer5823wdt.c | 2 +-
 6 files changed, 15 insertions(+), 6 deletions(-)
----------------------------------------------------------------

Kind regards,
Wim.
