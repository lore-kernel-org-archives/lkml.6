Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeBZXsr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:48:47 -0500
Received: from namei.org ([65.99.196.166]:50722 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751351AbeBZXsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:48:45 -0500
Date: Tue, 27 Feb 2018 10:48:41 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [GIT PULL] TPM: Bug fixes
Message-ID: <alpine.LRH.2.21.1802271046100.9820@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these bugfixes for TPM, from Jeremy Boone, via Jarkko 
Sakkinen.


The following changes since commit 4c3579f6cadd5eb8250a36e789e6df66f660237a:

  Merge tag 'edac_fixes_for_4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp (2018-02-26 10:19:15 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.16-rc4

for you to fetch changes up to 3be23274755ee85771270a23af7691dc9b3a95db:

  tpm: fix potential buffer overruns caused by bit glitches on the bus (2018-02-26 15:43:46 -0800)

----------------------------------------------------------------
Jeremy Boone (5):
      tpm_tis: fix potential buffer overruns caused by bit glitches on the bus
      tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus
      tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus
      tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus
      tpm: fix potential buffer overruns caused by bit glitches on the bus

 drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
 drivers/char/tpm/tpm-interface.c     | 4 ++++
 drivers/char/tpm/tpm2-cmd.c          | 4 ++++
 drivers/char/tpm/tpm_i2c_infineon.c  | 5 +++--
 drivers/char/tpm/tpm_i2c_nuvoton.c   | 8 ++++++--
 drivers/char/tpm/tpm_tis_core.c      | 5 +++--
 6 files changed, 22 insertions(+), 8 deletions(-)
