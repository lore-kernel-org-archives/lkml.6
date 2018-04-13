Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeDMQ0u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:26:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37595 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeDMQ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:26:48 -0400
X-Google-Smtp-Source: AIpwx48x9lZ5YC/6zU8WcC970xVCmrISJkJ907vg9e++62YSVqfa5YdoJ+sXFfm8bn8zC+v4ciliug==
Date: Fri, 13 Apr 2018 17:26:44 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Simon Horman <horms@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-pwm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND] backlight: pwm_bl: don't use GPIOF_* with
 gpiod_get_direction
Message-ID: <20180413162644.bej6yrgmqc2y3nfe@holly.lan>
References: <20180410123241.25745-1-wsa+renesas@sang-engineering.com>
 <20180411073215.fzvh4ejj2kd7wam3@verge.net.au>
 <20180413160824.GD31310@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413160824.GD31310@phenom.ffwll.local>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 06:08:24PM +0200, Daniel Vetter wrote:
> On Wed, Apr 11, 2018 at 09:32:16AM +0200, Simon Horman wrote:
> > On Tue, Apr 10, 2018 at 02:32:40PM +0200, Wolfram Sang wrote:
> > > The documentation was wrong, gpiod_get_direction() returns 0/1 instead
> > > of the GPIOF_* flags. The docs were fixed with commit 94fc73094abe47
> > > ("gpio: correct docs about return value of gpiod_get_direction"). Now,
> > > fix this user (until a better, system-wide solution is in place).
> > > 
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> > 
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > > ---
> > > 
> > > Changes since V1:
> > > 	* rebased to top-of-linus-tree
> > > 	* added tag from Daniel, thanks!
> > > 
> > > Through which tree does this need to go?
> 
> I think Daniel Thompson has one ...

Sorry, I didn't spot the question at the bottom of the change block. 
For backlight patches generally go though Lee Jones' tree.


Daniel.
