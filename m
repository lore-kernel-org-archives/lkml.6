Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeCTPf7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:35:59 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:25975 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeCTPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:35:56 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w2KFZlj2028566
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AG47ELsqeU9TgQgTh+uSQHm/vfTKHvI1cZ188FYrK+ZS4SFZVZWDZlgERsJ3yEhH3r2Vj7F+dulUqibuJlpQ65qDcF8=
MIME-Version: 1.0
In-Reply-To: <1521185836-19120-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521185836-19120-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Mar 2018 00:35:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASq5MML3PRSB+mze3zgHEq11--31nKsaP0qG2hN6tEi_A@mail.gmail.com>
Message-ID: <CAK7LNASq5MML3PRSB+mze3zgHEq11--31nKsaP0qG2hN6tEi_A@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] kbuild: various fix, clean-up, improvements of CONFIG_TRIM_UNUSED_KSYMS
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-16 16:37 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> Masahiro Yamada (7):
>   kbuild: clear LDFLAGS in the top Makefile
>   kbuild: remove wrong 'touch' in adjust_autoksyms.sh
>   kbuild: move 'scripts' target below
>   kbuild: restore touching autoksyms.h to the top Makefile
>   kbuild: move CONFIG_TRIM_UNUSED_KSYMS code unneeded for external
>     module
>   kbuild: move include/config/ksym/* to include/ksym/*
>   kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS
>

Series, applied to linux-kbuild.

-- 
Best Regards
Masahiro Yamada
