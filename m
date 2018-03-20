Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeCTV3K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:29:10 -0400
Received: from fieldses.org ([173.255.197.46]:44080 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbeCTV3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:29:06 -0400
Date: Tue, 20 Mar 2018 17:29:06 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>
Subject: [GIT PULL] nfsd bugfix for 4.16
Message-ID: <20180320212906.GD4288@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From: bfields@fieldses.org (J. Bruce Fields)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull an nfsd bugfix from:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-4.16-1

Just one fix for an occasional panic from Jeff Layton.

--b.

----------------------------------------------------------------
Jeff Layton (1):
      nfsd: remove blocked locks on client teardown

 fs/nfsd/nfs4state.c | 62 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 19 deletions(-)
