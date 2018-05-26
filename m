Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031679AbeEZJ1L (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 05:27:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36323 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031655AbeEZJ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 05:27:07 -0400
Date: Sat, 26 May 2018 11:27:06 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: trivial@kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix a typo in RTC documentation for RTC_DRV_JZ4740
Message-ID: <20180526092706.GB3181@piout.net>
References: <20180523195814.568-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523195814.568-1-malat@debian.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2018 21:58:14+0200, Mathieu Malaterre wrote:
> Fix typo introduced for RTC_DRV_JZ4740 in commit 586655d278ba ("rtc:
> jz4740: make the driver buildable as a module again").
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/rtc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
