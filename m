Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbeAaVSM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:18:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37132 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeAaVSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:18:11 -0500
Date: Wed, 31 Jan 2018 21:18:09 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] Neil's d_move()/d_path() race fix
Message-ID: <20180131211809.GB30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit f1ee616214cb22410e939d963bbb2349c2570f02:

  VFS: don't keep disconnected dentries on d_anon (2017-12-25 20:22:07 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache

for you to fetch changes up to 61647823aa920e395afcce4b57c32afb51456cab:

  VFS: close race between getcwd() and d_move() (2017-12-28 14:12:09 -0500)

----------------------------------------------------------------
NeilBrown (1):
      VFS: close race between getcwd() and d_move()

 fs/dcache.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)
