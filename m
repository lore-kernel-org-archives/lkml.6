Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935749AbeCAHsa convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 02:48:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60469 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934908AbeCAHs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 02:48:27 -0500
Date: Thu, 1 Mar 2018 08:48:15 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com
Subject: Re: [PATCH v1 3/4] ASoC: codecs: pcm179x: Add reset gpio
Message-ID: <20180301084815.75b5aaaf@dell-desktop.home>
In-Reply-To: <20180227230200.67d8ae45@windsurf.lan>
References: <20180227212433.2189-1-mylene.josserand@bootlin.com>
        <20180227212433.2189-4-mylene.josserand@bootlin.com>
        <20180227230200.67d8ae45@windsurf.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 27 Feb 2018 23:02:00 +0100
Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

> Hello,
> 
> On Tue, 27 Feb 2018 22:24:32 +0100, Mylène Josserand wrote:
> > Add a reset gpio to be able to reset this line at startup.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>  
> 
> This needs an updated of the DT binding, since it's adding support for
> a new reset-gpios property.

True, I will add it in my new series.

> 
> Thanks!
> 
> Thomas

Thanks,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
