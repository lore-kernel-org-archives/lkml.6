Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeCXB1q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 21:27:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39919 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeCXB1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 21:27:45 -0400
X-Google-Smtp-Source: AG47ELuZo5EUxUuRtaO/4HmZLNr2DirClBcb57mvJWbeVCWru0tvtRVNvBlOPqTilMHUpjUJNvn1Yw==
Subject: Re: [PATCH 01/10] .gitignore: move *.lex.c *.tab.[ch] patterns to the
 top-level .gitignore
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1521810279-6282-1-git-send-email-yamada.masahiro@socionext.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <03375f49-877b-47e9-6a7b-24cbdd9d5bef@gmail.com>
Date: Fri, 23 Mar 2018 18:27:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521810279-6282-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/18 06:04, Masahiro Yamada wrote:
> These patterns are common to host programs that require lexer and parser.
> Move them to the top .gitignore.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Frank Rowand <frowand.list@gmail.com>

-Frank
> ---
> 
>  .gitignore                  | 2 ++
>  scripts/dtc/.gitignore      | 3 ---
>  scripts/genksyms/.gitignore | 3 ---
>  scripts/kconfig/.gitignore  | 3 ---
>  4 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 85bcc26..1e82be1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -22,6 +22,7 @@
>  *.gz
>  *.i
>  *.ko
> +*.lex.c
>  *.ll
>  *.lst
>  *.lz4
> @@ -37,6 +38,7 @@
>  *.so.dbg
>  *.su
>  *.symtypes
> +*.tab.[ch]
>  *.tar
>  *.xz
>  Module.symvers
> diff --git a/scripts/dtc/.gitignore b/scripts/dtc/.gitignore
> index cdabdc9..2e6e60d 100644
> --- a/scripts/dtc/.gitignore
> +++ b/scripts/dtc/.gitignore
> @@ -1,4 +1 @@
>  dtc
> -dtc-lexer.lex.c
> -dtc-parser.tab.c
> -dtc-parser.tab.h
> diff --git a/scripts/genksyms/.gitignore b/scripts/genksyms/.gitignore
> index e7836b4..b119c7d 100644
> --- a/scripts/genksyms/.gitignore
> +++ b/scripts/genksyms/.gitignore
> @@ -1,4 +1 @@
> -*.lex.c
> -*.tab.c
> -*.tab.h
>  genksyms
> diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
> index a76856e..2da579e 100644
> --- a/scripts/kconfig/.gitignore
> +++ b/scripts/kconfig/.gitignore
> @@ -1,9 +1,6 @@
>  #
>  # Generated files
>  #
> -*.lex.c
> -*.tab.c
> -*.tab.h
>  *.moc
>  gconf.glade.h
>  *.pot
> 
