Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933058AbeCJNt1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 08:49:27 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:49813 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932926AbeCJNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 08:49:26 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w2ADnER9000584
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AG47ELs8ACB3vyV90dHBLmX/6ENibzbBjh5wLiPy4dqrlvQJwVtBZArrqSghybEdp6MxCzGqNsQKeyLaR3Eq6Dixl6I=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 10 Mar 2018 22:48:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNASRLcaegdM8nWwqmw9mVMZvR7nQJTu8YuPya3Hse5z6PA@mail.gmail.com>
Message-ID: <CAK7LNASRLcaegdM8nWwqmw9mVMZvR7nQJTu8YuPya3Hse5z6PA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v4.16-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull more Kbuild fixes for v4.16.



The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v4.16-2

for you to fetch changes up to 55fe6da9efba102866e2fb5b40b04b6a4b26c19e:

  kbuild: Handle builtin dtb file names containing hyphens (2018-03-09
01:14:38 +0900)

----------------------------------------------------------------
Kbuild fixes for v4.16 (2nd)

- make fixdep parse kconfig.h to fix missing rebuild

- replace hyphens with underscores in builtin DTB label names

- fix typos

----------------------------------------------------------------
James Hogan (1):
      kbuild: Handle builtin dtb file names containing hyphens

Matteo Croce (1):
      scripts/bloat-o-meter: fix typos in help

Rasmus Villemoes (3):
      fixdep: remove stale references to uml-config.h
      fixdep: remove some false CONFIG_ matches
      fixdep: do not ignore kconfig.h

 scripts/Makefile.lib   |  8 ++++----
 scripts/basic/fixdep.c | 15 +++++----------
 scripts/bloat-o-meter  |  2 +-
 3 files changed, 10 insertions(+), 15 deletions(-)


-- 
Best Regards
Masahiro Yamada
