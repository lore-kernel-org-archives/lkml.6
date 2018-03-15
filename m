Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeCOG12 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:27:28 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:34739 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOG11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:27:27 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w2F6RMZg001949
X-Nifty-SrcIP: [209.85.217.175]
X-Google-Smtp-Source: AG47ELtCqy1eSSfR3XZtPKE59VQdrdFMl8VbPAhHiTxtVxy4jkny2pPclfUF916XXLHvIMXRqZuOPrp3VQwI7Iur4kw=
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1803141324420.28583@knanqh.ubzr>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
 <1521045861-22418-3-git-send-email-yamada.masahiro@socionext.com> <nycvar.YSQ.7.76.1803141324420.28583@knanqh.ubzr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 15 Mar 2018 15:26:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQMLA9-wOJ5Tgr1tuOTox33544cty3rVzAxvvyGQgs5Dg@mail.gmail.com>
Message-ID: <CAK7LNAQMLA9-wOJ5Tgr1tuOTox33544cty3rVzAxvvyGQgs5Dg@mail.gmail.com>
Subject: Re: [PATCH 2/7] kbuild: touch autoksyms.h when it is really missing
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-15 2:26 GMT+09:00 Nicolas Pitre <nicolas.pitre@linaro.org>:
> On Thu, 15 Mar 2018, Masahiro Yamada wrote:
>
>> From the comment, I expect this code creates autoksyms.h in case it
>> is missing, but it actually touches it when it does exists.
>
> Oops, indeed.
>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> I do not know when this code is useful...
>>
>> If autoksyms.h were missing, build should have already failed because
>> include/{linux,asm-generic}/export.h need it.
>>
>> Maybe for standalone test?
>> Or, in order to make this script self-contained?
>
> I agree it isn't very useful. Proof: it was wrong and wouldn't have
> worked as intended. So the best fix might be to simply remove that line.
>

OK, I will remove the code.




-- 
Best Regards
Masahiro Yamada
