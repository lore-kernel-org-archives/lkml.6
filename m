Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeCVPWl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:22:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47369 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752961AbeCVPWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:22:21 -0400
Date: Thu, 22 Mar 2018 16:22:08 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver/rtc: remove a warning during scripts/kernel-doc
 step
Message-ID: <20180322152208.GV3417@piout.net>
References: <20180201164714.25709-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201164714.25709-1-malat@debian.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2018 at 17:47:14 +0100, Mathieu Malaterre wrote:
> During compilation using W=1 one would get:
> 
> drivers/rtc/systohc.c:11: info: Scanning doc for rtc_set_ntp_time
> drivers/rtc/systohc.c:23: warning: bad line:  (
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/rtc/systohc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
