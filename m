Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeCFJkS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:40:18 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:64310 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeCFJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:40:15 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w269eBra017331
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AG47ELvEOXNnqi7fUuzweqXhmAQvW6iKZ8ib8iz7c8h6OoqVBIkjl3yBaokKO1reKoKhvfcQWbvI/wT44X4q2gTplIQ=
MIME-Version: 1.0
In-Reply-To: <1519886077-31914-2-git-send-email-yamada.masahiro@socionext.com>
References: <1519886077-31914-1-git-send-email-yamada.masahiro@socionext.com> <1519886077-31914-2-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 6 Mar 2018 18:39:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARM_1fXyh8hnnAw7DGC97LZ7-pcriqWC9gQ4uSnU==Vpg@mail.gmail.com>
Message-ID: <CAK7LNARM_1fXyh8hnnAw7DGC97LZ7-pcriqWC9gQ4uSnU==Vpg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kconfig: rename silentoldconfig to syncconfig
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Herbert <marc.herbert@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Michal Marek <michal.lkml@markovi.net>,
        intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 15:34 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> As commit cedd55d49dee ("kconfig: Remove silentoldconfig from help
> and docs; fix kconfig/conf's help") mentioned, 'silentoldconfig' is a
> historical misnomer.  That commit removed it from help and docs since
> it is an internal interface.  If so, it should be allowed to rename
> it to something more intuitive.  'syncconfig' is the one I came up
> with because it updates the .config if necessary, then synchronize
> include/generated/autoconf.h and include/config/* with it.
>
> You should not manually invoke 'silentoldcofig'.  Display warning if
> used in case existing scripts are doing wrong.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v3:
>   - Fix Documentation/networking/i40e.txt
>   - Display warning if silentoldconfig is used
>
> Changes in v2:
>   - newly added
>

Both applied to linux-kbuild/kconfig.


-- 
Best Regards
Masahiro Yamada
