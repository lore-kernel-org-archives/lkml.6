Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeBAPQH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:16:07 -0500
Received: from mx2.mpynet.fi ([82.197.21.85]:13107 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeBAPQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:16:03 -0500
Message-ID: <1517498160.5907.6.camel@tuxera.com>
Subject: Re: [PATCH 1/2] ARM: dts: sunxi: Switch MMC nodes away from
 cd-inverted property
From: Tuomas Tynkkynen <tuomas@tuxera.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Thu, 1 Feb 2018 17:16:00 +0200
In-Reply-To: <20180104150352.rsvtvviafxyuq2jp@flea.lan>
References: <20171222205738.2389-1-tuomas@tuxera.com>
         <20180104150352.rsvtvviafxyuq2jp@flea.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, 2018-01-04 at 16:03 +0100, Maxime Ripard wrote:
> On Fri, Dec 22, 2017 at 10:57:37PM +0200, Tuomas Tynkkynen wrote:
> > Using the cd-inverted property is not useful when GPIOs are used as
> > card
> > detects since the polarity can be specified with the usual
> > GPIO_ACTIVE_(HIGH|LOW) GPIO flags. It has also caused confusion for
> > U-Boot developers, so migrate all sunxi boards away from cd-
> > inverted.
> > 
> > Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I was assuming these patches will go in through the sunxi tree but I
don't see them applied anywhere, have these patches fallen through the
cracks perhaps?
