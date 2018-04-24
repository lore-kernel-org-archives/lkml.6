Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933074AbeDXIld (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:41:33 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:60068 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933061AbeDXIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:41:29 -0400
Date: Tue, 24 Apr 2018 10:41:25 +0200
From: Simon Horman <horms@verge.net.au>
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH RESEND] backlight: pwm_bl: don't use GPIOF_* with
 gpiod_get_direction
Message-ID: <20180424084124.6tpxf3ekadzefwd4@verge.net.au>
References: <20180410123241.25745-1-wsa+renesas@sang-engineering.com>
 <20180411073215.fzvh4ejj2kd7wam3@verge.net.au>
 <20180416091257.swbt7i6zjfbwysg2@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416091257.swbt7i6zjfbwysg2@dell>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 10:12:57AM +0100, Lee Jones wrote:
> On Wed, 11 Apr 2018, Simon Horman wrote:
> 
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
> 
> Thanks for the Reviewed-by Simon.  I have applied it to the original mail.
> 
> Do you know why you mail wasn't sent attached to the original thread?
> For some reason I received this mail on it's own i.e. not in reply
> to the original.

No, not off hand. Perhaps I responded to the email in some unusual way
but by now I don't recall. In any case I'll try to be more careful
in future.
