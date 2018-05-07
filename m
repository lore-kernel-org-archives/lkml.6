Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeEGGVb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:21:31 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:38727 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbeEGGVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:21:08 -0400
X-IronPort-AV: E=Sophos;i="5.49,373,1520924400";
   d="scan'208";a="14570674"
Subject: Re: [PATCH v4 5/9] iio: adc: at91-sama5d2_adc: add support for
 position and pressure channels
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>
CC: <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
References: <1525084335-11276-1-git-send-email-eugen.hristev@microchip.com>
 <1525084335-11276-6-git-send-email-eugen.hristev@microchip.com>
 <20180506182953.6adad5b5@archlinux> <20180506175914.GL10960@piout.net>
From: Eugen Hristev <eugen.hristev@microchip.com>
Message-ID: <eaeced9e-390f-0eea-0466-66c789bacdd6@microchip.com>
Date: Mon, 7 May 2018 09:18:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180506175914.GL10960@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.05.2018 20:59, Alexandre Belloni wrote:
> Hi,
> 
> On 06/05/2018 18:29:53+0100, Jonathan Cameron wrote:
>> On Mon, 30 Apr 2018 13:32:11 +0300
>> Eugen Hristev <eugen.hristev@microchip.com> wrote:
>>
>>> This implements the support for position and pressure for the included
>>> touchscreen support in the SAMA5D2 SOC ADC block.
>>> Two position channels are added and one for pressure.
>>> They can be read in raw format, or through a buffer.
>>> A normal use case is for a consumer driver to register a callback buffer
>>> for these channels.
>>> When the touchscreen channels are in the active scan mask,
>>> the driver will start the touchscreen sampling and push the data to the
>>> buffer.
>>>
>>> Some parts of this patch are based on initial original work by
>>> Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy
>>>
>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>> Looks good to me now.
>>
>> I'm assuming that once Dmitry and others are happy, I'll take the
>> series through the IIO tree. Will reply to the cover letter if the
>> rest of the patches look good to me to let everyone know that without
>> having to catch this comment down in here!
>>
> 
> I'm planning to take both DT patches through the at91 tree once you take
> the DT bindings patches.

Please take into consideration that those DT patches do not build 
stand-alone, they depend on
[PATCH v4 7/9] dt-bindings: iio: adc: at91-sama5d2_adc: add channel 
specific consumer info

(the DT patches add an include statement of a file which is created in 
this patch).

Thanks !
Eugen
> 
> 
