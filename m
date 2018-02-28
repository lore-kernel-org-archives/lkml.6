Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933074AbeB1P2S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:28:18 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:52953 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933037AbeB1P15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:27:57 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w1SFRgku019237
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AG47ELvPgfQDNBiCLm9OzIkIsDmqCkhw0xsUIH6iL9CnTMU2ML3WkInCJOBVTS8NYqucITalTvnmbaYC+OsIsPkqHoE=
MIME-Version: 1.0
In-Reply-To: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Mar 2018 00:27:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-gLVSY9UU79Fee7MRJgh0LkvixsWehkjDiT4zu47now@mail.gmail.com>
Message-ID: <CAK7LNAS-gLVSY9UU79Fee7MRJgh0LkvixsWehkjDiT4zu47now@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] kconfig: some clean-ups and rename silentoldconfig
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Marc Herbert <marc.herbert@intel.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-28 9:15 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Masahiro Yamada (6):
>   kconfig: do not call check_conf() for olddefconfig
>   kconfig: remove unneeded input_mode test in conf()
>   kconfig: remove redundant input_mode test for check_conf() loop
>   kconfig: hide irrelevant sub-menus for oldconfig
>   kconfig: invoke oldconfig instead of silentoldconfig from local*config
>   kconfig: rename silentoldconfig to syncconfig
>
>  Documentation/kbuild/kconfig.txt |  2 +-
>  Makefile                         |  2 +-
>  scripts/kconfig/Makefile         |  8 ++++----
>  scripts/kconfig/conf.c           | 41 ++++++++++++++++++++--------------------
>  4 files changed, 27 insertions(+), 26 deletions(-)
>
> --


1-4 applied to linux-kbuild/kconfig
because they are re-post.

I will re-spin 5 and 6 as commented.


-- 
Best Regards
Masahiro Yamada
