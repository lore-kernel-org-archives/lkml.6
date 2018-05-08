Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755368AbeEHROf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:14:35 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36696 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754168AbeEHROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:14:32 -0400
X-Google-Smtp-Source: AB8JxZpIh8AtnQJBdmWt6dSq3nsxlbM2nmUQrON9nLiNiqDyGdBrA3bC/VSUk0+SoavUqyiSXfJYHw==
Subject: Re: [PATCH] net: phy: DP83811: Add support for the phy
To: Dan Murphy <dmurphy@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180508141105.23867-1-dmurphy@ti.com>
 <1b6877db-61cf-101a-054e-9c1fbe95a813@ti.com> <20180508164944.GE2888@lunn.ch>
 <f4cfe325-f462-e965-3bd8-629acf460fbf@ti.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <cc5acc63-bcb5-2bda-9c9d-fd18e0a7740a@gmail.com>
Date: Tue, 8 May 2018 10:14:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f4cfe325-f462-e965-3bd8-629acf460fbf@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 10:13 AM, Dan Murphy wrote:
> Andrew
> 
> On 05/08/2018 11:49 AM, Andrew Lunn wrote:
>> On Tue, May 08, 2018 at 10:56:55AM -0500, Dan Murphy wrote:
>>> All
>>>
>>> On 05/08/2018 09:11 AM, Dan Murphy wrote:
>>>> Add support for the DP83811 phy by extending
>>>> the DP83822 driver to recognize the PHY IDs.
>>>>
>>>> The DP83811 supports both rgmii and sgmii interfaces.
>>>> There are 2 part numbers for this the DP83811R does not
>>>> reliably support the SGMII interface but the DP83811S will.
>>>>
>>>> There is not a way to differentiate these parts from the
>>>> hardware or register set.  So this is controlled via the DT
>>>> to indicate which phy mode is required.  Or the part can be
>>>> strapped to a certain interface.
>>>>
>>>> Data sheet can be found here:
>>>> http://www.ti.com/product/DP83TC811S-Q1/description
>>>> http://www.ti.com/product/DP83TC811R-Q1/description
>>>>
>>>
>>> I am withdrawing this patch for comment.
>>> Some of the future features have varying register definitions between the DP83811
>>> and DP83822
>>
>> Hi Dan
>>
>> It might be worth talking to the ASIC engineers and the
>> test/qualification engineers. There are sometime undocumented
>> registers for testing. You might be able to identify the exact device
>> from these registers.
>>
> 
> Thanks.  I talked to them prior to submitting this patch about determining which part is on the board.
> I will ping them again and poke a little harder.
> 
> It turns out that we will probably need a new driver for this part anyway as there are
> additional features that need to be supported that the 811 just does not support.
> 
> They want to support Master/Slave configurations.
> The 822 supports fiber and eee while the 811 does not.
> The 811 supports the IEEE802.3bw specific fields in MMD1 and MMD3, which are not in the 822.
> The 811 does not support auto-negotiation on the MDI so all the auto-neg registers are invalid for the 811 but are valid for the 822.
> 
> Our Customer engineers felt that combining these two devices into a single driver may confuse the customer.

Why? Having a single Kconfig option to enable and "automatically"
gaining support for new hardware is nice.
-- 
Florian
