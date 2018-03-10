Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932484AbeCJPqW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 10:46:22 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:51179 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeCJPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 10:46:20 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w2AFk4hZ004947
X-Nifty-SrcIP: [209.85.217.170]
X-Google-Smtp-Source: AG47ELuaPK4YeqUharxTKnUpcgMJNnIxRZaVWmrHXhsJZ1CmBEeYwF1cYjKk7ruD67LoR7sI8zm6HqmTCh9H66rqStQ=
MIME-Version: 1.0
In-Reply-To: <20180310000727.GA8881@example.com>
References: <1520333499-31854-1-git-send-email-yamada.masahiro@socionext.com> <20180310000727.GA8881@example.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 11 Mar 2018 00:45:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQhSRpx6wD_FYAnc0=zMpwcyyQXQ5OAnzKBmL0K6-ZExA@mail.gmail.com>
Message-ID: <CAK7LNAQhSRpx6wD_FYAnc0=zMpwcyyQXQ5OAnzKBmL0K6-ZExA@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: make unmet dependency warnings readable
To: Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Petr Vorel <petr.vorel@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr, Eugeniu,

2018-03-10 9:07 GMT+09:00 Eugeniu Rosca <roscaeugeniu@gmail.com>:

>
> It looks like expr_get_leftmost_symbol() has no more callers left and
> could be removed with this patch?


Thanks, I will send v3
with fixes pointed out.

-- 
Best Regards
Masahiro Yamada
