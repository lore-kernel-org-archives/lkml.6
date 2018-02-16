Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756348AbeBPPh7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:37:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:38436 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756320AbeBPPh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:37:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="18687440"
Date: Fri, 16 Feb 2018 17:37:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.16-4
Message-ID: <20180216153755.GA32624@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Couple of regressions were found, so, this PR to fix them.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.16-4

for you to fetch changes up to c8ba9db2a790c0fcf2f6c4cafd45ff3a0751800e:

  platform/x86: dell-laptop: Removed duplicates in DMI whitelist (2018-02-15 12:18:33 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v4.16-4

Regression fix in keyboard support for Dell laptops.
Prevent out-of-boundary write in WMI bus driver.
Increase timeout to read functional key status on Lenovo laptops.

The following is an automated git shortlog grouped by driver:

dell-laptop:
 -  Removed duplicates in DMI whitelist
 -  fix kbd_get_state's request value

ideapad-laptop:
 -  Increase timeout to wait for EC answer

wmi:
 -  fix off-by-one write in wmi_dev_probe()

----------------------------------------------------------------
Aaron Ma (1):
      platform/x86: ideapad-laptop: Increase timeout to wait for EC answer

Alexander Abrosimov (1):
      platform/x86: dell-laptop: Removed duplicates in DMI whitelist

Andrey Ryabinin (1):
      platform/x86: wmi: fix off-by-one write in wmi_dev_probe()

Laszlo Toth (1):
      platform/x86: dell-laptop: fix kbd_get_state's request value

 drivers/platform/x86/dell-laptop.c    | 20 +-------------------
 drivers/platform/x86/ideapad-laptop.c |  2 +-
 drivers/platform/x86/wmi.c            |  2 +-
 3 files changed, 3 insertions(+), 21 deletions(-)

-- 
With Best Regards,
Andy Shevchenko
