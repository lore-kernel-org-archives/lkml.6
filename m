Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbeCOVUy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:20:54 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51968 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCOVUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:20:52 -0400
Date: Thu, 15 Mar 2018 17:20:49 -0400 (EDT)
Message-Id: <20180315.172049.277308110149944782.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull to get this sparc64 PMD handling regression fix.

Thank you!

The following changes since commit e2c15aff5f353ba80bd3bb49840837f65fa5cc43:

  Merge tag 'sound-4.16-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2018-03-15 11:07:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to cfb61b5e3e09f8b49bc4d685429df75f45127adc:

  sparc64: Fix regression in pmdp_invalidate(). (2018-03-15 14:18:00 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Fix regression in pmdp_invalidate().

 arch/sparc/mm/tlb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
