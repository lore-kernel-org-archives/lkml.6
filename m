Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbeEURf2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:35:28 -0400
Received: from muru.com ([72.249.23.125]:43842 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753263AbeEURfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:35:24 -0400
Date: Mon, 21 May 2018 10:35:19 -0700
From: Tony Lindgren <tony@atomide.com>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
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
Message-ID: <20180521173519.GA98604@atomide.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518210954.29044-1-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180518 14:12]:
> Scope of the change is limited to GPIO pins used by board specific
> device drivers which will be updated by follow-up patches of the
> series. Those are some OMAP GPIO (gpio-0-15) and most of Amstrad Delta
> latch2 GPIO bank pins. Remaining pins of those banks, as well as
> Amstrad Delta latch1 pins, will be addressed later.
> 
> Assign a label ("latch2") to the bank, enumerate its pins and put that
> information, together with OMAP GPIO bank pins, in GPIO lookup tables.
> Assign lookup tables to devices as soon as those devices are registered
> and their names can be obtained.
> 
> A step froward in:
> - removal of hard-coded GPIO numbers from drivers,
> - removal of board mach includes from drivers,
> - switching to dynamically assigned GPIO numbers.

Is this first patch safe for me to apply separately?

Regards,

Tony
