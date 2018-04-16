Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeDPUwm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 16:52:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:60973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbeDPUwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 16:52:19 -0400
Date: Mon, 16 Apr 2018 22:52:09 +0200
From: Helge Deller <deller@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc trivial build fix for 4.17
Message-ID: <20180416205209.GA12361@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:e5Ojzj1JF1nCMap6xxoTruE6xyg0EPu6lGkqsc1e6u8KtBw+48l
 Uo4Ep7YBqtQAtIiol7XpuBPJHN5IlZ5QNumLl8Sp9dDiFrtGKgpzPFeOI2cqugckbKBukxM
 qKCfbQ7w8OpAE+d1am7uKIJWDiBlmCOzWWEoY2GNDZrGymxsZ/YuZ9eLVbXPw14XpOmSyUD
 cO2SbtQf9fMmjR27rswAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ge1eFTEZI44=:g8gLPbu6+hUmXVVLb00ykQ
 YWBd/IuitO8A/dpzQqP7ccDDsufhQ4R8ppGeslAZ40zdwU9i2w+T49XSxr5JaZdDmgl/Zc77i
 feJj3bzZ8bXZNAvzADoXqavtH3qtrmu9EJrlFaUSvw2o3rCApyoeRydMcXjpcpsti967yUZfJ
 WwSEBOEw3kuDesndIXjiPSEAazJ0vmB2+UOeEuO+mp0XT9xDn/OGplHCo7pU52ybKim3Qy56E
 ZbuY2wky7+XUEXihTQnei7l2h7JXI2qBtrTTfUvTBlpsKx6t1fVaBKTngGhvGYPOTbW/q7ioO
 dbdXmMyL0Pl4tKpiQFEo2SSiN4IcuqdHjYSnq8utRBvLJEQgwomNe7gvJLPcGWv5lEtQxcPuQ
 82HzZ+ipst/UcO6+ywnBLvoPlvoBdy3/X32WcB+qA1nlAcy54frbbcjTYCk8R7Yl+RiKBZ8KM
 /9t6K7/Y/xbUMqzeK0WsTHVHm2WjXgXheizyCgRpulMvBOtntDO4X72qAcVg1PPmSP79ssQgr
 ElOJfWEp2S2O+kuelI6gVzJ0gQhjvgN30g0klc78HUf8CAZ8rXHTYoqgHQ9IfCPUExGh1/VAk
 xOm2g6J8kFa90FuYIyFh9gLVVPE5bIH0t/KtrDnseI2tCGQsjRXs/nwsiPYXliTNVnDUljpNx
 XvcLFCIrzMmnevv74nRCqq14IlRGcVeisFDOQMGCIx3RGIj7gJhbEX7/QuKdXXGazce/tdMvb
 +XgaqmME2OjCtp7+oxZUyPD8Vih3W3YUSRD2oYUxNRE8Fg0uB+KjvYrskxDne+oc84HH+gSZR
 hYSyvsWcatxRZbUOk75YtFImE/HaA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a trivial one-line build fix for the parisc architecture from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.17-3

* Fix build error because of missing binfmt_elf32.o file which is still
  mentioned in the Makefile.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (1):
      parisc: Fix missing binfmt_elf32.o build error

 arch/parisc/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
