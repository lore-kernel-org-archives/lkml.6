Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031884AbeBNPy2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:54:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031649AbeBNPy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:54:27 -0500
Date: Wed, 14 Feb 2018 10:54:27 -0500 (EST)
From: Bob Peterson <rpeterso@redhat.com>
To: torvalds@linux-foundation.org
Cc: cluster-devel <cluster-devel@redhat.com>, linux-kernel@vger.kernel.org
Message-ID: <288537760.3443740.1518623667302.JavaMail.zimbra@redhat.com>
In-Reply-To: <342220385.3443644.1518623642953.JavaMail.zimbra@redhat.com>
Subject: GFS2: Please pull patch tagged gfs2-4.16.rc1.fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.149, 10.4.195.2]
Thread-Topic: GFS2: Please pull patch tagged gfs2-4.16.rc1.fixes
Thread-Index: 2tOQeIxq9BfatuwQyhPs2zC3jABUhA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Would you please pull this one-off patch from Andreas Gruenbacher
that fixes a GFS2 regression? Thanks.

Bob Peterson
---
The following changes since commit 35277995e17919ab838beae765f440674e8576eb:

  Merge branch 'x86-pti-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2018-02-04 11:45:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-4.16.rc1.fixes

for you to fetch changes up to 49edd5bf429c405b3a7f75503845d9f66a47dd4b:

  gfs2: Fixes to "Implement iomap for block_map" (2018-02-13 13:38:10 -0700)

----------------------------------------------------------------
Fix regressions in patch Implement iomap for block_map

This tag is meant for pulling a patch called gfs2: Fixes to
"Implement iomap for block_map". The patch fixes some
regressions we recently discovered in commit 3974320ca6.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Fixes to "Implement iomap for block_map"

 fs/gfs2/bmap.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)
