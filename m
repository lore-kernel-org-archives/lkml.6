Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967791AbeCALg3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:36:29 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:31319 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967540AbeCALg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:36:27 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w21BaLH9020891
X-Nifty-SrcIP: [209.85.217.181]
X-Google-Smtp-Source: AG47ELtOBTOv7FqLo1uYocJ9OhtyrqgNl9UgG7rpfyehscf0vLlJ5HFN6s6brDHlpQkhW8FV8vNwISO/UFwYwBJin0w=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQLq5MVhT5nZO_MTya7YhHee17UhJ7jnq51oeiJVL26QA@mail.gmail.com>
References: <20180228233249.26281-1-robh@kernel.org> <20180228233249.26281-2-robh@kernel.org>
 <CAK7LNAQLq5MVhT5nZO_MTya7YhHee17UhJ7jnq51oeiJVL26QA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Mar 2018 20:35:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQAZQAcTCL__RZoWTH-ROg3ZfPh1aEafcw6TS5vxAwNrA@mail.gmail.com>
Message-ID: <CAK7LNAQAZQAcTCL__RZoWTH-ROg3ZfPh1aEafcw6TS5vxAwNrA@mail.gmail.com>
Subject: Re: [PATCH 1/6] kbuild: remove remaining use of undefined YACC_PREFIX
To: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

2018-03-01 13:20 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2018-03-01 8:32 GMT+09:00 Rob Herring <robh@kernel.org>:
>> Commit eea199b445f6 ("kbuild: remove unnecessary LEX_PREFIX and
>> YACC_PREFIX") removed YACC_PREFIX definition, but left one use of it. There
>> was not any build error since there is no user of "cmd_bison_h" currently.
>> Remove the last remaining occurrence of YACC_PREFIX.
>>
>> Fixes: eea199b445f6 ("kbuild: remove unnecessary LEX_PREFIX and YACC_PREFIX")
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>
> You can replace CC with my
>
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


I got a reason to send a fixes pull request this week.

If you do not mind, may I include this one in
my Kbuild fixes pull request?

I do not see dependency between 1/6 and the rest of the series.



-- 
Best Regards
Masahiro Yamada
