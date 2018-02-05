Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeBENIe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:08:34 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:37689 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbeBENI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:08:27 -0500
X-Google-Smtp-Source: AH8x225dzlR9utSO/DuOVUQeCu5I0XbvlJjUB7oRx/nTcXb12a3tkM5MIND3+BO/sVSH9wCCu2IliNVSLt40LFL44NA=
MIME-Version: 1.0
In-Reply-To: <20180205113400.qpqdkpv5bbvdwg22@khazad-dum.debian.net>
References: <20180112110445.1876-1-dh.herrmann@gmail.com> <CAHp75Vc66ZfRmOoOKJRODpV0mS2aZru=b-r0cr8SKYH=hm+W6Q@mail.gmail.com>
 <CANq1E4RGo091oaG=0owKVfxOV8wR2qQ=nXfXzZsRxg6Q7_C8zw@mail.gmail.com>
 <20180113063309.iryfhufpilas3jnf@mthode.org> <20180205050116.isaz6pmgsquzjmqr@mthode.org>
 <20180205113400.qpqdkpv5bbvdwg22@khazad-dum.debian.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 5 Feb 2018 15:08:25 +0200
Message-ID: <CAHp75VfQ7fkt2u0G50LvaMH7GBqe2CwKG_J9E4gV27ZhsYFxoQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: suppress warning about palm detection
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Thode <mthode@mthode.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 1:34 PM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
>> > I'm fine with a signed-off-by or tested-by or suggested-by.  There is a
>> > spelling mistake though, 'hoveres' should be hovers.
>>
>> Is there anything else I can do here?  I'm not sure any of us have the
>> ability to find out what lenovo actualy wants this for.
>
> I have already acked the patch, so Darren or Andy should pick it up
> sooner or later for merging into the subsystem tree...
>
> But if you wouldn't mind doing so, you could send a V2 with all acks,
> tested-by/suggested-by/whatever added, as well as that minor spelling
> mistake correction...  I am not sure this is necessary, though.
>

> Andy, Daren?

The following one already in for-next, meaning it's about to be upstream soon
587d8628fb71 platform/x86: thinkpad_acpi: suppress warning about palm detection


-- 
With Best Regards,
Andy Shevchenko
