Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeERXgS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 19:36:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbeERXgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 19:36:15 -0400
Date: Fri, 18 May 2018 16:36:12 -0700
From: Darren Hart <dvhart@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.17-3
Message-ID: <20180518233612.GA17384@fury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

DELL_WMI had a lingering "select DELL_SMBIOS" leading to possible
misconfiguration. This removes the last of the "select DELL_SMBIOS"
lines in the Kconfig.

Obviously this has been an unacceptable sequence of failures. I will be
adding some contextual fuzz testing for this Kconfig to try and catch
more of this - and of course I've learned a few things to look out for
as well.

Thanks,

Darren Hart
VMware Open Source Technology Center

The following changes since commit 7fe3fa3b5ec8e75389cce4bf5d052a52e6198d59:

  platform/x86: Kconfig: Fix dell-laptop dependency chain. (2018-05-04 22:20:14 +0200)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.17-3

for you to fetch changes up to 54940fa60ad3728c592f62dadb558165495a6938:

  platform/x86: DELL_WMI use depends on instead of select for DELL_SMBIOS (2018-05-18 15:49:26 -0700)

----------------------------------------------------------------
platform-drivers-x86 for v4.17-3

Remove the last of the "select DELL_SMBIOS" references in the Kconfig.

The following is an automated git shortlog:

DELL_WMI use depends on instead of select for DELL_SMBIOS

----------------------------------------------------------------
Darren Hart (1):
      platform/x86: DELL_WMI use depends on instead of select for DELL_SMBIOS

 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Darren Hart
VMware Open Source Technology Center
