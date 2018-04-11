Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbeDKPTj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:19:39 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37929 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753108AbeDKPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:19:38 -0400
X-Google-Smtp-Source: AIpwx4+gwiBRaYK/LKBC//0lWTFOx39b8+Uye8z0tubTjb+vB2f2VyQdDgMwO1RbAy8+x9KN1CqNPNjpuhMKxNROQII=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Apr 2018 17:19:37 +0200
X-Google-Sender-Auth: jHkIeR4S3Bg1fFjNhcOCgEgzZIQ
Message-ID: <CAK8P3a0ibBNw14DfgqXJqmH8QgtEdZ5spLnFRLh2bU7uoMHoSw@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 38c23685b273cfb4ccf31a199feccce3bdcb5d83:

  Merge tag 'armsoc-drivers' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-04-05
21:29:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes

for you to fetch changes up to cb799267bb65676277fb718cfb42239fe5c6e4fb:

  MAINTAINERS: Update ASPEED entry with details (2018-04-11 10:47:31 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.17

Here is a very small set of fixes for inclusion in linux-4.17-rc1:
Two changes for the maintainer file, and one more fix for the newly
added npcm platform, to enable the level 2 cache controller.

----------------------------------------------------------------
Joel Stanley (1):
      MAINTAINERS: Update ASPEED entry with details

Neil Armstrong (1):
      MAINTAINERS: Migrate oxnas list to groups.io

Tomer Maimon (1):
      arm: npcm: enable L2 cache in NPCM7xx architecture

 MAINTAINERS                  | 11 ++++++++---
 arch/arm/mach-npcm/npcm7xx.c |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)
