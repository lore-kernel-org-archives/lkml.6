Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeDLPDL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:03:11 -0400
Received: from muru.com ([72.249.23.125]:36476 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752746AbeDLPDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:03:10 -0400
Date: Thu, 12 Apr 2018 08:03:06 -0700
From: Tony Lindgren <tony@atomide.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Ladislav Michl <ladis@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Roger Quadros <rogerq@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>
Subject: Re: [Bug]: mtd: onenand: omap2plus: kernel panic with OneNAND on
 OMAP3 (DM3730) device GTA04A5
Message-ID: <20180412150306.GB5700@atomide.com>
References: <5D496D5C-4E3E-47B4-9981-E8F4C348DE00@goldelico.com>
 <20180410205643.GA2228@lenoch>
 <AF1CE94F-FE95-49B1-99FF-AEC0C3EFFCA1@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AF1CE94F-FE95-49B1-99FF-AEC0C3EFFCA1@goldelico.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [180411 07:05]:
> > Am 10.04.2018 um 22:56 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > Well, that's a shame... However, this code is in production for several
> > months now,
> 
> Well, we could have tested earlier release-candidates...

I've found it's way easier to test Linux next on regular basis
and report the regressions compared to chasing regressions after
the merge window or tagged kernels. By that time you may have
already multiple regressions to deal with which is always fun.

If you have products running with mainline kernel, maybe set up
automated boot testing for core devices to catch regressions
early?

Regards,

Tony
