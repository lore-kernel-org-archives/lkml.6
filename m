Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971434AbeEXUR3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:17:29 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35592 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032503AbeEXURV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:17:21 -0400
X-Google-Smtp-Source: AB8JxZoCOXHu9R+cooHZ5yPQ9BYCvu06pyVgTYdej/yk0cJKnbbrocqDUxMpW5rwCTqJQWRaDZ7PkTzh2368qecL5rQ=
MIME-Version: 1.0
In-Reply-To: <20180524193449.jql27apudwaevwpf@tarshish>
References: <CA+Kvs9=mgW4Z=UcBZZLL82fJ=c--OXF3=B2Zbho+CfMTr8Wk-Q@mail.gmail.com>
 <20180524193449.jql27apudwaevwpf@tarshish>
From: Ramon Fried <ramon.fried@gmail.com>
Date: Thu, 24 May 2018 23:17:19 +0300
Message-ID: <CA+Kvs9=x4kxkj-amni+E_KVjH2qjq_mXU88Dr-x5NNyz64gfuA@mail.gmail.com>
Subject: Re: uImage target support on arm64
To: Baruch Siach <baruch@tkos.co.il>
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 10:34 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Ramon,
>
> On Thu, May 24, 2018 at 10:05:15PM +0300, Ramon Fried wrote:
>> I've noticed that it's not supported.
>> Is it on purpose ?
>
> Yes. The 32bit load address in the uImage header in pretty limited when
> applied to 64bit ARM64. Even for ARM zImage is the preferred kernel format for
> quite some time now, since it allows flexible load address, as well as
> multi-platform kernels.
Hi Baruch.
I though that in terms of U-boot, the new FIT image is the preferred
kernel format.
Thanks,
Ramon.
>
>> If not I'll be happy to add support for: make uImage
>> for arm64 targets.
>
> baruch
>
> --
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
