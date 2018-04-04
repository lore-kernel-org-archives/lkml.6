Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeDDNaa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:30:30 -0400
Received: from imap.thunk.org ([74.207.234.97]:60400 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbeDDNa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:30:29 -0400
Date: Wed, 4 Apr 2018 09:30:27 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] /dev/random updates for 4.17
Message-ID: <20180404133027.GA15461@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git tags/random_for_linus

for you to fetch changes up to 5e747dd9be54be190dd6ebeebf4a4a01ba765625:

  drivers/char/random.c: remove unused dont_count_entropy (2018-02-28 19:03:19 -0500)

----------------------------------------------------------------
A few random (cough, cough) cleanups for the /dev/random driver

----------------------------------------------------------------
Andi Kleen (1):
      random: optimize add_interrupt_randomness

Jason A. Donenfeld (1):
      random: always fill buffer in get_random_bytes_wait

Rasmus Villemoes (1):
      drivers/char/random.c: remove unused dont_count_entropy

Theodore Ts'o (1):
      random: use a tighter cap in credit_entropy_bits_safe()

 drivers/char/random.c  | 58 ++++++++++++++++++++++++++++------------------------------
 include/linux/random.h |  4 +---
 2 files changed, 29 insertions(+), 33 deletions(-)
