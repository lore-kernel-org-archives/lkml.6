Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeBHKfT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:35:19 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:35981 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHKfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:35:18 -0500
Date: Thu, 8 Feb 2018 11:35:16 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cris-kernel@axis.com
Subject: [GIT PULL] CRIS urgent fixes for 4.16
Message-ID: <20180208103516.GR11498@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the below tag for an urgent fix for build
problems in the CRIS-port.

The following changes since commit e237f98a9c134c3d600353f21e07db915516875b:

  Merge tag 'xfs-4.16-merge-5' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2018-02-05 13:35:56 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jesper/cris.git tags/cris-for-4.16-urgent

for you to fetch changes up to 6e0377212c4e45d7350cff018f6a95633937c031:

  CRIS: Restore mistakenly cleared kernel Makefile (2018-02-08 11:12:10 +0100)

----------------------------------------------------------------
CRIS urgent breakage fix for 4.16

The main Makefile for the CRIS port was
overzealously scrubbed in 4.15-rc3,
breaking the build for all CRIS SoCs.

----------------------------------------------------------------
Jesper Nilsson (1):
      CRIS: Restore mistakenly cleared kernel Makefile

 arch/cris/kernel/Makefile | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
