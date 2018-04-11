Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeDKJYq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:24:46 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45834 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeDKJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:24:42 -0400
X-Google-Smtp-Source: AIpwx48anbQHVvMW/NprtcUgF3KybMrzgf32XppDCVzDgtjuJ4TpVNYOHtYcUC0TVssh+qhe7a/qozWCuP7+wyC2FIc=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a146q8+Y0XKsPUD7ZW4qHoUetpkupfqVOWPxBi6ruwQSw@mail.gmail.com>
References: <20180222050324.21531-1-joel@jms.id.au> <CACPK8XeD354AGXVunToR=RGQuSKWZ8vKSXH+DZey+udEE-Am_A@mail.gmail.com>
 <CAK8P3a146q8+Y0XKsPUD7ZW4qHoUetpkupfqVOWPxBi6ruwQSw@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Apr 2018 18:54:20 +0930
X-Google-Sender-Auth: 5FytKQ2_6vgbpgK-OH02zPHWTVc
Message-ID: <CACPK8XdX8d_=YVndzJLkt6rrA7S0NEBZ-ZZ2tg-nrrg=+CrMFA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update ASPEED entry with details
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-aspeed@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 April 2018 at 18:21, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Apr 11, 2018 at 6:06 AM, Joel Stanley <joel@jms.id.au> wrote:
>> Hey Arnd,
>>
>> On 22 February 2018 at 15:33, Joel Stanley <joel@jms.id.au> wrote:
>>> I am interested in all ASPEED drivers, and the previous match wasn't
>>> grabbing files in nested directories. Use N instead.
>>>
>>> Add the arm kernel mailing list so that patches get reviewed there, and
>>> the linux-aspeed list which exists only so I can use patchwork to track
>>> patches.
>>>
>>> Add Andrew as a reviewer, because he is involved in reviewing ASPEED
>>> stuff.
>>>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>
>> can you please pick this one up? It would be great to get it into
>> fixes as Andrew and I have been missing being cc'd on stuff we would
>> have like to review.
>
> Sure, applied to the fixes branch now.
>
> In general, when you want a patch to be applied, please send it to
> arm@kernel.org so we know it's for us. As a rule, I don't pick up patches
> otherwise but assume that you are asking for feedback and/or Acks
> but will resend it once everyone is happy with the change.

Okay. Do we have these rules written down anywhere?

If not, would you mind if I started a document on your behalf?

Cheers,

Joel
