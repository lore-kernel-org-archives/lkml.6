Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeBKHqf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 02:46:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54767 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752224AbeBKHqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 02:46:33 -0500
X-UUID: b4de4f487d5a4116bf008fc674db19f4-20180211
Message-ID: <1518335184.9025.43.camel@mtkswgap22>
Subject: Re: [PATCH v2 5/7] watchdog: mtk: allow setting timeout in
 devicetree
From: Sean Wang <sean.wang@mediatek.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
CC: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date: Sun, 11 Feb 2018 15:46:24 +0800
In-Reply-To: <5449674d-2812-c9b5-9c06-af2fbfa72737@roeck-us.net>
References: <20180210091911.3644-1-marcus.folkesson@gmail.com>
         <20180210091911.3644-5-marcus.folkesson@gmail.com>
         <1518261002.9025.36.camel@mtkswgap22> <20180210124328.GB744@gmail.com>
         <20180210201207.GC744@gmail.com>
         <5449674d-2812-c9b5-9c06-af2fbfa72737@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-10 at 17:52 -0800, Guenter Roeck wrote:
> On 02/10/2018 12:12 PM, Marcus Folkesson wrote:
> > Hello Sean,
> > 
> > On Sat, Feb 10, 2018 at 01:43:28PM +0100, Marcus Folkesson wrote:
> >> Hello Sean,
> >>
> >> On Sat, Feb 10, 2018 at 07:10:02PM +0800, Sean Wang wrote:
> >>>
> >>> Hi, Marcus
> >>>
> >>> The changes you made for dt-bindings and driver should be put into
> >>> separate patches.
> >>
> >> I actually thought about it but chose to have it in the same patch because I
> >> did not see any direct advantage to separating them.
> >>
> >> But I can do that.
> >> I will come up with a v3 with this change if no one thinks differently.
> >>
> > 
> > When looking at the git log, I'm not that convinced it should be
> > separate patches.
> > 
> > For example, I found a4f741e3e157c3a5c8aea5f2ea62b692fbf17338 that is
> > doing the exact same thing as this patch.
> > 
> > There is plenty of patches that mixes the code change and dt bindings
> > updates.
> > Could it not be useful to overview both the implementation and
> > dt-mapping change in one view?
> > 
> > If you or anyone else still think it should be separated, please let me know and I will
> > come up with a v3.
> > 
> 
> If we were talking about something new, specifically new and unapproved DT bindings,
> it should be separate patches. However, that is not the case here. The DT bindings
> are well established. Sure, we could be pedantic and request a split into two
> patches. However, the only benefit of that would be more work for the maintainers,
> ie Wim and myself (including me having to send this e-mail). I don't really see
> the point of that.
> 
> I have already sent my Reviewed-by:, and I don't intend to withdraw it.
> 
Hi, both

Sorry for that if I caused any inconvenience to you. I didn't really
insist on if the patch is needed to split into two, which totally
depends on whether dt maintainers like it.

The change for dt-binding is usually added as a split patch with
dt-bindings as a prefix. This way I thought dt maintainers is not
easy to miss those patches and also can give some useful feedback
for them.

	Sean

> Thanks,
> Guenter
> 
