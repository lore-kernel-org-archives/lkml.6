Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeDIIYo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:24:44 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35272 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeDIIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:24:43 -0400
X-Google-Smtp-Source: AIpwx48j2haFINQEZ+zRTLl2Zl86CCARjuOr9XdmKrZ6hkiVXk0/tfFTXNyZKcglugbuDAVyRo7wayuT8Q471P3pI+8=
MIME-Version: 1.0
In-Reply-To: <86vad7qc21.wl-marc.zyngier@arm.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-8-mylene.josserand@bootlin.com> <06308f46-ce7c-ddeb-ebca-abd1153138ba@arm.com>
 <20180404155909.148085f7@dell-desktop.home> <86vad7qc21.wl-marc.zyngier@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Apr 2018 10:24:41 +0200
X-Google-Sender-Auth: VbCfh_ofHz29FMeWHoWD4Umd2nU
Message-ID: <CAMuHMdUoUVF+WYrPG1Dx515_de_2nhGhLfn9+tJUm5jgs1uz0w@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] ARM: smp: Add initialization of CNTVOFF
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>, quentin.schulz@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w398OmVd014160

On Wed, Apr 4, 2018 at 4:30 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Wed, 04 Apr 2018 14:59:09 +0100,
> Mylčne Josserand wrote:

[Marc: stuck in ISO-8859-1? ;-]

>> > It'd be good to take this opportunity to refactor the shmobile code.
>>
>> I can do it in this series but I do not have any shmobile platforms so
>> I will not be able to test my modifications (only compilation).
>>
>> If someone can test it for me (who?), it is okay for me to refactor this
>> code :)
>
> I guess you could Cc the shmobile folks (Geert Uytterhoeven, Simon
> Horman), and get them to review/test the changes.

Correct. I can test on a remote R-Car E2 ALT board that needs it.

P.S. Interestingly, none of the Renesas CA15 SoCs seem to suffer from it,
     only CA7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
