Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeCZPZs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:25:48 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:43269 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeCZPZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:25:46 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w2QFPYjg003153
X-Nifty-SrcIP: [209.85.217.178]
X-Google-Smtp-Source: AIpwx490fdZsvS/itEFyL+s6B274lZ1FCM728QSmIz5k95clivROKd6STaQrRwtckWN+lsAfshOrlm2xY4EtO27JnH0=
MIME-Version: 1.0
In-Reply-To: <1521738014-18895-2-git-send-email-yamada.masahiro@socionext.com>
References: <1521738014-18895-1-git-send-email-yamada.masahiro@socionext.com> <1521738014-18895-2-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 27 Mar 2018 00:24:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR9HBUUNvh+F0skU4ZpCsCEVHfo6=8qJ09RLSH9_2Sq+g@mail.gmail.com>
Message-ID: <CAK7LNAR9HBUUNvh+F0skU4ZpCsCEVHfo6=8qJ09RLSH9_2Sq+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] kconfig: detect recursive inclusion earlier
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-23 2:00 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Currently, the recursive inclusion is not detected when the offending
> file is about to be included; it is detected the offending file is
> about to include the *next* file.  This is because the detection loop
> does not involve the file being included.
>
> Do this check against the file that is about to be included so that
> the recursive inclusion is detected before unneeded parsing happens.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild/kconfig.


-- 
Best Regards
Masahiro Yamada
