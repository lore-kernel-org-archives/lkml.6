Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbeEUSKh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:10:37 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36251 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753275AbeEUSKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:10:34 -0400
X-Google-Smtp-Source: AB8JxZoGi/m4Ev2y3V2mVH9puTflB7DqMWl3ifr3UlKLzQgpYUM1w65mcyGIoRZdwTvUTKa6gz7E7Q==
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Richard Weinberger <richard@nod.at>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/6] ARM: OMAP1: ams-delta: add GPIO lookup tables
Date: Mon, 21 May 2018 20:10:44 +0200
Message-ID: <2148445.bqG5QPj1MO@z50>
In-Reply-To: <20180521173519.GA98604@atomide.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com> <20180521173519.GA98604@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, May 21, 2018 7:35:19 PM CEST Tony Lindgren wrote:
> Hi,
> 
> * Janusz Krzysztofik <jmkrzyszt@gmail.com> [180518 14:12]:
> > Scope of the change is limited to GPIO pins used by board specific
> > device drivers which will be updated by follow-up patches of the
> > series. Those are some OMAP GPIO (gpio-0-15) and most of Amstrad Delta
> > latch2 GPIO bank pins. Remaining pins of those banks, as well as
> > Amstrad Delta latch1 pins, will be addressed later.
> > 
> > Assign a label ("latch2") to the bank, enumerate its pins and put that
> > information, together with OMAP GPIO bank pins, in GPIO lookup tables.
> > Assign lookup tables to devices as soon as those devices are registered
> > and their names can be obtained.
> > 
> > A step froward in:
> > - removal of hard-coded GPIO numbers from drivers,
> > - removal of board mach includes from drivers,
> > - switching to dynamically assigned GPIO numbers.
> 
> Is this first patch safe for me to apply separately?

Absolutely, it is.

Thanks,
Janusz
