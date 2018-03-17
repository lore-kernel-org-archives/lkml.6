Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbeCQRQy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:16:54 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:60800 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbeCQRQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:16:52 -0400
Date: Sat, 17 Mar 2018 13:16:31 -0400
From: Rich Felker <dalias@libc.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: jacopo mondi <jacopo@jmondi.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 2/4] sh: ecovec24: conditionally register backlight device
Message-ID: <20180317171631.GV1436@brightrain.aerifal.cx>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
 <20180315224202.96668-3-dmitry.torokhov@gmail.com>
 <20180316100748.GH16424@w540>
 <20180316233800.GA32310@dtor-ws>
 <20180317092516.g5p5ybka57abyhex@apu3b>
 <02834805-5053-4BDC-9256-DF1AFFEC8630@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02834805-5053-4BDC-9256-DF1AFFEC8630@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 07:21:17PM +0900, John Paul Adrian Glaubitz wrote:
> 
> 
> > On Mar 17, 2018, at 6:25 PM, jacopo mondi <jacopo@jmondi.org> wrote:
> > 
> > Hi Dmitry,
> > 
> >> On Fri, Mar 16, 2018 at 04:38:00PM -0700, Dmitry Torokhov wrote:
> >> Hi Jacopo,
> >> 
> >>> On Fri, Mar 16, 2018 at 11:07:48AM +0100, jacopo mondi wrote:
> >>> Hello Dmitry
> >>> 
> >>> FYI I am brushing the ecovec board these days as well
> >>> https://www.spinics.net/lists/linux-sh/msg52536.html
> >>> 
> >> 
> >> What is the ecovec board BTW? Is it some devkit or what? It seems quite
> >> old to me.
> > 
> > Yes, it is a SuperH 4 based development board. It is old for sure. I'm
> > also working on removing some stuff the ecovec board file is the only
> > user of...
> 
> Umh, but I’m still using the SH7724 Evovec board. Please don’t
> remove support for that.
> 
> The SuperH port of the Linux kernel is still maintained.

Thanks. At some point it would be nice to remove the board file, but
only once the conversion to device tree happens. If anyone has a list
of boards that people are still using or have access to and who can do
testing, it would be nice to compile that somewhere so we can figure
out what needs to be tested and who can test it.

Rich
