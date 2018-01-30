Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbeA3TYT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:24:19 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36773 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbeA3TYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:24:15 -0500
X-Google-Smtp-Source: AH8x225m1p1/wnzmgmmCPYdOl+21NAcsplAKNPevCBfZtQCs1ffvnLmkIg57jw55iZWIR62JJ0MuQw==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH v2 00/10] Remove empty help texts from Kconfig files
Date: Tue, 30 Jan 2018 20:22:55 +0100
Message-Id: <20180130192349.8420-1-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Empty help texts are probably either a typo, a Kconfig misunderstanding, or
some kind of half-committing to adding a help text (in which case a TODO
comment would be clearer, if the help text really can't be added right away).
Best to flag them, IMO.

Changes since v1:

Forgot to send the cover letter to linux-kbuild.

Ulf Magnusson (10):
  net/sched: kconfig: Remove empty help texts
  video: fbdev: kconfig: Remove empty help text
  mmc: kconfig: Remove empty help text
  Staging: rtl8192u: kconfig: Remove empty help text
  Staging: rtl8192e: kconfig: Remove empty help text
  lib/Kconfig.debug: Remove empty help text
  MIPS: BCM63XX: kconfig: Remove empty help text
  MIPS: kconfig: Remove empty help text
  arm: vt8500: kconfig: Remove empty help text
  nios2: kconfig: Remove empty help text

 arch/arm/mach-vt8500/Kconfig              | 1 -
 arch/mips/Kconfig                         | 1 -
 arch/mips/bcm63xx/boards/Kconfig          | 1 -
 arch/nios2/Kconfig                        | 1 -
 drivers/mmc/host/Kconfig                  | 1 -
 drivers/staging/rtl8192e/rtl8192e/Kconfig | 1 -
 drivers/staging/rtl8192u/Kconfig          | 1 -
 drivers/video/fbdev/Kconfig               | 1 -
 lib/Kconfig.debug                         | 1 -
 net/sched/Kconfig                         | 3 ---
 10 files changed, 12 deletions(-)

-- 
2.14.1
