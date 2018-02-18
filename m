Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeBRXpq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:45:46 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:41952 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeBRXpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:45:44 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w1INjJpa003370
X-Nifty-SrcIP: [209.85.217.179]
X-Google-Smtp-Source: AH8x227PBNcRyZHbK1Cu9qInHgJxJRaxk6/4DLux7gA+6qd5oFOQd9fSCYUsBmmw5pvB22RG2AIotRYoIhULXVwZg8o=
MIME-Version: 1.0
In-Reply-To: <1518338429-5587-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518338429-5587-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 19 Feb 2018 08:44:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT0U6Fj3s0ymZiTL+kvD=iYgsCMCF-Gy7LxtU7UzXN=gg@mail.gmail.com>
Message-ID: <CAK7LNAT0U6Fj3s0ymZiTL+kvD=iYgsCMCF-Gy7LxtU7UzXN=gg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: process mixture of clean/build targets one by one
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, Thomas Meyer <thomas@m3y3r.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-11 17:40 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> I sometimes receive a question why "make -j<N> clean all" does not
> work.  It is actually possible to make it work by handling targets
> one by one.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>

Applied to linux-kbuild/kbuild.

-- 
Best Regards
Masahiro Yamada
