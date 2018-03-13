Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeCMAlQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:41:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60459 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbeCMAlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:41:15 -0400
Date: Tue, 13 Mar 2018 01:41:01 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael McCormick <michael.mccormick@enatel.net>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcf85063 was not clearing bits correctly in
 pcf85063_start_clock
Message-ID: <20180313004101.GH3795@piout.net>
References: <20180221222924.GA11756@michael-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221222924.GA11756@michael-virtual-machine>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2018 at 11:29:24 +1300, Michael McCormick wrote:
> Bit clear operation was missing ~
> 
> Signed-off-by: Michael McCormick <michael.mccormick@enatel.net>
> ---
>  drivers/rtc/rtc-pcf85063.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
