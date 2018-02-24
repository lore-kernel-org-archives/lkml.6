Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeBXO7u (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 09:59:50 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:44313 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBXO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 09:59:48 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1OExX0p012842
X-Nifty-SrcIP: [209.85.213.47]
X-Google-Smtp-Source: AG47ELvZRvvx6tlXBuKcGGmwDz8OIazAh6iPykkbMIiKSXO7E3m+XaUGhVvYX6ykf3ZQ41FfSo2wigk4FNRhbJenmhs=
MIME-Version: 1.0
In-Reply-To: <20180221042507.31379-1-caoj.fnst@cn.fujitsu.com>
References: <20180221042507.31379-1-caoj.fnst@cn.fujitsu.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 24 Feb 2018 23:58:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyTRwpFRum2x4LQ9Yfdgk6b3tmXcm3RcTLgNZ8_pu3sw@mail.gmail.com>
Message-ID: <CAK7LNASyTRwpFRum2x4LQ9Yfdgk6b3tmXcm3RcTLgNZ8_pu3sw@mail.gmail.com>
Subject: Re: [PATCH RFC] kbuild: drop superfluous GCC_PLUGINS_CFLAGS assignment
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-21 13:25 GMT+09:00 Cao jin <caoj.fnst@cn.fujitsu.com>:
> GCC_PLUGINS_CFLAGS is already in the environment, so it is superfluous
> to add it in commanline of final build of init/
>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>

Applied to linux-kbuild,
with 'commanline' fixed to 'command line'.




-- 
Best Regards
Masahiro Yamada
