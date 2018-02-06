Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeBFXfU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 18:35:20 -0500
Received: from ms.lwn.net ([45.79.88.28]:37296 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754091AbeBFXfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 18:35:17 -0500
Date: Tue, 6 Feb 2018 16:35:14 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [PULL] A few more documentation changes for 4.16
Message-ID: <20180206163514.685a7cf5@lwn.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
255442c93843f52b6891b21d0b485bf2c97f93c3:

  Merge tag 'docs-4.16' of git://git.lwn.net/linux (2018-01-31 19:25:25 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-4.16-2

for you to fetch changes up to 78ed78451963d1a4282bcda92059fdf2a7821401:

  Documentation/process: tweak pgp maintainer guide (2018-02-06 16:31:56 -0700)

----------------------------------------------------------------
A few late-arriving fixes, along with Konstantin's PGP document that had
no reason to wait another cycle.

----------------------------------------------------------------
Corentin Labbe (1):
      Documentation: mips: Update AU1xxx_IDE Kconfig dependencies

Grigory Shipunov (1):
      Fix broken link in Documentation/process/kernel-docs.rst

Konstantin Ryabitsev (2):
      Documentation/process: kernel maintainer PGP guide
      Documentation/process: tweak pgp maintainer guide

Randy Dunlap (1):
      Documentation/admin-guide: fixes for thunderbolt.rst

 Documentation/admin-guide/thunderbolt.rst      |  66 +-
 Documentation/mips/AU1xxx_IDE.README           |   7 -
 Documentation/process/index.rst                |   1 +
 Documentation/process/kernel-docs.rst          |   2 +-
 Documentation/process/maintainer-pgp-guide.rst | 929 +++++++++++++++++++++++++
 5 files changed, 964 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/process/maintainer-pgp-guide.rst
