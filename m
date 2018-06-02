Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeFBNAJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 09:00:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:22044 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbeFBNAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 09:00:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,469,1520924400";
   d="scan'208";a="54219193"
Date: Sat, 2 Jun 2018 16:00:01 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: jmorris@namei.org
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] tpmdd 4.17 fixes
Message-ID: <20180602130001.GA5196@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 424eaf910c329ab06ad03a527ef45dcf6a328f00:

  tpm: reduce polling time to usecs for even finer granularity (2018-05-18 10:00:01 +0300)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180602

for you to fetch changes up to 3ab2011ea368ec3433ad49e1b9e1c7b70d2e65df:

  tpm: fix race condition in tpm_common_write() (2018-05-30 20:11:31 +0300)

----------------------------------------------------------------
tpmdd fixes for Linux 4.17

----------------------------------------------------------------
Tadeusz Struk (1):
      tpm: fix race condition in tpm_common_write()

 drivers/char/tpm/tpm-dev-common.c | 40 ++++++++++++++++++---------------------
 drivers/char/tpm/tpm-dev.h        |  2 +-
 2 files changed, 19 insertions(+), 23 deletions(-)
