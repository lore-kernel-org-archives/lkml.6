Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeEBQRV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:17:21 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:35420 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEBQRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:17:19 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w42GHDh6023672
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AB8JxZrJPUy1aMM4+NItNECPCKEbCcu1nnTGJBMDN9LbGLew2ct1mzJrU52rbcvva9Fm2tef63zS1q8ug64db5BlShU=
MIME-Version: 1.0
In-Reply-To: <1524568099-25206-1-git-send-email-yamada.masahiro@socionext.com>
References: <1524568099-25206-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 3 May 2018 01:16:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1phzq4krka=rxTxpfGAJhx0frRpnXsB51azna8XZ+DQ@mail.gmail.com>
Message-ID: <CAK7LNAT1phzq4krka=rxTxpfGAJhx0frRpnXsB51azna8XZ+DQ@mail.gmail.com>
Subject: Re: [PATCH] genksyms: fix typo in parse.tab.{c,h} generation rules
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Mauro Rossi <issor.oruam@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-24 20:08 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> From: Mauro Rossi <issor.oruam@gmail.com>
>
> 'quet' is replaced by 'quiet' in scripts/genksyms/Makefile
>
> Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild/fixes.


>  scripts/genksyms/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
> index ef0287e..03b7ce9 100644
> --- a/scripts/genksyms/Makefile
> +++ b/scripts/genksyms/Makefile
> @@ -14,14 +14,14 @@ genksyms-objs       := genksyms.o parse.tab.o lex.lex.o
>  # so that 'bison: not found' will be displayed if it is missing.
>  ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
>
> -quiet_cmd_bison_no_warn = $(quet_cmd_bison)
> +quiet_cmd_bison_no_warn = $(quiet_cmd_bison)
>        cmd_bison_no_warn = $(YACC) --version >/dev/null; \
>                           $(cmd_bison) 2>/dev/null
>
>  $(obj)/parse.tab.c: $(src)/parse.y FORCE
>         $(call if_changed,bison_no_warn)
>
> -quiet_cmd_bison_h_no_warn = $(quet_cmd_bison_h)
> +quiet_cmd_bison_h_no_warn = $(quiet_cmd_bison_h)
>        cmd_bison_h_no_warn = $(YACC) --version >/dev/null; \
>                             $(cmd_bison_h) 2>/dev/null
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
