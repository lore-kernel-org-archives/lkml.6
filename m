Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeCFUUj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 15:20:39 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48333 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750797AbeCFUUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 15:20:38 -0500
Date: Tue, 6 Mar 2018 21:20:36 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 2/4] rtc: isl1208: switch to rtc_register_device
Message-ID: <20180306202036.GH3035@piout.net>
References: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
 <1520246373-19023-3-git-send-email-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520246373-19023-3-git-send-email-Denis.Osterland@diehl.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 at 10:43:53 +0000, Denis OSTERLAND wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> Fix possible race condition.
> It is not allowed to return with an error code after RTC is registered.
> 
> Suggested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/rtc/rtc-isl1208.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
