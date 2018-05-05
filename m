Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeEEKge (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:36:34 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:42736 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeEEKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:36:32 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w45Aa9uP006382
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AB8JxZr6WF4yQVaBqPkwmFksn6vlnk07b0RfyP9YIvR4WL0lJkWBmklCcF2iJ4M/FkRJ+93dBkFxsMs2gzXT/3Ars+c=
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnjgEWDo8vjOiAS_TsEoJFZZagJgaqBAdW99L-Nkr9BxA@mail.gmail.com>
References: <20180426212807.196279-1-ndesaulniers@google.com> <CAKwvOdnjgEWDo8vjOiAS_TsEoJFZZagJgaqBAdW99L-Nkr9BxA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 5 May 2018 19:35:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNATHTAa+g3-Cud6iorgo-1riMzp07dmnXpk9XVmcZPuX9Q@mail.gmail.com>
Message-ID: <CAK7LNATHTAa+g3-Cud6iorgo-1riMzp07dmnXpk9XVmcZPuX9Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: gcov: enable -fno-tree-loop-im if supported
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Prasad Sodagudi <psodagud@quicinc.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-27 6:41 GMT+09:00 Nick Desaulniers <ndesaulniers@google.com>:
> Hi Masahiro and Michal,
>
> The reporter has asked for their email address to be updated to:
>
> psodagud@codeaurora.org
>
> if you're ok with this version of the patch and choose to apply it, can you
> please update the commit message. Otherwise, I'll make this change should
> we need other changes necessitating a v2.
> On Thu, Apr 26, 2018 at 2:29 PM Nick Desaulniers <ndesaulniers@google.com>
> wrote:
>
>> Clang does not recognize this compiler option.
>
>> Reported-by: Prasad Sodagudi <psodagud@quicinc.com>
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to linux-kbuild
with the reporter's email address updated.

Thanks!




-- 
Best Regards
Masahiro Yamada
