Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754322AbeEaJlP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:41:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44434 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754274AbeEaJlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:41:12 -0400
Date: Thu, 31 May 2018 11:41:01 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sprd: Add new RTC power down check method
Message-ID: <20180531094101.GB2727@piout.net>
References: <ea3bed8a6cb9493a7b0162f144de8a5ee4f06777.1527757194.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea3bed8a6cb9493a7b0162f144de8a5ee4f06777.1527757194.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2018 17:18:08+0800, Baolin Wang wrote:
> We should use the new method to check if RTC was powered down, which
> is more solid. Since we have introduced power control and power status
> registers, and we just check if the power status is the default value
> (0x96), if yes that means the RTC has been powered down. Meanwhile We
> can set the power control register to be one valid value to change
> the power status to indicate RTC device is valid now.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/rtc/rtc-sc27xx.c |   47 +++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
