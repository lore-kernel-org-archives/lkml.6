Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeCTPeA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:34:00 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:58552 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:33:56 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w2KFXjCf029145
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AG47ELt3v3NmC0N3N53yEd7SU/KnnJHKlIloydaS2sd3EfZUmDJLPIH8IwFmI7bDG8tQ3/9hfGdXHHZmxyJ05Olyuus=
MIME-Version: 1.0
In-Reply-To: <20180319211253.3172-1-stefan@agner.ch>
References: <20180319211253.3172-1-stefan@agner.ch>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Mar 2018 00:33:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARn19r2hE-f-Gusq4rgvMZ0a=fk2Qbw8fhvsd7iAd+1Tg@mail.gmail.com>
Message-ID: <CAK7LNARn19r2hE-f-Gusq4rgvMZ0a=fk2Qbw8fhvsd7iAd+1Tg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: set no-integrated-as before incl. arch Makefile
To: Stefan Agner <stefan@agner.ch>
Cc: Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-20 6:12 GMT+09:00 Stefan Agner <stefan@agner.ch>:
> In order to make sure compiler flag detection for ARM works
> correctly the no-integrated-as flags need to be set before
> including the arch specific Makefile.
>
> Fixes: cfe17c9bbe6a ("kbuild: move cc-option and cc-disable-warning after incl. arch Makefile")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---

Applied to linux-kbuild. Thanks!

-- 
Best Regards
Masahiro Yamada
