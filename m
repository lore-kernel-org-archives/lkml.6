Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeDKHox convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:44:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42374 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbeDKHov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:44:51 -0400
Date: Wed, 11 Apr 2018 09:44:46 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
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
Subject: Re: [PATCH v5 07/13] ARM: smp: Add initialization of CNTVOFF
Message-ID: <20180411094446.468c7f99@dell-desktop.home>
In-Reply-To: <CAMuHMdUoUVF+WYrPG1Dx515_de_2nhGhLfn9+tJUm5jgs1uz0w@mail.gmail.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
        <20180403061836.3926-8-mylene.josserand@bootlin.com>
        <06308f46-ce7c-ddeb-ebca-abd1153138ba@arm.com>
        <20180404155909.148085f7@dell-desktop.home>
        <86vad7qc21.wl-marc.zyngier@arm.com>
        <CAMuHMdUoUVF+WYrPG1Dx515_de_2nhGhLfn9+tJUm5jgs1uz0w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 9 Apr 2018 10:24:41 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Wed, Apr 4, 2018 at 4:30 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On Wed, 04 Apr 2018 14:59:09 +0100,
> > Mylčne Josserand wrote:  
> 
> [Marc: stuck in ISO-8859-1? ;-]
> 
> >> > It'd be good to take this opportunity to refactor the shmobile code.  
> >>
> >> I can do it in this series but I do not have any shmobile platforms so
> >> I will not be able to test my modifications (only compilation).
> >>
> >> If someone can test it for me (who?), it is okay for me to refactor this
> >> code :)  
> >
> > I guess you could Cc the shmobile folks (Geert Uytterhoeven, Simon
> > Horman), and get them to review/test the changes.  
> 
> Correct. I can test on a remote R-Car E2 ALT board that needs it.

Great, thank you!

I will add you in CC in my next version, then.

Best regards,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
