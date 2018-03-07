Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934019AbeCGS5d (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:57:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933412AbeCGS5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:57:30 -0500
Date: Wed, 7 Mar 2018 13:57:30 -0500 (EST)
From: Bob Peterson <rpeterso@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: cluster-devel <cluster-devel@redhat.com>, linux-kernel@vger.kernel.org
Message-ID: <2025527149.8721623.1520449050095.JavaMail.zimbra@redhat.com>
In-Reply-To: <1529461804.8721434.1520448985116.JavaMail.zimbra@redhat.com>
Subject: GFS2: Please pull patch tagged gfs2-4.16.rc4.fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.236, 10.4.195.13]
Thread-Topic: GFS2: Please pull patch tagged gfs2-4.16.rc4.fixes
Thread-Index: yGIt7v0Gxz/Z8EZ5LNlibStYhVJFZA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Would you please pull this additional patch from Andreas Gruenbacher
that fixes another unfortunate GFS2 regression? Thanks.

Bob Peterson
---
The following changes since commit 86f84779d8e92a690b2f281175ea06b884cb6fa4:

  Merge branch 'siginfo-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace (2018-03-06 12:41:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-4.16.rc4.fixes

for you to fetch changes up to 3b5da96e4585a2788da6a07619bda3518d76eb30:

  gfs2: Fixes to "Implement iomap for block_map" (2) (2018-03-07 11:40:38 -0700)

----------------------------------------------------------------
This tag is meant for pulling a patch called
gfs2: Fixes to "Implement iomap for block_map" (2).
The patch fixes a regression we discovered in commit 49edd5bf42.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Fixes to "Implement iomap for block_map" (2)

 fs/gfs2/bmap.c | 3 ---
 1 file changed, 3 deletions(-)
