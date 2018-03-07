Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754416AbeCGOey convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:34:54 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38622 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbeCGOev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:34:51 -0500
Date: Wed, 7 Mar 2018 15:34:49 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, lgirdwood@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, michael@amarulasolutions.com
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for PCM1789
Message-ID: <20180307153449.18769094@dell-desktop.home>
In-Reply-To: <20180305155938.GL8588@sirena.org.uk>
References: <20180305124817.7421-1-mylene.josserand@bootlin.com>
        <20180305124817.7421-2-mylene.josserand@bootlin.com>
        <20180305154910.GJ8588@sirena.org.uk>
        <20180305155715.GJ3035@piout.net>
        <20180305155938.GL8588@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Thanks for the review.

On Mon, 5 Mar 2018 15:59:38 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Mar 05, 2018 at 04:57:15PM +0100, Alexandre Belloni wrote:
> > On 05/03/2018 at 15:49:10 +0000, Mark Brown wrote:  
> 
> > > Please don't mix C and C++ style comments in a single comment like this
> > > - it looks unintentional.  Just use the same style for the whole thing.
> > > You also don't need to include all the boilerplate with the SPDX header.  
> 
> > I think Linus made it clear that he wants the SPDX header to be a
> > C++ comment, the documentation has:  
> 
> Sure, so make the entire thing a C++ comment then.

Ok, I saw other drivers with this mix C++/C comment code so I wrote it
like this but no problem using only C++ comment.

I will send a v3 with this modification only (except if I have other
reviews).

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
