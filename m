Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeECUJV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:09:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38255 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeECUJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:09:20 -0400
Date: Thu, 3 May 2018 22:09:08 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Joshua Kinard <kumba@gentoo.org>, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 44/61] rtc: simplify getting .drvdata
Message-ID: <20180503200908.GA10960@piout.net>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-45-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-45-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2018 16:06:14+0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/rtc/rtc-bq4802.c   |  6 ++----
>  drivers/rtc/rtc-ds1216.c   |  6 ++----
>  drivers/rtc/rtc-ds1511.c   |  9 +++------
>  drivers/rtc/rtc-ds1553.c   | 15 +++++----------
>  drivers/rtc/rtc-ds1685.c   | 21 +++++++--------------
>  drivers/rtc/rtc-ds1742.c   |  6 ++----
>  drivers/rtc/rtc-lpc32xx.c  | 16 ++++++----------
>  drivers/rtc/rtc-m48t59.c   | 41 ++++++++++++++++-------------------------
>  drivers/rtc/rtc-mv.c       |  3 +--
>  drivers/rtc/rtc-mxc.c      | 21 +++++++--------------
>  drivers/rtc/rtc-pcap.c     | 15 +++++----------
>  drivers/rtc/rtc-sh.c       | 15 +++++----------
>  drivers/rtc/rtc-stk17ta8.c | 15 +++++----------
>  drivers/rtc/rtc-test.c     |  3 +--
>  drivers/rtc/rtc-zynqmp.c   | 10 ++++------
>  15 files changed, 71 insertions(+), 131 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
