Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeFES7z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:59:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55261 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751941AbeFES7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:59:54 -0400
Date: Tue, 5 Jun 2018 20:59:52 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        kernel@collabora.com, linux-rtc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH 5/9] rtc: cros-ec: Switch to SPDX identifier.
Message-ID: <20180605185952.GG4637@piout.net>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
 <20180605092209.22887-6-enric.balletbo@collabora.com>
 <20180605094626.GC4637@piout.net>
 <39af6363-ce08-a227-f66a-4c7bd4916596@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39af6363-ce08-a227-f66a-4c7bd4916596@collabora.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2018 20:51:06+0200, Enric Balletbo i Serra wrote:
> Hi Alexandre,
> 
> On 05/06/18 11:46, Alexandre Belloni wrote:
> > On 05/06/2018 11:22:05+0200, Enric Balletbo i Serra wrote:
> >> Adopt the SPDX license identifier headers to ease license compliance
> >> management.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>
> >>  drivers/rtc/rtc-cros-ec.c | 21 +++++----------------
> >>  1 file changed, 5 insertions(+), 16 deletions(-)
> >>
> > Applied, thanks.
> > 
> 
> Looks like all the ChromeOS drivers should be licensed as GPL v2 only. There was
> a mismatch between what the header says and the MODULE_LICENSE and I wrongly
> assumed that the MODULE_LICENSE is the one I should follow. So could you not
> apply this patch for now and I'll send another version with the correct license?
> 

Hum, ok, this seemed to be the correct way to solve the mismatch to me.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
