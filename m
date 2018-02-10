Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeBJBTB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:19:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40080 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBJBTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:19:00 -0500
Date: Sat, 10 Feb 2018 01:18:59 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] a couple of fixes
Message-ID: <20180210011859.GL30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit ce4bb04cae8924792ed92f4af2793b77fc986f0e:

  Fix a leak in socket(2) when we fail to allocate a file descriptor. (2018-01-10 18:47:05 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-linus

for you to fetch changes up to cf5eebae2cd28d37581507668605f4d23cd7218d:

  seq_file: fix incomplete reset on read from zero offset (2018-01-20 02:31:15 -0500)

----------------------------------------------------------------
Ivan Vecera (1):
      kernfs: fix regression in kernfs_fop_write caused by wrong type

Miklos Szeredi (1):
      seq_file: fix incomplete reset on read from zero offset

 fs/kernfs/file.c | 2 +-
 fs/seq_file.c    | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)
