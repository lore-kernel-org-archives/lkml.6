Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeDKIvd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:51:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42309 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeDKIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:51:30 -0400
X-Google-Smtp-Source: AIpwx49aPuYHG1SrCPHjzcoEsVcqBgzUp+Uz5NBcheSgkBGy+1wKaSoutbZDoJ6wdb3g8GdA5Rwc4DbD+gMxgHYd+OE=
MIME-Version: 1.0
In-Reply-To: <CACPK8XeD354AGXVunToR=RGQuSKWZ8vKSXH+DZey+udEE-Am_A@mail.gmail.com>
References: <20180222050324.21531-1-joel@jms.id.au> <CACPK8XeD354AGXVunToR=RGQuSKWZ8vKSXH+DZey+udEE-Am_A@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Apr 2018 10:51:29 +0200
X-Google-Sender-Auth: Cs7njtETuVU_LUkl5Sc0lrXvp2Y
Message-ID: <CAK8P3a146q8+Y0XKsPUD7ZW4qHoUetpkupfqVOWPxBi6ruwQSw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update ASPEED entry with details
To: Joel Stanley <joel@jms.id.au>
Cc: Olof Johansson <olof@lixom.net>, linux-aspeed@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 6:06 AM, Joel Stanley <joel@jms.id.au> wrote:
> Hey Arnd,
>
> On 22 February 2018 at 15:33, Joel Stanley <joel@jms.id.au> wrote:
>> I am interested in all ASPEED drivers, and the previous match wasn't
>> grabbing files in nested directories. Use N instead.
>>
>> Add the arm kernel mailing list so that patches get reviewed there, and
>> the linux-aspeed list which exists only so I can use patchwork to track
>> patches.
>>
>> Add Andrew as a reviewer, because he is involved in reviewing ASPEED
>> stuff.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> can you please pick this one up? It would be great to get it into
> fixes as Andrew and I have been missing being cc'd on stuff we would
> have like to review.

Sure, applied to the fixes branch now.

In general, when you want a patch to be applied, please send it to
arm@kernel.org so we know it's for us. As a rule, I don't pick up patches
otherwise but assume that you are asking for feedback and/or Acks
but will resend it once everyone is happy with the change.

      Arnd
