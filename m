Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753621AbeDZGhe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:37:34 -0400
Received: from imap.thunk.org ([74.207.234.97]:60562 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753081AbeDZGhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:37:33 -0400
Date: Thu, 26 Apr 2018 02:37:31 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [GIT PULL] /dev/random fixes for 4.17-rc3
Message-ID: <20180426063731.GA8280@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d848e5f8e1ebdb227d045db55fe4f825e82965fa:

  random: add new ioctl RNDRESEEDCRNG (2018-04-14 11:59:31 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git tags/random_for_linus_stable

for you to fetch changes up to 4e00b339e264802851aff8e73cde7d24b57b18ce:

  random: rate limit unseeded randomness warnings (2018-04-25 02:41:39 -0400)

----------------------------------------------------------------
Fix a regression on NUMA kernels and suppress excess unseeded entropy
pool warnings.

----------------------------------------------------------------
Theodore Ts'o (2):
      random: fix possible sleeping allocation from irq context
      random: rate limit unseeded randomness warnings

 drivers/char/random.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)
