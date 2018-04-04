Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeDDNta convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:49:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49311 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbeDDNt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:49:28 -0400
Date: Wed, 4 Apr 2018 15:49:16 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>, quentin.schulz@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 01/13] ARM: move cputype definitions into another
 file
Message-ID: <20180404154916.66870e98@dell-desktop.home>
In-Reply-To: <4ba0f1c4-a52a-b9f5-67ac-bf348a13228a@gmail.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
        <20180403061836.3926-2-mylene.josserand@bootlin.com>
        <CAGb2v64GL=1UcYs1tFp-mS07vbHBao82SEhyzUrUHB++2-EKBg@mail.gmail.com>
        <4ba0f1c4-a52a-b9f5-67ac-bf348a13228a@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Florian,

On Tue, 3 Apr 2018 12:56:30 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 04/02/2018 11:52 PM, Chen-Yu Tsai wrote:
> > On Tue, Apr 3, 2018 at 2:18 PM, Mylène Josserand
> > <mylene.josserand@bootlin.com> wrote:  
> >> To add the support for SMP on sun8i-a83t, we will use some
> >> definitions in an assembly file so move definitions into
> >> another file to separate C functions and macro defintions.  
> > 
> > Instead of moving the definitions, you could guard all the C
> > stuff in "#ifndef __ASSEMBLY__". AFAIK a few header files do that.  
> 
> Which is effectively what this patch does (still waiting for an ACK):
> 
> https://patchwork.kernel.org/patch/10239855/

Thanks for pointing out this existing patch.
I will use it for my next series and add my Tested-by (once tested, of
course).

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

> 
> > 
> > ChenYu
> >   
> >> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> >> ---
> >>  arch/arm/include/asm/cputype.h     | 94 +-----------------------------------
> >>  arch/arm/include/asm/cputype_def.h | 98 ++++++++++++++++++++++++++++++++++++++  
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >   
> 
> 
