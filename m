Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeBBPrl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:47:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752220AbeBBPrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:47:31 -0500
Date: Fri, 2 Feb 2018 10:47:30 -0500 (EST)
From: Bob Peterson <rpeterso@redhat.com>
To: torvalds@linux-foundation.org
Cc: cluster-devel <cluster-devel@redhat.com>, linux-kernel@vger.kernel.org
Message-ID: <2018618406.6385867.1517586450779.JavaMail.zimbra@redhat.com>
In-Reply-To: <1118826781.6385862.1517586443478.JavaMail.zimbra@redhat.com>
Subject: GFS2: Second Pull request (merge window)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.38, 10.4.195.13]
Thread-Topic: GFS2: Second Pull request (merge window)
Thread-Index: STlFXKE6x1OpyIIuuBG/wT1rkFP58w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry to bother you with a second merge request for GFS2, but we found
a couple regressions and want to get them fixed in this merge window.

Please consider pulling the following changes for the GFS2 file system.

Regards,

Bob Peterson
----------------------------------------------------------------
The following changes since commit 255442c93843f52b6891b21d0b485bf2c97f93c3:

  Merge tag 'docs-4.16' of git://git.lwn.net/linux (2018-01-31 19:25:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-4.16.fixes2

for you to fetch changes up to 7ac07fdaf840f9b141c6d5c286805107227c0e68:

  gfs2: Glock dump performance regression fix (2018-02-01 11:27:11 -0700)

----------------------------------------------------------------
Andreas Gruenbacher wrote two additional patches that we would like
merged in this time. Both are regressions:

1. The first fixes another kernel build dependency problem.
2. The second fixes a performance regression in glock dumps.

----------------------------------------------------------------
Andreas Gruenbacher (2):
      gfs2: Fix the crc32c dependency
      gfs2: Glock dump performance regression fix

 fs/gfs2/Kconfig |  3 +--
 fs/gfs2/glock.c | 65 ++++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 44 insertions(+), 24 deletions(-)
