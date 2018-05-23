Return-Path: <daniel@zonque.org>
X-Google-Smtp-Source: AB8JxZqHLZ8IwJlzedWHvoWdhH/E3+oseiBzgY26iMiIeYuXNuGBTngA7Pzx8aWQJJwAEgPKc1RY
ARC-Seal: i=1; a=rsa-sha256; t=1527112494; cv=none;
        d=google.com; s=arc-20160816;
        b=xNt+vrXkfTmOQ/tSaAthD52OPtvr1bigOtdZFiGrpDdunhOg8aLGcjuF/pxgu5q+Rt
         ImBoO/JqGHCNyA+kU6stwuDtIQ6nX/JmTkK6mR4mwRHAX7U6AhP/tqxrnFrFcFoMX3Yo
         keEgfnDrnFnP6Onz89goDYvemtLfcSuZsg4xnCyg/Sguk2TeIGJhh/9qiBzkyay+x8Eo
         PcJs/A8wYCvmzP0FyFAC2BZV5y0lEa8LhRAC9K60Imllv7YP3usNUvz9B+oGEzJvkeaj
         yxCzLZ+Acz5hz0i3YI1j8ygTraGmXYUmxG9JulU/PQTDbwYmfh64on+PtQQ/Bd3PYENc
         pfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:in-reply-to:mime-version:user-agent:date
         :message-id:references:cc:to:from:subject:arc-authentication-results;
        bh=HFAQpdvylQVgof1fDZSB2UtpSAoqMBk3WrKpvC6u9hs=;
        b=EDZOID7IxJxiT4K06xw+JUaIyXZXJ/zosCVGF2q+leyqcyWXJDXZmWlqsQ80ptRGhe
         iVXgZZ3qjWbsX+tZCDgzWx22SE9j/CbCHPcKONs77gf/LNMTYCqigRyxJmge7tLLY5Iv
         OACJJx/SO7fvNFbzn/x6L0BV9irhrdc98EI/otRfotTL5d/sQ6xKdR4HwWPts3deFRz+
         Shidy0CO0/YXSDZv/k3nKUJY4wn1hjpsOPKqPT1D4tC/EwOwhE4I+ffJLTbl6VXspOQc
         MTBnAeMv9H7uvLE/MdPP+k3ZyjUV9+DgTC3/00wgMZrZk1+dY0WhHHGi7yn8ccTwZrDE
         HNjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of daniel@zonque.org designates 46.23.86.59 as permitted sender) smtp.mailfrom=daniel@zonque.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of daniel@zonque.org designates 46.23.86.59 as permitted sender) smtp.mailfrom=daniel@zonque.org
Subject: Re: [PATCH 05/15] mtd: nand: pxa3xx: remove the dmaengine compat need
From: Daniel Mack <daniel@zonque.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Nicolas Pitre <nico@fluxnic.net>, Samuel Ortiz <samuel@sortiz.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
 devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Robert Jarzmik <robert.jarzmik@renault.com>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-6-robert.jarzmik@free.fr>
 <a09d80dc-e8fd-1e9a-1878-8875ddc83134@zonque.org>
Message-ID: <5f614736-31b6-6561-69c1-177595fbb210@zonque.org>
Date: Wed, 23 May 2018 23:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a09d80dc-e8fd-1e9a-1878-8875ddc83134@zonque.org>
Content-Type: multipart/mixed;
 boundary="------------05E9BD108AABC677CA24E234"
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644931360963410?=
X-GMAIL-MSGID: =?utf-8?q?1601293511081261100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------05E9BD108AABC677CA24E234
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Robert,

Please refer to the attached patch instead of the one I sent earlier. I 
missed to also remove the platform_get_resource(IORESOURCE_DMA) call.


Thanks,
Daniel


On Friday, May 18, 2018 11:31 PM, Daniel Mack wrote:
> Hi Robert,
> 
> Thanks for this series.
> 
> On Monday, April 02, 2018 04:26 PM, Robert Jarzmik wrote:
>> From: Robert Jarzmik <robert.jarzmik@renault.com>
>>
>> As the pxa architecture switched towards the dmaengine slave map, the
>> old compatibility mechanism to acquire the dma requestor line number and
>> priority are not needed anymore.
>>
>> This patch simplifies the dma resource acquisition, using the more
>> generic function dma_request_slave_channel().
>>
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>>    drivers/mtd/nand/pxa3xx_nand.c | 10 +---------
> 
> This driver was replaced by drivers/mtd/nand/raw/marvell_nand.c
> recently, so this patch can be dropped. I attached a version for the new
> driver which you can pick instead.
> 
> 
> Thanks,
> Daniel
> 


--------------05E9BD108AABC677CA24E234
Content-Type: text/x-patch;
 name="0001-mtd-rawnand-marvell-remove-dmaengine-compat-code.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-mtd-rawnand-marvell-remove-dmaengine-compat-code.patch"

>From 72a306157dedb21f8c3289f0f7a288fc4542bd96 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Sat, 12 May 2018 21:50:13 +0200
Subject: [PATCH] mtd: rawnand: marvell: remove dmaengine compat code

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/mtd/nand/raw/marvell_nand.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index ebb1d141b900..319fea77daf1 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2612,8 +2612,6 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 						    dev);
 	struct dma_slave_config config = {};
 	struct resource *r;
-	dma_cap_mask_t mask;
-	struct pxad_param param;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_PXA_DMA)) {
@@ -2626,20 +2624,7 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 	if (ret)
 		return ret;
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!r) {
-		dev_err(nfc->dev, "No resource defined for data DMA\n");
-		return -ENXIO;
-	}
-
-	param.drcmr = r->start;
-	param.prio = PXAD_PRIO_LOWEST;
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	nfc->dma_chan =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &param, nfc->dev,
-						 "data");
+	nfc->dma_chan = dma_request_slave_channel(nfc->dev, "data");
 	if (!nfc->dma_chan) {
 		dev_err(nfc->dev,
 			"Unable to request data DMA channel\n");
-- 
2.14.3


--------------05E9BD108AABC677CA24E234--
