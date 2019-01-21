Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2605C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A5F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfAUHQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:16:21 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:14187 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfAUHQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:16:21 -0500
Received: from [10.18.29.210] (10.18.29.210) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1591.10; Mon, 21 Jan
 2019 12:18:18 +0800
Subject: Re: [PATCH] MAINTAINERS: Add entry for Amlogic NAND controller driver
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>,
        Liang Yang <liang.yang@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1547917355-13179-1-git-send-email-jianxin.pan@amlogic.com>
 <20190120160605.33689354@xps13>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <3f098e44-9d9b-3d0a-3e19-5913077aeb07@amlogic.com>
Date:   Mon, 21 Jan 2019 12:18:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190120160605.33689354@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.210]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 2019/1/20 23:06, Miquel Raynal wrote:
> Hi Jianxin,
> 
> Jianxin Pan <jianxin.pan@amlogic.com> wrote on Sun, 20 Jan 2019
> 01:02:35 +0800:
> 
>> Add entry for Amlogic NAND controller driver and its bindings[0].
>>
>> [0] https://lore.kernel.org/lkml/1547566684-57472-1-git-send-email-jianxin.pan@amlogic.com/
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> 
> If you are the author of the patch your Signed-off-by should come first.
OK.
> 
> Also, why is Liang the Maintainer? Why not you?
> 
Yangliang is Amlogic maintainer for NAND controller. And all patches about amlogic NAND controller are from him.
>> ---
>>  MAINTAINERS | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0abecc5..7d976a1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9628,6 +9628,13 @@ F:	drivers/media/platform/meson/ao-cec.c
>>  F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
>>  T:	git git://linuxtv.org/media_tree.git
>>  
>> +MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
>> +M:	Liang Yang <liang.yang@amlogic.com>
>> +L:	linux-mtd@lists.infradead.org
>> +S:	Maintained
>> +F:	drivers/mtd/nand/raw/meson_*
>> +F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> +
>>  MICROBLAZE ARCHITECTURE
>>  M:	Michal Simek <monstr@monstr.eu>
>>  W:	http://www.monstr.eu/fdt/
> 
> Thanks,
> Miquèl
> 
> .
> 

