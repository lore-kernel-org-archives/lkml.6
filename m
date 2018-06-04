Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeFDBCQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:02:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43192 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbeFDBCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:02:15 -0400
Date: Mon, 4 Jun 2018 02:02:13 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs, pile 2
Message-ID: <20180604010213.GE30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	More shrink_dcache_parent()-related stuff - killing the main
source of potentially contended calls of that on large subtrees.

The following changes since commit 4faa99965e027cc057c5145ce45fa772caa04e8d:

  fix io_destroy()/aio_complete() race (2018-05-23 22:53:22 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.rmdir

for you to fetch changes up to 8767712f26d18ac4541e2d0d7be17c40a5911ce4:

  rmdir(),rename(): do shrink_dcache_parent() only on success (2018-05-27 16:23:51 -0400)

----------------------------------------------------------------
Al Viro (1):
      rmdir(),rename(): do shrink_dcache_parent() only on success

 fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
