Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeCRROV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 13:14:21 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:14453 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751062AbeCRROU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 13:14:20 -0400
Subject: Re: [PATCH] MAINTAINERS: update maintainers for MTD and SPI NOR
 subsystems
To: Marek Vasut <marek.vasut@gmail.com>, computersforpeace@gmail.com,
        dwmw2@infradead.org, richard@nod.at,
        boris.brezillon@free-electrons.com, linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20180315190438.4832-1-cyrille.pitchen@wedev4u.fr>
 <c7722fa4-992e-717d-2b46-51f906a8978f@gmail.com>
From: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Message-ID: <309adb80-217b-1328-e462-d4596231bb25@wedev4u.fr>
Date: Sun, 18 Mar 2018 18:14:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c7722fa4-992e-717d-2b46-51f906a8978f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

Le 18/03/2018 à 00:41, Marek Vasut a écrit :
> On 03/15/2018 08:04 PM, Cyrille Pitchen wrote:
>> remove myself as MTD and SPI NOR maintainer.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
> 
> What happened ?
>

Nothing to worry. Since I was hired for a new job, I've been facing issues
to do spi-nor reviews in a reasonable delay. I have to admit that I took
more and more time before replying to people and I suspect it won't go
better soon.

So I've talked about it with Boris hence he suggested that I remove my name
from MAINTAINERS to avoid confusion so people are not surprised or
frustrated that I don't review their series on time.

I really don't know yet whether I could go back again later to help
reviewing mtd/spi-nor patches but for now I just have to admit that about mtd
topcis, I'm off-line almost all the time :(

Sorry guys and thanks for your concern, Marek! :)

Best regards,

Cyrille
 
>> ---
>>  MAINTAINERS | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3bdc260e36b7..7892db9a9494 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9037,7 +9037,6 @@ M:	Brian Norris <computersforpeace@gmail.com>
>>  M:	Boris Brezillon <boris.brezillon@free-electrons.com>
>>  M:	Marek Vasut <marek.vasut@gmail.com>
>>  M:	Richard Weinberger <richard@nod.at>
>> -M:	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
>>  L:	linux-mtd@lists.infradead.org
>>  W:	http://www.linux-mtd.infradead.org/
>>  Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
>> @@ -13006,7 +13005,6 @@ F:	arch/arm/boot/dts/spear*
>>  F:	arch/arm/mach-spear/
>>  
>>  SPI NOR SUBSYSTEM
>> -M:	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
>>  M:	Marek Vasut <marek.vasut@gmail.com>
>>  L:	linux-mtd@lists.infradead.org
>>  W:	http://www.linux-mtd.infradead.org/
>>
> 
> 
