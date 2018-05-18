Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeEROIy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:08:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39019 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbeEROIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:08:51 -0400
X-Google-Smtp-Source: AB8JxZpgOFtjtTqiisWlhcctKVuzqPtWqyCA4MsLQ2DfIhEYENNq2h0qehK1Q0jNrSP+HgYAp6L9ew==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [GIT PULL 0/1] EFI fix for v4.17
Date: Fri, 18 May 2018 16:08:40 +0200
Message-Id: <20180518140841.9731-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-urgent

for you to fetch changes up to bdad6e217f1e4402bd5809f67b1de39720732604:

  efi/libstub/arm64: handle randomized TEXT_OFFSET (2018-05-14 09:53:24 +0200)

----------------------------------------------------------------
EFI fix for v4.17:
- ensure that arm64 kernels built with CONFIG_RANDOMIZE_TEXT_OFFSET=y appear
  correctly aligned in memory when KASLR is in effect.

----------------------------------------------------------------
Mark Rutland (1):
      efi/libstub/arm64: handle randomized TEXT_OFFSET

 drivers/firmware/efi/libstub/arm64-stub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)
