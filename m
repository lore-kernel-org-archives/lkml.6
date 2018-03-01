Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030789AbeCANkO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030701AbeCANkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:40:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F1D2177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELvk2RPKQuCVpsdEN2vnwINU5Xe4/eofCWtJQVwXg04V1QOV3hGf0FN3liu9LL4/9060xbW3/r2HI/W46thBt28=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQAZQAcTCL__RZoWTH-ROg3ZfPh1aEafcw6TS5vxAwNrA@mail.gmail.com>
References: <20180228233249.26281-1-robh@kernel.org> <20180228233249.26281-2-robh@kernel.org>
 <CAK7LNAQLq5MVhT5nZO_MTya7YhHee17UhJ7jnq51oeiJVL26QA@mail.gmail.com> <CAK7LNAQAZQAcTCL__RZoWTH-ROg3ZfPh1aEafcw6TS5vxAwNrA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Mar 2018 07:39:50 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+tDtR-fmqwQy3bGQecB=5ieL4jVrHct8L-mo23btvYTA@mail.gmail.com>
Message-ID: <CAL_Jsq+tDtR-fmqwQy3bGQecB=5ieL4jVrHct8L-mo23btvYTA@mail.gmail.com>
Subject: Re: [PATCH 1/6] kbuild: remove remaining use of undefined YACC_PREFIX
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 5:35 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Rob,
>
> 2018-03-01 13:20 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> 2018-03-01 8:32 GMT+09:00 Rob Herring <robh@kernel.org>:
>>> Commit eea199b445f6 ("kbuild: remove unnecessary LEX_PREFIX and
>>> YACC_PREFIX") removed YACC_PREFIX definition, but left one use of it. There
>>> was not any build error since there is no user of "cmd_bison_h" currently.
>>> Remove the last remaining occurrence of YACC_PREFIX.
>>>
>>> Fixes: eea199b445f6 ("kbuild: remove unnecessary LEX_PREFIX and YACC_PREFIX")
>>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>
>> You can replace CC with my
>>
>> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>
> I got a reason to send a fixes pull request this week.
>
> If you do not mind, may I include this one in
> my Kbuild fixes pull request?

Yes, please do.

>
> I do not see dependency between 1/6 and the rest of the series.

Only that dtc won't build without it. :)

Rob
