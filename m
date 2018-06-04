Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753700AbeFDPRo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:17:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:54185 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752543AbeFDPRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:17:43 -0400
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS fix for 4.18
Date: Mon,  4 Jun 2018 17:14:53 +0200
Message-Id: <cover.1528121408.git.dsterba@suse.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's one potential memory leak fix for AFFS. I'm using my main k.org
tree for that.

The branch is based on some random pre-rc7 commit I had in master and
forgot to rebase it on top of rc7 in time. Functionally it should not
matter, but I guess you'd notice.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit b50694381cfc22dce3a60a291cdae294a5e5777c:

  Merge branch 'stable/for-linus-4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb (2018-05-24 14:42:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-4.18-tag

for you to fetch changes up to 84ae6f829fc2b23dd4985ab059cddfd4a1ccc14f:

  affs: fix potential memory leak when parsing option 'prefix' (2018-05-28 12:36:41 +0200)

----------------------------------------------------------------
Chengguang Xu (1):
      affs: fix potential memory leak when parsing option 'prefix'

 fs/affs/super.c | 1 +
 1 file changed, 1 insertion(+)
