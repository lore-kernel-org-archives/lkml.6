Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2F1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6661120874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Gg3Mp4Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbeL1QFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:05:16 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:51941 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeL1QFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:05:15 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wBSG56BD002213;
        Sat, 29 Dec 2018 01:05:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wBSG56BD002213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546013107;
        bh=CnhcrJFMKHa12IlQTKEeIRQ8j8BQ0RooIDvWBnTyOHE=;
        h=From:Date:Subject:To:Cc:From;
        b=Gg3Mp4Gce82HzOkOQqovto6xuZVm8nXVHSDzq3JJJZJTEfKEYUvKP+v+UzmH22Gto
         3mrdwapORa6+7Auf0+D2fOGLrmpKFWXrUwnxHuUjDLOxWhz6hIouWeymwlCNG/ZppH
         UfaRfdCTNX7sgdKtAZF2Na5i4S0khSim4Tk0jZAJPMGVsJEa+eLwHaYuJBEPL1xZeP
         mfG0UABmDMmdWseHnw+bCHIo+UWbrJ6kF0+d/vlNOzu4/ThqPEENUkffsxD+kSG0Ol
         lqfwe2c2VVbKfSU9KDvgcleGgO9/COm9cPSsB2U/zAOJupya3e08UbB4CydB87S6wR
         /PsMcNmdnV+UQ==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id y27so13232154vsi.1;
        Fri, 28 Dec 2018 08:05:06 -0800 (PST)
X-Gm-Message-State: AJcUukfP2J6iuZ22vavtafO+L4z2OEUuMs8BvsKCgaDfTlUftScgBs8I
        aLNEL34wgHc0NbCLQ9foumJ8X/GfMnMCu0PoVhg=
X-Google-Smtp-Source: ALg8bN4F26/s3bU5kiG7E+y0XtVl6ZpaXMJZiPJuiLSjhyrs9eiuy7Cp0vWVnEC6oIFI8NZYTut2FwxFvQ4KtXIaePM=
X-Received: by 2002:a67:385a:: with SMTP id f87mr11465702vsa.179.1546013105690;
 Fri, 28 Dec 2018 08:05:05 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 29 Dec 2018 01:04:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASuG-TiivGrJ17jY_mTPT1SaZQw4DaCRY+49deF49ZaEQ@mail.gmail.com>
Message-ID: <CAK7LNASuG-TiivGrJ17jY_mTPT1SaZQw4DaCRY+49deF49ZaEQ@mail.gmail.com>
Subject: [GIT PULL 3/4] Kconfig updates for v4.21
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kconfig updates for v4.21


You will be able to pull this cleanly,
but please remember you might need to fix-up
drivers/hwmon/Kconfig when you pull the hwmon PR.

Please see this:
https://lkml.org/lkml/2018/12/16/207





The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kconfig-v4.21

for you to fetch changes up to f222b7f43661c3dddd44ee493c16e04e8f231542:

  kconfig: surround dbg_sym_flags with #ifdef DEBUG to fix gconf
warning (2018-12-28 22:22:39 +0900)

----------------------------------------------------------------
Kconfig updates for v4.21

 - support -y option for merge_config.sh to avoid downgrading =y to =m

 - remove S_OTHER symbol type, and touch include/config/*.h files correctly

 - fix file name and line number in lexer warnings

 - fix memory leak when EOF is encountered in quotation

 - resolve all shift/reduce conflicts of the parser

 - warn no new line at end of file

 - make 'source' statement more strict to take only string literal

 - rewrite the lexer and remove the keyword lookup table

 - convert to SPDX License Identifier

 - compile C files independently instead of including them from zconf.y

 - fix various warnings of gconfig

 - misc cleanups

----------------------------------------------------------------
Anders Roxell (1):
      scripts/kconfig/merge_config: don't redefine 'y' to 'm'

Masahiro Yamada (38):
      kconfig: remove unneeded setsym label in conf_read_simple()
      kconfig: rename conf_split_config() to conf_touch_deps()
      kconfig: split out code touching a file to conf_touch_dep()
      kconfig: remove S_OTHER symbol type and correct dependency tracking
      kconfig: remove k_invalid from expr_parse_string() return type
      kconfig: fix file name and line number of warn_ignored_character()
      kconfig: fix memory leak when EOF is encountered in quotation
      kconfig: require T_EOL to reduce visible statement
      kconfig: remove unneeded pattern matching to whitespaces
      kconfig: refactor pattern matching in STRING state
      kconfig: fix ambiguous grammar in terms of new lines
      kconfig: clean up EOF handling in the lexer
      kconfig: warn no new line at end of file
      kconfig: remove grammatically ambiguous "unexpected option" diagnostic
      kconfig: remove grammatically ambiguous option_error
      kconfig: remove redundant if_block rule
      kconfig: remove redundant menu_block rule
      kconfig: loosen the order of "visible" and "depends on" in menu entry
      kconfig: rename depends_list to comment_option_list
      kconfig: remove redundant token defines
      kconfig: use distinct tokens for type and default properties
      kconfig: refactor scanning and parsing "option" properties
      kconfig: use specific tokens instead of T_ASSIGN for assignments
      kconfig: use T_WORD instead of T_VARIABLE for variables
      microblaze: surround string default in Kconfig with double quotes
      treewide: surround Kconfig file paths with double quotes
      kconfig: stop supporting '.' and '/' in unquoted words
      kconfig: refactor end token rules
      kconfig: stop associating kconf_id with yylval
      kconfig: switch to ASSIGN_VAL state in the second lexer
      kconfig: update current_pos in the second lexer
      kconfig: remove keyword lookup table entirely
      kconfig: convert to SPDX License Identifier
      kconfig: split some C files out of zconf.y
      kconfig: split the lexer out of zconf.y
      kconfig: add static qualifiers to fix gconf warnings
      kconfig: split images.c out of qconf.cc/gconf.c to fix gconf warnings
      kconfig: surround dbg_sym_flags with #ifdef DEBUG to fix gconf warning

 arch/arm/Kconfig                                          |   2 +-
 arch/arm/kvm/Kconfig                                      |   2 +-
 arch/arm64/Kconfig                                        |   2 +-
 arch/arm64/kvm/Kconfig                                    |   2 +-
 arch/ia64/Kconfig                                         |   2 +-
 arch/m68k/Kconfig                                         |   6 +-
 arch/microblaze/Kconfig.platform                          |   2 +-
 arch/mips/kvm/Kconfig                                     |   2 +-
 arch/openrisc/Kconfig                                     |   2 +-
 arch/powerpc/Kconfig                                      |   4 +-
 arch/powerpc/kvm/Kconfig                                  |   2 +-
 arch/riscv/Kconfig                                        |   2 +-
 arch/s390/Kconfig                                         |   2 +-
 arch/s390/kvm/Kconfig                                     |   2 +-
 arch/sh/Kconfig                                           |   2 +-
 arch/sparc/Kconfig                                        |   2 +-
 arch/x86/Kconfig                                          |   2 +-
 arch/x86/kvm/Kconfig                                      |   2 +-
 block/Kconfig                                             |   2 +-
 crypto/Kconfig                                            |   4 +-
 drivers/crypto/Kconfig                                    |   2 +-
 drivers/gpu/drm/i915/Kconfig                              |   2 +-
 drivers/hwmon/Kconfig                                     |   2 +-
 drivers/i2c/Kconfig                                       |   6 +-
 drivers/pps/Kconfig                                       |   4 +-
 drivers/ras/Kconfig                                       |   2 +-
 drivers/thermal/Kconfig                                   |   2 +-
 drivers/w1/Kconfig                                        |   4 +-
 kernel/Kconfig.preempt                                    |   2 +-
 lib/Kconfig.debug                                         |   4 +-
 scripts/kconfig/Makefile                                  |  25 +-
 scripts/kconfig/conf.c                                    |   2 +-
 scripts/kconfig/confdata.c                                | 136 +++++------
 scripts/kconfig/expr.c                                    |  18 +-
 scripts/kconfig/expr.h                                    |   6 +-
 scripts/kconfig/gconf.c                                   |  30 ++-
 scripts/kconfig/images.c                                  |  34 +--
 scripts/kconfig/images.h                                  |  33 +++
 scripts/kconfig/kconf_id.c                                |  52 -----
 scripts/kconfig/lkc.h                                     |  25 +-
 scripts/kconfig/lxdialog/checklist.c                      |  15 +-
 scripts/kconfig/lxdialog/dialog.h                         |  15 +-
 scripts/kconfig/lxdialog/inputbox.c                       |  15 +-
 scripts/kconfig/lxdialog/menubox.c                        |  15 +-
 scripts/kconfig/lxdialog/textbox.c                        |  15 +-
 scripts/kconfig/lxdialog/util.c                           |  15 +-
 scripts/kconfig/lxdialog/yesno.c                          |  15 +-
 scripts/kconfig/mconf.c                                   |   2 +-
 scripts/kconfig/menu.c                                    |  43 ++--
 scripts/kconfig/merge_config.sh                           |  48 ++--
 scripts/kconfig/nconf.c                                   |   5 +-
 scripts/kconfig/nconf.gui.c                               |   5 +-
 scripts/kconfig/nconf.h                                   |   5 +-
 scripts/kconfig/preprocess.c                              |   5 +-
 scripts/kconfig/qconf.cc                                  |   4 +-
 scripts/kconfig/qconf.h                                   |   2 +-
 scripts/kconfig/streamline_config.pl                      |   2 +-
 scripts/kconfig/symbol.c                                  |   7 +-
 scripts/kconfig/tests/auto_submenu/Kconfig                |   2 +
 scripts/kconfig/tests/auto_submenu/__init__.py            |   1 +
 scripts/kconfig/tests/choice/Kconfig                      |   2 +
 scripts/kconfig/tests/choice/__init__.py                  |   1 +
 scripts/kconfig/tests/choice_value_with_m_dep/Kconfig     |   2 +
 scripts/kconfig/tests/choice_value_with_m_dep/__init__.py |   1 +
 scripts/kconfig/tests/err_recursive_inc/__init__.py       |   1 +
 scripts/kconfig/tests/inter_choice/Kconfig                |   2 +
 scripts/kconfig/tests/inter_choice/__init__.py            |   1 +
 scripts/kconfig/tests/new_choice_with_dep/Kconfig         |   2 +
 scripts/kconfig/tests/new_choice_with_dep/__init__.py     |   1 +
 scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig       |   2 +
 scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py   |   1 +
 scripts/kconfig/tests/rand_nested_choice/Kconfig          |   2 +
 scripts/kconfig/tests/rand_nested_choice/__init__.py      |   1 +
 scripts/kconfig/util.c                                    |   3 +-
 scripts/kconfig/zconf.l                                   | 235
++++++++++---------
 scripts/kconfig/zconf.y                                   | 290
++++++++++--------------
 security/Kconfig                                          |  16 +-
 security/integrity/Kconfig                                |   4 +-
 78 files changed, 548 insertions(+), 694 deletions(-)
 create mode 100644 scripts/kconfig/images.h
 delete mode 100644 scripts/kconfig/kconf_id.c


--
Best Regards
Masahiro Yamada
