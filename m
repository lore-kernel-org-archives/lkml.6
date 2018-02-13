Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933771AbeBMIa7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:30:59 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40446 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933631AbeBMIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:30:57 -0500
X-Google-Smtp-Source: AH8x225fdX4Q4ZFaOuisjdpFhn2/R4nejDcFeZZiwhWhfwYeYkc+tb0pUHjx4m5oW5QZanfCmU56RIBIvqCuT5FF8n0=
MIME-Version: 1.0
In-Reply-To: <20180205235757.246758-3-brendanhiggins@google.com>
References: <20180205235757.246758-1-brendanhiggins@google.com> <20180205235757.246758-3-brendanhiggins@google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Feb 2018 09:30:56 +0100
X-Google-Sender-Auth: ueAw6BmGN1CqDcjIVXr6DzuH_So
Message-ID: <CAK8P3a0SJTAkv7_QtDW1sDWFDYHw8tFWZqO6EMwpZ_5KPbhq3Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] arm: dts: add Nuvoton NPCM750 device tree
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>, tmaimon77@gmail.com,
        avifishman70@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
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

On Tue, Feb 6, 2018 at 12:57 AM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
> specific device tree for the NPCM750 (Poleg) evaluation board.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
> Tested-by: Avi Fishman <avifishman70@gmail.com>
...
> +               enable-method = "nuvoton,npcm7xx-smp";

I see this has already been reviewed quite a bit, but I'm curious
about the 'npcm7xx'
part here. Shouldn't that be a real chip name rather than a wildcard?

       Arnd
