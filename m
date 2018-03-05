Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbeCEPCK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:02:10 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:23104 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbeCEPCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:02:06 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w25F22IO007238
X-Nifty-SrcIP: [209.85.213.42]
X-Google-Smtp-Source: AG47ELtkrGGLIuIL6eRqj3Q2yXZCx7c+JkKkh1mwqq+xQM/kmi20119cqStGLTVjf/A9h6ofyOiJaRisIwq6KvRn5o8=
MIME-Version: 1.0
In-Reply-To: <1519812864-852-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519812864-852-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 6 Mar 2018 00:01:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzxVy1D48-aOTfwNRdMd48CSoJfe0hpvH=XXZL5czwmQ@mail.gmail.com>
Message-ID: <CAK7LNASzxVy1D48-aOTfwNRdMd48CSoJfe0hpvH=XXZL5czwmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: remove command line interface LDFLAGS_MODULE
 from makefiles.txt
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Robin Jarry <robin.jarry@6wind.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-28 19:14 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Documentation/kbuild/makefiles.txt lists variables used in Makefile
> whereas Documentation/kbuild/kbuild.txt describes user assignable
> parameters given via environments or the command line.
>
> LDFLAGS_MODULE is a command line interface, so it should be dropped
> from makefiles.txt.
>
> Some lines below in this file, it is clearly explained that
> KBUILD_LDFLAGS_MODULE is the right one for the internal use:
>
>     KBUILD_LDFLAGS_MODULE   Options for $(LD) when linking modules
>
>         $(KBUILD_LDFLAGS_MODULE) is used to add arch-specific options
>         used when linking modules. This is often a linker script.
>         From commandline LDFLAGS_MODULE shall be used (see kbuild.txt).
>
> Then, kbuild.txt explains LDFLAGS_MODULE, like follows:
>
>     LDFLAGS_MODULE
>     --------------------------------------------------
>     Additional options used for $(LD) when linking modules.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  Documentation/kbuild/makefiles.txt | 6 ------
>  1 file changed, 6 deletions(-)


Both applied to linux-kbuild/kbuild.






-- 
Best Regards
Masahiro Yamada
