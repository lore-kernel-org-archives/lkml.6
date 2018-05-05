Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEECCs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 22:02:48 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:60227 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751954AbeEECCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 22:02:46 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4522QIF019189
X-Nifty-SrcIP: [209.85.217.181]
X-Google-Smtp-Source: AB8JxZqkjirbVNncPt8LOyAaWlbMEv7AwwMBY/FiymYOJXdEZFzAn09LEjXCBK/sEhesuO/ey8JBK8NAvtgd9NmXGmE=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 5 May 2018 11:01:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQeiRH=E59tEgZD8zQDLLGyrpf30DqyRZOQruwDWJc3QA@mail.gmail.com>
Message-ID: <CAK7LNAQeiRH=E59tEgZD8zQDLLGyrpf30DqyRZOQruwDWJc3QA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for 4.17-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some Kbuild fixes.
Thanks!


The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v4.17

for you to fetch changes up to 0da7e43261142b93307b70da455376ad84414d0a:

  genksyms: fix typo in parse.tab.{c,h} generation rules (2018-05-05
10:24:53 +0900)

----------------------------------------------------------------
Kbuild fixes for v4.17

- remove state comment in modpost

- extend MAINTAINERS entry to cover modpost and more makefiles

- fix missed building of SANCOV gcc-plugin

- replace left-over 'bison' with $(YACC)

- display short log when generating parer of genksyms

----------------------------------------------------------------
Masahiro Yamada (2):
      gcc-plugins: fix build condition of SANCOV plugin
      kbuild: replace hardcoded bison in cmd_bison_h with $(YACC)

Mauro Rossi (1):
      genksyms: fix typo in parse.tab.{c,h} generation rules

Rasmus Villemoes (2):
      modpost: delete stale comment
      MAINTAINERS: Update Kbuild entry with a few paths

 MAINTAINERS                  | 4 +++-
 scripts/Makefile.gcc-plugins | 2 +-
 scripts/Makefile.lib         | 2 +-
 scripts/genksyms/Makefile    | 4 ++--
 scripts/mod/sumversion.c     | 9 +--------
 5 files changed, 8 insertions(+), 13 deletions(-)






-- 
Best Regards
Masahiro Yamada
