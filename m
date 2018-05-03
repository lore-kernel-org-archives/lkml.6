Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeECUMi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:12:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38331 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeECUMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:12:36 -0400
Date: Thu, 3 May 2018 22:12:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc: sprd: Change to use devm_rtc_allocate_device()
Message-ID: <20180503201225.GB10960@piout.net>
References: <95b85b6d0369b4693e9d4e57af5eac49eee87dc9.1524710929.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b85b6d0369b4693e9d4e57af5eac49eee87dc9.1524710929.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2018 10:58:44+0800, Baolin Wang wrote:
> This is a preparation patch, changing to use devm_rtc_allocate_device()
> that can allow driver to set 'range_max' and 'range_min' for the RTC
> device.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/rtc/rtc-sc27xx.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Both applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
