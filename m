Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934596AbeBMJaA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:30:00 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46500 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934218AbeBMJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:29:33 -0500
X-Google-Smtp-Source: AH8x226dug8rBHqLsu9W9/Kqegy6eeLDjm+D+BAiQ4b4NlCFV8nSjEeL8BqAIkz8thZzqkep2bSurvW/4XKuwXnDxpg=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0SJTAkv7_QtDW1sDWFDYHw8tFWZqO6EMwpZ_5KPbhq3Q@mail.gmail.com>
References: <20180205235757.246758-1-brendanhiggins@google.com>
 <20180205235757.246758-3-brendanhiggins@google.com> <CAK8P3a0SJTAkv7_QtDW1sDWFDYHw8tFWZqO6EMwpZ_5KPbhq3Q@mail.gmail.com>
From: Avi Fishman <avifishman70@gmail.com>
Date: Tue, 13 Feb 2018 11:29:32 +0200
Message-ID: <CAKKbWA6Otc1ZO_yHpfhxPjbgvvn-QXcXG9sy5=3FZDY8d_20rw@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] arm: dts: add Nuvoton NPCM750 device tree
To: Arnd Bergmann <arnd@arndb.de>
Cc: Brendan Higgins <brendanhiggins@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Feb 6, 2018 at 12:57 AM, Brendan Higgins
> <brendanhiggins@google.com> wrote:
>> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
>> specific device tree for the NPCM750 (Poleg) evaluation board.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
>> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
>> Tested-by: Avi Fishman <avifishman70@gmail.com>
> ...
>> +               enable-method = "nuvoton,npcm7xx-smp";
>
> I see this has already been reviewed quite a bit, but I'm curious
> about the 'npcm7xx'
> part here. Shouldn't that be a real chip name rather than a wildcard?
>
>        Arnd

There is a family of npcm7xx, some with SMP and some without.
For those who has it, it is common for all to use the same
"nuvoton,npcm7xx-smp".

Avi
