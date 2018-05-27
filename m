Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936286AbeE0IxM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 04:53:12 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23315 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeE0IxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 04:53:10 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w4R8qoAm010965
X-Nifty-SrcIP: [209.85.213.52]
X-Google-Smtp-Source: ADUXVKLPX/nPKGfnY9+2yqkIyfUD7Feqjl1omGgxwURPhED54tMiDHqgs72e0bCDQtwRChddhxITOirMbbFWiF4ehms=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 27 May 2018 17:52:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNASasVNYmXu3tgLaG7rePhvKJ1exMjQ0iBjVRwKUMWYNYg@mail.gmail.com>
Message-ID: <CAK7LNASasVNYmXu3tgLaG7rePhvKJ1exMjQ0iBjVRwKUMWYNYg@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v4.17-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


Please pull a little more Kbuild fixes for v4.17
Thanks.



The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v4.17-2

for you to fetch changes up to 8438ee76b004ef66d125ade64c91fc128047d244:

  Makefile: disable PIE before testing asm goto (2018-05-17 22:36:40 +0900)

----------------------------------------------------------------
Kbuild fixes for v4.17 (2nd)

- enable -fno-tree-loop-im only when supported

- add -fno-PIE option before the asm-goto test

----------------------------------------------------------------
Michal Kubecek (1):
      Makefile: disable PIE before testing asm goto

Nick Desaulniers (1):
      kbuild: gcov: enable -fno-tree-loop-im if supported

 Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
Best Regards
Masahiro Yamada
