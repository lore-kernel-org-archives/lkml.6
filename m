Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeDLPvr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:51:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:23613 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbeDLPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:51:46 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN1EzmY
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Bug]: mtd: onenand: omap2plus: kernel panic with OneNAND on OMAP3 (DM3730) device GTA04A5
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180412150306.GB5700@atomide.com>
Date: Thu, 12 Apr 2018 17:51:31 +0200
Cc: Ladislav Michl <ladis@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Roger Quadros <rogerq@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E2D523A4-DE26-46B4-9D38-D95F518A7F74@goldelico.com>
References: <5D496D5C-4E3E-47B4-9981-E8F4C348DE00@goldelico.com> <20180410205643.GA2228@lenoch> <AF1CE94F-FE95-49B1-99FF-AEC0C3EFFCA1@goldelico.com> <20180412150306.GB5700@atomide.com>
To: Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Am 12.04.2018 um 17:03 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [180411 07:05]:
>>> Am 10.04.2018 um 22:56 schrieb Ladislav Michl <ladis@linux-mips.org>:
>>> Well, that's a shame... However, this code is in production for several
>>> months now,
>> 
>> Well, we could have tested earlier release-candidates...
> 
> I've found it's way easier to test Linux next on regular basis
> and report the regressions compared to chasing regressions after
> the merge window or tagged kernels. By that time you may have
> already multiple regressions to deal with which is always fun.
> 
> If you have products running with mainline kernel, maybe set up
> automated boot testing for core devices to catch regressions
> early?

Well, it is rare that we face upstream regressions of this severe
kind. Every 2-3 years... We much more often have to face missing
features in upstream so that we add our own patch sets on top
of each -rc.

In this case here we could have found this right after the merge window
when v4.16-rc1 came out. But by bad chance (and holidays and other
more important tasks) we did only test on GTA04 boards with standard
NAND. And just now did boot a board with OneNAND installed and were
surprised by this boot problem.

BR,
Nikolaus
