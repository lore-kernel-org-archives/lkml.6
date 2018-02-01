Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeBARMr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:12:47 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:36798 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbeBARMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:12:44 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w11HCcVO008150
X-Nifty-SrcIP: [209.85.217.181]
X-Google-Smtp-Source: AH8x227+Jd8Sz7WNbn8WpocVATTMnt0yv156uShGJOGWcEdqpdOFWUtbjzfnNZNA6virdlU5z7aXAyiXMDg94XfoYrw=
MIME-Version: 1.0
In-Reply-To: <20180131093434.20050-10-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com> <20180131093434.20050-10-ulfalizer@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 2 Feb 2018 02:11:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQTDWe4oHO13AsE0vtL_wuWiPsduKScAZh1LP49OV8SMg@mail.gmail.com>
Message-ID: <CAK7LNAQTDWe4oHO13AsE0vtL_wuWiPsduKScAZh1LP49OV8SMg@mail.gmail.com>
Subject: Re: [PATCH 09/11] arm: vt8500: kconfig: Remove blank help text
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paul Bolle <pebolle@tiscali.nl>, Tony Prisk <linux@prisktech.co.nz>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-31 18:34 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> Blank help texts are probably either a typo, a Kconfig misunderstanding,
> or some kind of half-committing to adding a help text (in which case a
> TODO comment would be clearer, if the help text really can't be added
> right away).
>
> Best to remove them, IMO.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---


FYI.

I picked up this patch to kbuild
because I need this to suppress warning messages
introduced by 11/11.

I am planning to send a PR for this series next week.
