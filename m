Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbeEQNqZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:46:25 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:53651 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752352AbeEQNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:46:22 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w4HDkAXV018389
X-Nifty-SrcIP: [209.85.217.181]
X-Google-Smtp-Source: AB8JxZqqh1/B7lQm4hVn6YJroRo+7lHhdJUaVsfcMGSo2SiWGPZ2KoN9I92rVeNGZc+h43XXoyIxRuhJYLGytUXR408=
MIME-Version: 1.0
In-Reply-To: <20180516172601.03188b22@canb.auug.org.au>
References: <20180515155038.7387bf2c@canb.auug.org.au> <CAK7LNASNMZbz=re1sRzh8Ffkt8g78=ddV7d_TZm4MVq1+JS-hA@mail.gmail.com>
 <20180516172601.03188b22@canb.auug.org.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 17 May 2018 22:45:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNATLOynDva0M4LkmubTY1492G_7uabREwiUEUh_rRkkruA@mail.gmail.com>
Message-ID: <CAK7LNATLOynDva0M4LkmubTY1492G_7uabREwiUEUh_rRkkruA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

2018-05-16 16:26 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Masahiro,
>
> On Wed, 16 May 2018 15:01:38 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>>
>> How should I handle your fix-up?
>>
>> May I squash into the original one if you ack to do it,
>> or is it better to keep it as a separate patch?
>
> Either way is fine by me, but the former reduces the bisection gap.  So
> it depends on whether you want to rebase your tree or not.
>
> Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
>

Thanks!  Squashed now.




> --
> Cheers,
> Stephen Rothwell



-- 
Best Regards
Masahiro Yamada
