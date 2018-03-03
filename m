Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932078AbeCCJiu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 04:38:50 -0500
Received: from www.linux-watchdog.org ([185.87.125.42]:55476 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeCCJit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 04:38:49 -0500
Date: Sat, 3 Mar 2018 10:22:02 +0100
From: wim@www.linux-watchdog.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        Matteo Croce <mcroce@redhat.com>, Radu Rendec <radu.rendec@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [GIT PULL REQUEST] watchdog - v4.16 Fixes
Message-ID: <20180303092202.GA29051@www.linux-watchdog.org>
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
* rave-sp: add NVMEM dependency
* Build fixes for i6300esb_wdt, xen_wdt and sp5100_tco

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-4.16-fixes-1

for you to fetch changes up to a17f4f032b61abd998a1f81b206a4517e2e3db2f:

  watchdog: sp5100_tco.c: fix potential build failure (2018-02-19 17:44:05 +0100)

----------------------------------------------------------------
linux-watchdog 4.16-fixes-1 merge window tag

----------------------------------------------------------------
Arnd Bergmann (1):
      watchdog: rave-sp: add NVMEM dependency

Matteo Croce (1):
      watchdog: i6300esb: fix build failure

Radu Rendec (1):
      watchdog: xen_wdt: fix potential build failure

Wim Van Sebroeck (1):
      watchdog: sp5100_tco.c: fix potential build failure

 drivers/watchdog/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)
