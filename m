Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965963AbeCAEos (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 23:44:48 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:19152 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965813AbeCAEoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 23:44:46 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w214ieNr017254
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AG47ELtsDDljcYsMT4L9nGms5hD4aS4enekA/Te9FY05Cw9U1oGi3pSIzzVhQKAFRoG4WmJ6KgQCqNhtnDnRFVyWaL8=
MIME-Version: 1.0
In-Reply-To: <20180228233249.26281-1-robh@kernel.org>
References: <20180228233249.26281-1-robh@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Mar 2018 13:43:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARdHBVBw_7ftyTEtyJ5KSX03dqB7y+=o2xQH1rYPtChTQ@mail.gmail.com>
Message-ID: <CAK7LNARdHBVBw_7ftyTEtyJ5KSX03dqB7y+=o2xQH1rYPtChTQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] dtc updates for 4.17
To: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 8:32 GMT+09:00 Rob Herring <robh@kernel.org>:
> This series updates building dtc with flex and bison rather than using
> the _shipped files and updates dtc to the current upstream version. The
> new dtc adds some new warnings, so turn off the noisiest ones. While
> here adjusting the warnings, we can also now re-enable some that have
> gotten fixed.
>
> Yamada-san, I figured out why you wanted the dtc update after I wrote
> the patch to remove the shipped files... :) I guess you may already have
> a similar patch.


Exactly, this is what I expected.

What I blocked me was ambiguous grammar
as I mentioned in:
https://www.spinics.net/lists/kernel/msg2670836.html



> I suppose the first patch should go into 4.16, but
> nothing needs the fix yet. So it may be easier if you can just ack it
> and I'll keep it with the rest of the series.

Just browsing the series, nothing of the rest of it depends on 1/6
but feel free to pick it to your tree if you want.





-- 
Best Regards
Masahiro Yamada
