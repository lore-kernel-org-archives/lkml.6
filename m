Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeCMOJt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:09:49 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38802 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeCMOJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:09:47 -0400
X-Google-Smtp-Source: AG47ELv0rOE/Ms0XpMTXCMQlzePdHflyhKkKKZlMDTvx+NSFiNaRYcM5/Uk57bGiMQh36Rcz1H89Yw==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: hdegoede@redhat.com, tweek@google.com, javierm@redhat.com,
        jarkko.sakkinen@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>
Subject: [GIT PULL 0/1] EFI fix for v4.16
Date: Tue, 13 Mar 2018 14:09:20 +0000
Message-Id: <20180313140922.17266-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 5c4d724b7ccfa934b95c5c49fab770035a425950:

  efi/libstub: tpm: zero initialize pointer variables for mixed mode (2018-03-13 13:48:25 +0000)

----------------------------------------------------------------
EFI fix for v4.16:
- fix an issue in the mixed mode handling of the new TPM libstub code

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/libstub: tpm: zero initialize pointer variables for mixed mode

 drivers/firmware/efi/libstub/tpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
