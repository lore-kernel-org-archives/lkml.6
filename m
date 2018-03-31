Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeCaDl7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 23:41:59 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:45505 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbeCaDl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 23:41:57 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w2V3fkMp004504
X-Nifty-SrcIP: [209.85.213.54]
X-Google-Smtp-Source: AIpwx4+xYZY9EhNjBEer18UOKrqJn9ILDx1jGcsDZew/ezjuyYH4jTKDaclc7OfK/T7+OVbKP+iz2HnL1mcwjB69G+o=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 31 Mar 2018 12:41:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNARhcaN-O085VDjRbK9BmkhMGAr+Ow9-YkgDrWtJpSEriQ@mail.gmail.com>
Message-ID: <CAK7LNARhcaN-O085VDjRbK9BmkhMGAr+Ow9-YkgDrWtJpSEriQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a little more Kbuild fixes for v4.16.


The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
kbuild-fixes-v4.16-3

for you to fetch changes up to 28913ee8191adf4bbc01cbfb9ee18cca782ab141:

  netfilter: nf_nat_snmp_basic: add correct dependency to Makefile
(2018-03-29 09:42:32 +0900)

----------------------------------------------------------------
Kbuild fixes for v4.16 (3rd)

- fix missed rebuild of TRIM_UNUSED_KSYMS

- fix rpm-pkg for GNU tar >= 1.29

- include scripts/dtc/include-prefixes/* to kernel header deb-pkg

- add -no-integrated-as option ealier to fix building with Clang

- fix netfilter Makefile for parallel building

----------------------------------------------------------------
Jan Kiszka (1):
      builddeb: Fix header package regarding dtc source links

Jason Gunthorpe (1):
      kbuild: rpm-pkg: Support GNU tar >= 1.29

Masahiro Yamada (1):
      netfilter: nf_nat_snmp_basic: add correct dependency to Makefile

Nicolas Pitre (1):
      kbuild: make scripts/adjust_autoksyms.sh robust against timestamp races

Stefan Agner (1):
      kbuild: set no-integrated-as before incl. arch Makefile

 Makefile                    | 4 ++--
 net/ipv4/netfilter/Makefile | 2 +-
 scripts/adjust_autoksyms.sh | 7 +++++++
 scripts/package/builddeb    | 2 +-
 scripts/package/mkspec      | 2 +-
 5 files changed, 12 insertions(+), 5 deletions(-)

-- 
Best Regards
Masahiro Yamada
