Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeDRKDl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:03:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57753 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeDRKDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:03:39 -0400
Date: Wed, 18 Apr 2018 12:03:27 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>, quentin.schulz@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 11/11] ARM: shmobile: Convert file to use cntvoff
Message-ID: <20180418120327.0f707abf@dell-desktop.home>
In-Reply-To: <CAMuHMdU9soQuNMC59Y2AQdTmXbWBz-P3EFfZ6NYGKukJVukKgg@mail.gmail.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
        <20180416215032.5023-12-mylene.josserand@bootlin.com>
        <CAMuHMdU9soQuNMC59Y2AQdTmXbWBz-P3EFfZ6NYGKukJVukKgg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 18 Apr 2018 11:36:27 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Mylène,
> 
> On Mon, Apr 16, 2018 at 11:50 PM, Mylène Josserand
> <mylene.josserand@bootlin.com> wrote:
> > Now that a common function is available for CNTVOFF's
> > initialization, let's convert shmobile-apmu code to use
> > this function.  
> 
> Thanks for your patch, works fine on Renesas ALT with R-Car E2,
> which suffers from lack of CNTVOFF initialization.

Great to know that it works on this board.

> 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>  
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Thank you again for testing it :)

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
