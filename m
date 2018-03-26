Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeCZPYr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:24:47 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:41468 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeCZPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:24:45 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w2QFOV4U006711
X-Nifty-SrcIP: [209.85.213.50]
X-Google-Smtp-Source: AG47ELv2C/hbnhRUfSvM6LCxRu66JchwG2o6JLHon1PoLZvRQoP74mdMFk0XGGsuP7oIiJinPykqV/bL/M1P1OhS5gk=
MIME-Version: 1.0
In-Reply-To: <1521095127-23067-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521095127-23067-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 27 Mar 2018 00:23:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQastzb7ckcUdzs5KUbdmTUA8-YXM6RYVTW_KcNzMW78g@mail.gmail.com>
Message-ID: <CAK7LNAQastzb7ckcUdzs5KUbdmTUA8-YXM6RYVTW_KcNzMW78g@mail.gmail.com>
Subject: Re: [PATCH] kconfig: do not include both curses.h and ncurses.h for nconfig
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-15 15:25 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> nconf.h includes <curses.h> and "ncurses.h", but it does not need to
> include both.  Generally, it should fall back to curses.h only when
> ncurses.h is not found.  But, looks like it has never happened;
> these includes have been here for many years since commit 692d97c380c6
> ("kconfig: new configuration interface (nconfig)"), and nobody has
> complained about hard-coding of ncurses.h .  Let's simply drop the
> curses.h inclusion.
>
> I replaced "ncurses.h" with <ncurses.h> since it does not exist in
> the local directory.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>

Applied to linux-kbuild/kconfig.

-- 
Best Regards
Masahiro Yamada
