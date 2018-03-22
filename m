Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755158AbeCVPOZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:14:25 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:38852 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755074AbeCVPOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:14:22 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w2MFEJ7j004430
X-Nifty-SrcIP: [209.85.217.175]
X-Google-Smtp-Source: AG47ELvAOdlbZMC9JdAt17Peeym916sz5gzlBwiix5QAcLivinF+jqfe9jQ53BjQ/Teq5yAkgGgolnn4UiIQR0uTdiU=
MIME-Version: 1.0
In-Reply-To: <20180216202255.25307-3-ulfalizer@gmail.com>
References: <20180216202255.25307-1-ulfalizer@gmail.com> <20180216202255.25307-3-ulfalizer@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Mar 2018 00:13:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNATn1qu0+sXvEtLwd7eJJDNtm0Mt_MaPA3_W=TnxZkK7fQ@mail.gmail.com>
Message-ID: <CAK7LNATn1qu0+sXvEtLwd7eJJDNtm0Mt_MaPA3_W=TnxZkK7fQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] checkpatch: kconfig: check help texts for menuconfig
 and choice
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Robo Bot <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-17 5:22 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> Currently, only Kconfig symbols are checked for a missing or short help
> text, and are only checked if they are defined with the 'config'
> keyword.
>
> To make the check more general, extend it to also check help texts for
> choices and for symbols defined with the 'menuconfig' keyword.
>
> This increases the accuracy of the check for symbols that would already
> have been checked as well, since e.g. a 'menuconfig' symbol after a help
> text will be recognized as ending the preceding symbol/choice
> definition.
>
> To increase the accuracy of the check further, also recognize 'if',
> 'endif', 'menu', 'endmenu', 'endchoice', and 'source' as ending a
> symbol/choice definition.


Currently, this is not checked for the last symbol in a file.
Perhaps, EOF could be also an ending of symbol definition.

This patch is a good improvement enough,
so I queued it up.

If you have an idea for further improvement,
v2 is welcome, of course.



-- 
Best Regards
Masahiro Yamada
