Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755041AbeEaM3H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:29:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:5061 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754897AbeEaM3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:29:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="45688027"
Date: Thu, 31 May 2018 15:29:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.17-4
Message-ID: <20180531122900.GA23599@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The effective change is just one new condition, which takes 2 LOCs,
though it required to move one static function, that's why diff
statics looks a bit huge.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 54940fa60ad3728c592f62dadb558165495a6938:

  platform/x86: DELL_WMI use depends on instead of select for DELL_SMBIOS (2018-05-18 15:49:26 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.17-4

for you to fetch changes up to 32ffd6e8d1f6cef94bedca15dfcdebdeb590499d:

  platform/x86: asus-wmi: Fix NULL pointer dereference (2018-05-31 15:18:02 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v4.17-4

Fix NULL pointer dereference in asus-wmi on rfkill cleanup.

The following is an automated git shortlog grouped by driver:

asus-wmi:
 -  Fix NULL pointer dereference

----------------------------------------------------------------
João Paulo Rechi Vita (1):
      platform/x86: asus-wmi: Fix NULL pointer dereference

 drivers/platform/x86/asus-wmi.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
With Best Regards,
Andy Shevchenko
