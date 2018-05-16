Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbeEPOmc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:42:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35988 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeEPOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:42:29 -0400
X-Google-Smtp-Source: AB8JxZoI+HM+GrYz2lJI0/HXqyz5K34aq2M2sEQlJBcTB5Uoo1fNM0VVikMp5+NPssaGffMpYk0Q5A==
Subject: Re: [PATCH] mtd: spi-nor: add support for Microchip 25LC256
To: Radu Pirea <radu.pirea@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Zhiqiang.Hou@nxp.com, pp@emlix.com, richard@nod.at,
        computersforpeace@gmail.com, dwmw2@infradead.org
References: <20180504155404.5285-1-radu.pirea@microchip.com>
 <20180504204013.254d90cf@bbrezillon>
 <e2e23aa21b37754b0c84003e6d87c7cb7d5a17fe.camel@microchip.com>
 <1db092c8-95fb-5747-f7b9-f6a215b1aa5b@gmail.com>
 <a34429cf43124de623fcaa645d5d7a360c755867.camel@microchip.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <30ab9516-abc9-d2d5-79ea-266c682c5fa9@gmail.com>
Date: Wed, 16 May 2018 15:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a34429cf43124de623fcaa645d5d7a360c755867.camel@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 12:05 PM, Radu Pirea wrote:
> On Wed, 2018-05-16 at 00:17 +0200, Marek Vasut wrote:
>> On 05/15/2018 06:22 PM, Radu Pirea wrote:
>>> On Fri, 2018-05-04 at 20:40 +0200, Boris Brezillon wrote:
>>>> On Fri, 4 May 2018 18:54:04 +0300
>>>> Radu Pirea <radu.pirea@microchip.com> wrote:
>>>>
>>>>> Added geometry description for Microchip 25LC256 memory.
>>>>
>>>> Same as for the dataflash stuff you posted a few weeks ago: I
>>>> don't
>>>> think this device belongs in the SPI NOR framework.
>>>
>>> Hi Boris,
>>>
>>> 25lc256 memory is similar with mr25h256, the only difference is the
>>> page size(64 vs 256). Because mr25h256 is already in SPI NOR
>>> framework
>>> I added here 25lc256.
>>
>> I think I must be reading the wrong datasheet, but can you show me
>> how
>> does it support things like READID opcode ?
>>
> Hi Marek,
> 
> I read the datasheet for 25lc256 and for mr25h256 and none of them
> supports READID. Is this required for a chip to be included in spi-nor
> framework? I just followed the mr25h256 as an example. 

So I thought until you pointed out the MR25 devices.

Does the 25LC device need erase or not ? I think the MR25s didn't, but I
might be wrong.

Maybe the framework could support the 25LC afterall.

-- 
Best regards,
Marek Vasut
