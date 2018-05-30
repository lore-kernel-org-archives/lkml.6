Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968575AbeE3BpF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:45:05 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:59384 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965152AbeE3BpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:45:04 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w4U1ipvt022400
X-Nifty-SrcIP: [209.85.213.50]
X-Google-Smtp-Source: ADUXVKKLnRbQrOXTae7OR8SS+fdtYTMGtBzbReYOSL+9xPyHh6TInBEtGqCVTZTGWymOnb9cxcPMeJKGFTR1iam9Soc=
MIME-Version: 1.0
In-Reply-To: <20180530112942.2cfc2251@canb.auug.org.au>
References: <20180530112942.2cfc2251@canb.auug.org.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 30 May 2018 10:44:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9Cqhabc7xC11ZnRNPbDHEbpmb80hA362vEYDUo=vOpA@mail.gmail.com>
Message-ID: <CAK7LNAT9Cqhabc7xC11ZnRNPbDHEbpmb80hA362vEYDUo=vOpA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-30 10:29 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Masahiro,
>
> After merging the kbuild tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> make was continually spawning test compiles.
>
> I used the kbuild tree from next-20180529 for today.
>
> A (partial) strace seemed to show that it was testing for compiler flags
> (some more than once).
>

My bad - I need to insert some patches from Nicholas Piggin.

I will fix it for tomorrows' release.

Thanks for the report!




-- 
Best Regards
Masahiro Yamada
