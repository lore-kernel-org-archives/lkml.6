Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeDLSxt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:53:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752912AbeDLSxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:53:48 -0400
Date: Thu, 12 Apr 2018 14:53:48 -0400 (EDT)
From: Bob Peterson <rpeterso@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: cluster-devel <cluster-devel@redhat.com>, linux-kernel@vger.kernel.org
Message-ID: <221420024.18959486.1523559228057.JavaMail.zimbra@redhat.com>
In-Reply-To: <1349891308.18959471.1523559205878.JavaMail.zimbra@redhat.com>
Subject: GFS2: Pull request #2 (merge window)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.80, 10.4.195.4]
Thread-Topic: GFS2: Pull request #2 (merge window)
Thread-Index: of9oy68pBfu8lG7pWUGDhKVeC3g+5g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling the following additional 3 patches for the GFS2
file system.

Regards,

Bob Peterson
----------------------------------------------------------------
The following changes since commit e241e3f2bf975788a1b70dff2eb5180ca395b28e:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2018-04-11 18:58:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-4.17.fixes2

for you to fetch changes up to 3e7aafc39c59c639ebd5961f893743f076df9b4e:

  GFS2: Minor improvements to comments and documentation (2018-04-12 10:07:51 -0700)

----------------------------------------------------------------
We decided to request the latest three patches to be merged into this
merge window while it's still open.

1. The first patch adds a new function to lockref: lockref_put_not_zero
2. The second patch fixes GFS2's glock dump code so it uses the new lockref
   function. This fixes a problem whereby lock dumps could miss glocks.
3. I made a minor patch to update some comments and fix the lock ordering
   text in our gfs2-glocks.txt Documentation file.

----------------------------------------------------------------
Andreas Gruenbacher (2):
      lockref: Add lockref_put_not_zero
      gfs2: Stop using rhashtable_walk_peek

Bob Peterson (1):
      GFS2: Minor improvements to comments and documentation

 Documentation/filesystems/gfs2-glocks.txt |  5 ++--
 fs/gfs2/bmap.c                            |  2 +-
 fs/gfs2/glock.c                           | 47 ++++++++++++++++++-------------
 fs/gfs2/ops_fstype.c                      |  2 +-
 include/linux/lockref.h                   |  1 +
 lib/lockref.c                             | 28 ++++++++++++++++++
 6 files changed, 62 insertions(+), 23 deletions(-)
