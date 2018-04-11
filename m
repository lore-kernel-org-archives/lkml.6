Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeDKMFa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:05:30 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45005 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbeDKMF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:05:29 -0400
X-Google-Smtp-Source: AIpwx49bNy8TNUJIbAEL8wQKH33f2MrTSy+ETEKDXrs7A2eSgKZu+xgEYIBpsh/bVyTC5XqoWBT7EZAagGcfhUXn9Pk=
MIME-Version: 1.0
In-Reply-To: <CACPK8XdX8d_=YVndzJLkt6rrA7S0NEBZ-ZZ2tg-nrrg=+CrMFA@mail.gmail.com>
References: <20180222050324.21531-1-joel@jms.id.au> <CACPK8XeD354AGXVunToR=RGQuSKWZ8vKSXH+DZey+udEE-Am_A@mail.gmail.com>
 <CAK8P3a146q8+Y0XKsPUD7ZW4qHoUetpkupfqVOWPxBi6ruwQSw@mail.gmail.com> <CACPK8XdX8d_=YVndzJLkt6rrA7S0NEBZ-ZZ2tg-nrrg=+CrMFA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Apr 2018 14:05:27 +0200
X-Google-Sender-Auth: 3JOQuJ-chE6cEkOyPq7X4W0znU0
Message-ID: <CAK8P3a0WbC+=FNBRv57i1B4jff66aLHVW6m0cJaj8_36K+Gp2w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update ASPEED entry with details
To: Joel Stanley <joel@jms.id.au>
Cc: Olof Johansson <olof@lixom.net>, linux-aspeed@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 11:24 AM, Joel Stanley <joel@jms.id.au> wrote:
> On 11 April 2018 at 18:21, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Apr 11, 2018 at 6:06 AM, Joel Stanley <joel@jms.id.au> wrote:
>>
>> Sure, applied to the fixes branch now.
>>
>> In general, when you want a patch to be applied, please send it to
>> arm@kernel.org so we know it's for us. As a rule, I don't pick up patches
>> otherwise but assume that you are asking for feedback and/or Acks
>> but will resend it once everyone is happy with the change.
>
> Okay. Do we have these rules written down anywhere?
>
> If not, would you mind if I started a document on your behalf?

Please go ahead, we can definitely use something in Documentation/arm/
that explains our process, we don't really have anything written.

      Arnd
