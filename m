Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbeCIRxo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:53:44 -0500
Received: from ms.lwn.net ([45.79.88.28]:50158 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751325AbeCIRxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:53:43 -0500
Date: Fri, 9 Mar 2018 10:53:41 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [PULL] Documentation build fix
Message-ID: <20180309105341.4700dc4a@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
e67548254b86a4a6e1b493f041bb7fe28ee74249:

  Merge tag 'mips_fixes_4.16_4' of git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips (2018-03-08 10:03:12 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-4.16-fix

for you to fetch changes up to ff690eeed804f112242f9a0614eafdf559f9276a:

  Documentation/sphinx: Fix Directive import error (2018-03-09 10:46:14 -0700)

----------------------------------------------------------------
The Sphinx 1.7 release broke the build process for reasons that are mostly
our fault.  This is a single fix, cherry-picked from docs-next (where it
has been for a few days now), that restores docs buildability for all
supported Sphinx versions.

----------------------------------------------------------------
Matthew Wilcox (1):
      Documentation/sphinx: Fix Directive import error

 Documentation/sphinx/kerneldoc.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
