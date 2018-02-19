Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeBSKnO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:43:14 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:58659 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeBSKnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:43:12 -0500
Date: Mon, 19 Feb 2018 11:43:10 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: wens@csie.org, linux@armlinux.org.uk, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v3 5/7] arm: dts: sun8i: a83t: Add CCI-400 node
Message-ID: <20180219114310.6b60b775@dell-desktop.home>
In-Reply-To: <20180219084944.iqrdzhpl63gdf6wy@flea.lan>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
        <20180219081837.15482-6-mylene.josserand@bootlin.com>
        <20180219084944.iqrdzhpl63gdf6wy@flea.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Feb 2018 09:49:44 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi,
> 
> On Mon, Feb 19, 2018 at 09:18:35AM +0100, Mylène Josserand wrote:
> > +				interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;  
> 
> You should align these blocks on the first one in the array.

Yep, thanks.

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
