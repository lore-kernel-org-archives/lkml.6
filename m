Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeDXPpz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:45:55 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:25253 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDXPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:45:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w3OFjQgQ015189
X-Nifty-SrcIP: [209.85.213.51]
X-Google-Smtp-Source: AIpwx4+JfzcYGWpKRIQ5EX4gdJgmqKj0lVVXAGozTfAIIMthx7OoqmHpm0bs4Q/0v3083Mr+opSOCpgXMMlC9xXLfi8=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAShZOxANg1T=9eGgN1MYRVP3qC1n6i8QO07CChPuge-aA@mail.gmail.com>
References: <1523500291-24008-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNAShZOxANg1T=9eGgN1MYRVP3qC1n6i8QO07CChPuge-aA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 25 Apr 2018 00:44:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARyMHSq-sCiJJem3twr-5YeGq4eyZqYXN+n5G1JUfzUfw@mail.gmail.com>
Message-ID: <CAK7LNARyMHSq-sCiJJem3twr-5YeGq4eyZqYXN+n5G1JUfzUfw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: uniphier: fix input delay value for legacy
 mode of eMMC
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-12 13:45 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2018-04-12 11:31 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> The property of the legacy mode for the eMMC PHY turned out to
>> be worng.  Some eMMC devices are unstable due to the set-up/hold
>> timing violation.  Correct the delay value.
>
> Reminder for myself:
>   Fix a type  worng -> wrong
>

Applied to linux-uniphier.


-- 
Best Regards
Masahiro Yamada
