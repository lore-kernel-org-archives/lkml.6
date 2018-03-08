Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934476AbeCHAgw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 19:36:52 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.46]:43170 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933935AbeCHAgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 19:36:50 -0500
Subject: Re: [PATCH v2 0/3] pinctrl: bcm2835: Add brcm,level property
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: linus.walleij@linaro.org, eric@anholt.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <431699005.307231.1520086916739@email.1und1.de>
 <1520216960-19880-1-git-send-email-matheus@castello.eng.br>
 <821312841.275581.1520423887935@email.1und1.de>
From: Matheus Castello <matheus@castello.eng.br>
Message-ID: <047e47b4-daf7-2ba2-ea86-0060a59049b7@castello.eng.br>
Date: Wed, 7 Mar 2018 20:12:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <821312841.275581.1520423887935@email.1und1.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1etjAv-0037rZ-JW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.11]) [191.189.21.134]:24401
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 5
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 03/07/2018 07:58 AM, Stefan Wahren wrote:
> Hi Matheus,
> 
>> Matheus Castello <matheus@castello.eng.br> hat am 5. März 2018 um 03:29 geschrieben:
>>
>>
>> Hi Linus and Stefan,
>>
>> thanks for the tips.
>>
>> This series adds support for generic binding for pinctrl bcm2835 driver,
>> and add the code for set output buffer of a pin using the output-low and
>> output-high generic properties.
>>
>> Tested on Raspberry Pi Zero W, based on bcm2835 SoC.
>>
>> Matheus Castello (3):
> 
> looks like you missed the changes to the dt binding. Please also add Rob Herring and Mark Rutland to CC. We need a ACK from them.

are you talking about the .dts files? I add an overlay file for my tests. 
I was thinking it would be better to start with this changes in the driver and then in another series to convert to the generic style in the .dts.
If you find it better already add the conversion also in this series let me know.

I understood that I should put the device tree maintainers in thread only if I were to introduce a new property. As I am using generic properties and not introducing new ones I did not add them.
Let me know if it is still necessary I stayed in this doubt.

Best Regards
Matheus Castello
> 
>>   pinctrl: bcm2835: switch to GENERIC_PINCONF
>>   pinctrl: bcm2835: Add support for generic pinctrl binding
>>   pinctrl: bcm2835: Add support for output-low output-high properties
>>
>>  drivers/pinctrl/bcm/Kconfig           |  1 +
>>  drivers/pinctrl/bcm/pinctrl-bcm2835.c | 88 +++++++++++++++++++++++------------
>>  2 files changed, 60 insertions(+), 29 deletions(-)
>>
>> --
>> 2.7.4
>>
