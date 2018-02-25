Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeBYPUl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 10:20:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56907 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751558AbeBYPUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 10:20:38 -0500
Date: Sun, 25 Feb 2018 16:20:19 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v4 02/10] ARM: sun9i: smp: Rename clusters's power-off
 register
Message-ID: <20180225162019.3b2ae153@dell-desktop.home>
In-Reply-To: <20180223145650.dzhdhh2cprqioq5m@flea.lan>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
        <20180223133742.26044-3-mylene.josserand@bootlin.com>
        <20180223145650.dzhdhh2cprqioq5m@flea.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Feb 2018 15:56:50 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Fri, Feb 23, 2018 at 02:37:34PM +0100, Mylène Josserand wrote:
> > To prepare the support for sun8i-a83t, rename the variable name
> > that handles the power-off of clusters because it is different from
> > sun9i-a80 to sun8i-a83t.
> >
> > The power off register for clusters are different from SUN9I and SUN8I  
> 
> This is just a nitpick, and I see you use them everywhere, but sun8i
> and sun9i are the family of SoCs, and A80 and A83t the name of SoCs
> within their respective families.
> 
> So in your commit log, you want to support the A83t because it's
> different than the A80, and the sun9i and sun8i mentionned in your
> last sentence is not really meaningful.

True, I will pay attention next time.

> 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>  
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Maxime
> 

Thanks,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
