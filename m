Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeDCO6M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:58:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50656 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeDCO6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:58:11 -0400
Date: Tue, 3 Apr 2018 16:57:41 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: sean.wang@mediatek.com
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mt7622: fix module autoloading for OF platform
 drivers
Message-ID: <20180403145741.GB6444@piout.net>
References: <4231c0b6038764f68324297a40b18b15ecda5a92.1522055289.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4231c0b6038764f68324297a40b18b15ecda5a92.1522055289.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2018 18:05:52+0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> It's required to create a modules.alias via MODULE_DEVICE_TABLE helper
> for the OF platform driver. Otherwise, module autoloading cannot work.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/rtc/rtc-mt7622.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
