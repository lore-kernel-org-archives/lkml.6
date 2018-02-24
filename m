Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeBXPNM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 10:13:12 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:58437 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeBXPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 10:13:11 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w1OFD5s3022739
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AG47ELuOyLrWEcN77P/QuEprBCOe2l4tetDNxQz0NWP69NYpTZBxTr9SPvQjfTxCg6bTfd8sUXID88xihclO0MyK7wU=
MIME-Version: 1.0
In-Reply-To: <1519126829-7257-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519126829-7257-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 25 Feb 2018 00:12:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfW9+RgDCKK_9SZE_n9ShPZDcEvqi2H_jKKUyFVj1BRg@mail.gmail.com>
Message-ID: <CAK7LNARfW9+RgDCKK_9SZE_n9ShPZDcEvqi2H_jKKUyFVj1BRg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Don't leak choice names during parsing
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-20 20:40 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The named choice is not used in the kernel tree, but if it were used,
> it would not be freed.
>
> The intention of the named choice can be seen in the log of
> commit 5a1aa8a1aff6 ("kconfig: add named choice group").
>
> There is room for argument if this is useful in practice, but anyway
> I am fixing the memory leak.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Applied to linux-kbuild/kconfig.




-- 
Best Regards
Masahiro Yamada
