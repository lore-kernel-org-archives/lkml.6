Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeC2OVn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:21:43 -0400
Received: from muru.com ([72.249.23.125]:34338 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbeC2OVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:21:41 -0400
Date: Thu, 29 Mar 2018 07:21:37 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Dan Williams <dcbw@redhat.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Message-ID: <20180329142137.GO5700@atomide.com>
References: <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329140948.GA27473@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180329140948.GA27473@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180329 14:11]:
> Hi!
> 
> > Meanwhile, I can try to make voice calls more reproducable with
> > qmi or MM for example instead of just n_gsm.. And then I'll try
> > to fix my n_gsm pile of hacks for posting..
> 
> If you get something to work, that will be great.

Yeah I need to at least fix a n_gsm message handling issue that
currently causes retries and the retries have to be set artificially
high right now to avoid timeouts.. Right now each at command takes
about 30 seconds.. So I can't do any short calls :)

> If you get ofonod to work, that would be even better :-). [That's what
> Jolla uses, and that's what I have graphical clients for].

OK, I'll stick to picocom, qmicli and mmcli for now :)

> Oh and.. if you have reasonable windowing system, let me know.

I've been just using xorg and i3.

Regards,

Tony
