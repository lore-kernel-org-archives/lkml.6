Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeBAQ4q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:56:46 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:24238 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbeBAQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:56:44 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w11GuYuf002509
X-Nifty-SrcIP: [209.85.217.176]
X-Google-Smtp-Source: AH8x225iF3jdTHX0zG4o1/uYx+P6czha5pCgOjQdTwd29S4bMABCryT71DyOozSCav5k0nJ3IRlGAoH+8kZAjPRkGns=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 2 Feb 2018 01:55:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfif_XNZYa8o3cn=HP6B8mdpZVTboR6hgVwctP32HeTw@mail.gmail.com>
Message-ID: <CAK7LNAQfif_XNZYa8o3cn=HP6B8mdpZVTboR6hgVwctP32HeTw@mail.gmail.com>
Subject: [GIT PULL 1/3] Kbuild updates for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are Kbuild updates for v4.16.  Please pull!



The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v4.16

for you to fetch changes up to f759625ad270898efdf8c153c74021a8a919312b:

  kbuild: fix W= option checks for extra DTC warnings (2018-01-25
22:17:25 +0900)

----------------------------------------------------------------
Kbuild updates for v4.16

- Terminate the build correctly in case of fixdep errors

- Clean up fixdep

- Suppress packed-not-aligned warnings from GCC-8

- Fix W= handling for extra DTC warnings

----------------------------------------------------------------
Lukas Bulwahn (1):
      fixdep: exit with error code in error branches of do_config_file()

Masahiro Yamada (8):
      fixdep: remove unnecessary <arpa/inet.h> inclusion
      fixdep: use malloc() and read() to load dep_file to buffer
      fixdep: factor out common code for reading files
      fixdep: remove unneeded memcpy() in parse_dep_file()
      fixdep: move global variables to local variables of main()
      fixdep: refactor parse_dep_file()
      fixdep: use existing helper to check modular CONFIG options
      kbuild: fix W= option checks for extra DTC warnings

Xiongfeng Wang (1):
      Kbuild: suppress packed-not-aligned warning for default setting only

 scripts/Makefile.extrawarn |   3 +
 scripts/Makefile.lib       |   4 +-
 scripts/basic/fixdep.c     | 236 ++++++++++++++++------------------------
 3 files changed, 101 insertions(+), 142 deletions(-)


-- 
Best Regards
Masahiro Yamada
