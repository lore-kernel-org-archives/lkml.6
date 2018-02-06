Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeBFHh5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:37:57 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:5687 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeBFHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:37:50 -0500
X-IronPort-AV: E=Sophos;i="5.46,467,1511852400";
   d="scan'208";a="11195013"
Date: Tue, 6 Feb 2018 08:37:29 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND][PATCH] video: fbdev: atmel_lcdfb: convert to use GPIO
 descriptors
Message-ID: <20180206073729.GI2580@rfolt0960.corp.atmel.com>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fbdev@vger.kernel.org,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20180205084755.6011-1-ludovic.desroches@microchip.com>
 <CACRpkdajUDNkODAGU=6SHRJz-q5-+sFRy7Qi9=QLc-HF1NEHWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdajUDNkODAGU=6SHRJz-q5-+sFRy7Qi9=QLc-HF1NEHWQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 12:56:04PM +0100, Linus Walleij wrote:
> On Mon, Feb 5, 2018 at 9:47 AM, Ludovic Desroches
> <ludovic.desroches@microchip.com> wrote:
> 
> > Use GPIO descriptors instead of relying on the old method.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> Ah there it is :D
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> PS: why not move it all over to use DRI/DRM/KMS? It's becoming
> easier and easier.

It concerns old products, that's why it's not converted yet.

Regards

Ludovic

> 
> Yours,
> Linus Walleij
