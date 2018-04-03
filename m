Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbeDCH12 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:27:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37546 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754276AbeDCH10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:27:26 -0400
Date: Tue, 3 Apr 2018 09:27:24 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Russell King <linux@armlinux.org.uk>,
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
Message-ID: <20180403092724.607e8e37@dell-desktop.home>
In-Reply-To: <CAGb2v64GL=1UcYs1tFp-mS07vbHBao82SEhyzUrUHB++2-EKBg@mail.gmail.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
        <20180403061836.3926-2-mylene.josserand@bootlin.com>
        <CAGb2v64GL=1UcYs1tFp-mS07vbHBao82SEhyzUrUHB++2-EKBg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

Thank you for your review!

On Tue, 3 Apr 2018 14:52:45 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Tue, Apr 3, 2018 at 2:18 PM, Mylène Josserand
> <mylene.josserand@bootlin.com> wrote:
> > To add the support for SMP on sun8i-a83t, we will use some
> > definitions in an assembly file so move definitions into
> > another file to separate C functions and macro defintions.  
> 
> Instead of moving the definitions, you could guard all the C
> stuff in "#ifndef __ASSEMBLY__". AFAIK a few header files do that.

Oh, right. It is better with this check so I will use that in the next
iteration of my series.

Best regards,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com


> 
> ChenYu
> 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/include/asm/cputype.h     | 94 +-----------------------------------
> >  arch/arm/include/asm/cputype_def.h | 98 ++++++++++++++++++++++++++++++++++++++  
