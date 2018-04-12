Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeDLEqs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 00:46:48 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:43112 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeDLEqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 00:46:47 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w3C4kZjA005622
X-Nifty-SrcIP: [209.85.213.41]
X-Google-Smtp-Source: AIpwx4+te4o9T6hhgfG8ja/1TWvvP129G1SgfBoqPDUpTpqACVELP0a7V9NY0vORWxSUsgiiXQzbwZTYuqaKJ9Ab428=
MIME-Version: 1.0
In-Reply-To: <1523500291-24008-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523500291-24008-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 12 Apr 2018 13:45:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAShZOxANg1T=9eGgN1MYRVP3qC1n6i8QO07CChPuge-aA@mail.gmail.com>
Message-ID: <CAK7LNAShZOxANg1T=9eGgN1MYRVP3qC1n6i8QO07CChPuge-aA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: uniphier: fix input delay value for legacy
 mode of eMMC
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-12 11:31 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The property of the legacy mode for the eMMC PHY turned out to
> be worng.  Some eMMC devices are unstable due to the set-up/hold
> timing violation.  Correct the delay value.

Reminder for myself:
  Fix a type  worng -> wrong



-- 
Best Regards
Masahiro Yamada
