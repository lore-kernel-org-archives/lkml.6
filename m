Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeEEBiF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:38:05 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:59621 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeEEBiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:38:03 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w451bjrS026102
X-Nifty-SrcIP: [209.85.217.171]
X-Google-Smtp-Source: AB8JxZopx51Yool7C/zCfeaiAMY9ApH/kea+no6LjGHfYdbH2rEO5D18Wu5GD4pqBJb2la2QkbPPEC2KxNwO907x99A=
MIME-Version: 1.0
In-Reply-To: <20180322205827.24578-1-linux@rasmusvillemoes.dk>
References: <20180322205827.24578-1-linux@rasmusvillemoes.dk>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 5 May 2018 10:37:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARK73rjwhK62+1q5ie07Y8r82ErLgLxb8RTNUcOYACgcQ@mail.gmail.com>
Message-ID: <CAK7LNARK73rjwhK62+1q5ie07Y8r82ErLgLxb8RTNUcOYACgcQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Kbuild entry with a few paths
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-23 5:58 GMT+09:00 Rasmus Villemoes <linux@rasmusvillemoes.dk>:
> I managed to send some modpost patches to old addresses of both
> Masahiro and Michal, and omitted linux-kbuild from cc, because my
> tried and trusted scripts/get_maintainer wrapper failed me. Add the
> modpost directory to the MAINTAINERS entry, and while at it make the
> Makefile glob match scripts/Makefile itself, and add one matching the
> Kbuild.include file as well.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> Hi Kbuild maintainers. Hope you don't mind me extending this entry a bit.



Applied to linux-kbuild/fixes.
Thanks.





-- 
Best Regards
Masahiro Yamada
