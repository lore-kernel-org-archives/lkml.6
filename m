Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeCNQoU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:44:20 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45662 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCNQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:44:17 -0400
X-Google-Smtp-Source: AG47ELttlyRHFeFxLVfsyFtclEIsa9XR9viC9maUGoNVuh6VbdjzbzUAPxM4oRmHF3Ay7PnGTLI+q6EYWV+Q+3iq5Ss=
MIME-Version: 1.0
In-Reply-To: <20180314163808.GA9201@ulmo>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180314153603.3127932-37-arnd@arndb.de>
 <20180314163808.GA9201@ulmo>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 17:44:16 +0100
X-Google-Sender-Auth: bW4ffzY237_siZdbchLdF55tdMY
Message-ID: <CAK8P3a3mp=iKq2MvL24wQvhjyhDDeu_ty50vpdcfSnXrSaxjPA@mail.gmail.com>
Subject: Re: [PATCH 36/47] pwm: remobe pwm-bfin driver
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 5:38 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Mar 14, 2018 at 04:35:49PM +0100, Arnd Bergmann wrote:
>> The blackfin architecture is getting removed, so this driver is now
>> obsolete as well.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/pwm/Kconfig    |   9 ---
>>  drivers/pwm/Makefile   |   1 -
>>  drivers/pwm/pwm-bfin.c | 157 -------------------------------------------------
>>  3 files changed, 167 deletions(-)
>>  delete mode 100644 drivers/pwm/pwm-bfin.c
>
> Do you want to apply this in a batch or do you want me to pick it up
> into the PWM tree?
>
> If you want to go for the former:
>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
>
> Otherwise, just let me know and I'll pick this up for v4.17.

Either way is fine with me, the other maintainers just provided
an Ack, and preferred me to keep the removal in one piece, so
i'll do the same here.

       Arnd
