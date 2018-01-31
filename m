Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbeAaJfP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:35:15 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:38787 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeAaJfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:35:12 -0500
X-Google-Smtp-Source: AH8x224+xXz1Npex+vWYcfHbSjyapBCKbDQNakagPPRAW1nxd0ChBw2ti6wyphdQy0OTT6OwpJlJOw==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, rdunlap@infradead.org, dan.carpenter@oracle.com,
        pebolle@tiscali.nl, Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH 00/11] Remove blank help texts from Kconfig files and add warning
Date: Wed, 31 Jan 2018 10:34:19 +0100
Message-Id: <20180131093434.20050-1-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset first removes all blank help texts from Kconfig files for all
arches, and then makes Kconfig print a warning for blank help texts.

All patches can be applied independently, but to avoid warning spam, the blank
help texts ought to be removed before the warning is added.

Ulf Magnusson (11):
  net/sched: kconfig: Remove blank help texts
  video: fbdev: kconfig: Remove blank help text
  mmc: kconfig: Remove blank help text
  Staging: rtl8192u: kconfig: Remove blank help text
  Staging: rtl8192e: kconfig: Remove blank help text
  lib/Kconfig.debug: Remove blank help text
  MIPS: BCM63XX: kconfig: Remove blank help text
  MIPS: kconfig: Remove blank help text
  arm: vt8500: kconfig: Remove blank help text
  nios2: kconfig: Remove blank help text
  kconfig: Warn if help text is blank

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
 scripts/kconfig/zconf.y                   | 6 ++++++
 11 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.14.1
