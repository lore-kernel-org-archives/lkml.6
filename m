Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeBZMlx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:41:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:11739 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752949AbeBZMlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:41:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="23206143"
Date: Mon, 26 Feb 2018 14:41:44 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: jmorris@namei.org
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [GIT PULL] tpmdd fixes for 4.16
Message-ID: <20180226124144.GA8675@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a batch of critical fixes for 4.16.

/Jarkko

The following changes since commit a02633e9b13dcb9b1a656b08f81bc8ba2d4d2294:

  Merge tag 'v4.16-rc2' into next-general (2018-02-21 08:21:41 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180226

for you to fetch changes up to 895fbcaba75da05f6337ffaf750778c3a8ee9158:

  tpm_tis: fix potential buffer overruns caused by bit glitches on the bus (2018-02-26 14:33:57 +0200)

----------------------------------------------------------------
tpmdd fixes for Linux 4.16

----------------------------------------------------------------
Jeremy Boone (5):
      tpm: fix potential buffer overruns caused by bit glitches on the bus
      tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus
      tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus
      tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus
      tpm_tis: fix potential buffer overruns caused by bit glitches on the bus

 drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
 drivers/char/tpm/tpm-interface.c     | 4 ++++
 drivers/char/tpm/tpm2-cmd.c          | 4 ++++
 drivers/char/tpm/tpm_i2c_infineon.c  | 5 +++--
 drivers/char/tpm/tpm_i2c_nuvoton.c   | 8 ++++++--
 drivers/char/tpm/tpm_tis_core.c      | 5 +++--
 6 files changed, 22 insertions(+), 8 deletions(-)
