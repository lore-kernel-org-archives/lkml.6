Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933738AbeD0PHt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:07:49 -0400
Received: from gloria.sntech.de ([95.129.55.99]:37004 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933389AbeD0PHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:07:47 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: remove unused auo_k190xfb drivers
Date: Fri, 27 Apr 2018 17:07:41 +0200
Message-ID: <3959140.hnfON7x99k@phil>
In-Reply-To: <6386409.PTMV4p8OHo@amdc3058>
References: <CGME20180427110425eucas1p12aca3b573a6c3fc4b51da9d5d34b3cec@eucas1p1.samsung.com> <6386409.PTMV4p8OHo@amdc3058>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 27. April 2018, 13:04:24 CEST schrieb Bartlomiej Zolnierkiewicz:
> auo_k1900fb and auo_k1901fb drivers have been introduced six
> years ago by following commits:
> 
> commit 2c8304d3125b ("video: auo_k190x: add code shared by controller drivers")
> commit 96b1d500e028 ("video: auo_k190x: add driver for AUO-K1900 variant")
> commit 53027cdf2a67 ("video: auo_k190x: add driver for AUO-K1901 variant")
> 
> They never had any in-kernel user so just remove them (since
> they are platform drivers they need corresponding platform
> devices to be registered by kernel and it has never happened).
> 
> Cc: Heiko Stübner <heiko@sntech.de>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

While I still hold the ereaders using these controllers in high regard
as my first kernel hacking project, reality is that I don't think I'll
ever continue on trying to mainline these and if later someone wants
to resurrect these (very old now) devices, they'll probably need a drm-
driver anyway. So for the removal

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko
