Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933612AbeCGPSg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:18:36 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40243 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753949AbeCGPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:18:35 -0500
X-Google-Smtp-Source: AG47ELsOkiQg9m4/jy9hohIeTF97GZaXPfPIA0toXKuNMrdB2FCzg1o132CUIGgCiHc+PcqyAS0UZg==
Date: Wed, 7 Mar 2018 15:18:31 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: groeck@chromium.org, gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH 1/6] mfd: cros_ec: fail early if we cannot identify the EC
Message-ID: <20180307151831.u65fryr4e7mbdwpe@dell>
References: <20180219224602.22582-1-enric.balletbo@collabora.com>
 <20180307151253.pytqvo55svirgc6z@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180307151253.pytqvo55svirgc6z@dell>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Mar 2018, Lee Jones wrote:

> On Mon, 19 Feb 2018, Enric Balletbo i Serra wrote:
> 
> > From: Vincent Palatin <vpalatin@chromium.org>
> > 
> > If we cannot communicate with the EC chip to detect the protocol version
> > and its features, it's very likely useless to continue. Else we will
> > commit all kind of uninformed mistakes (using the wrong protocol, the
> > wrong buffer size, mixing the EC with other chips).
> > 
> > Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> > Acked-by: Benson Leung <bleung@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >  drivers/mfd/cros_ec.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Unless it is my mailer that is playing up, it looks as though you have
> sent this set un-threaded, which means that when others or myself
> start replying to them one-by-one, they will be sprawled throughout my
> inbox.  It also seems as though there is no 0th (cover letter) patch,
> which means I am lacking potentially important information regarding
> the history of the set and what you are trying to achieve.
> 
> Anyway, the patch has been applied this time (hopefully there aren't
> any inter-dependencies.

As discussed in 2/6, I'm going to un-apply this.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
