Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA941C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A221B257ED
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A221B257ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753640AbeGAR6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:58:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:36400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753608AbeGAR6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:58:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 777ECACCA;
        Sun,  1 Jul 2018 17:58:17 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] dt-bindings: clock: Modify Actions Soc clock
 bindings
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     sboyd@kernel.org, pn@denx.de, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        devicetree@vger.kernel.org, Jeff Chen <jeff.chen@actions-semi.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-4-sravanhome@gmail.com>
 <20180630093202.GB7320@Mani-XPS-13-9360>
 <15070ea0-aebf-2b7d-89f0-b21e729c927e@gmail.com>
 <20180701173706.GA15895@Mani-XPS-13-9360>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 xsFNBE6W6ZQBEAC/BIukDnkVenIkK9O14UucicBIVvRB5WSMHC23msS+R2h915mW7/vXfn+V
 0nrr5ECmEg/5OjujKf0x/uhJYrsxcp45nDyYCk+RYoOJmGzzUFya1GvT/c04coZ8VmgFUWGE
 vCfhHJro85dZUL99IoLP21VXEVlCPyIngSstikeuf14SY17LPTN1aIpGQDI2Qt8HHY1zOVWv
 iz53aiFLFeIVhQlBmOABH2Ifr2M9loRC9yOyGcE2GhlzgyHGlQxEVGFn/QptX6iYbtaTBTU0
 c72rpmbe1Nec6hWuzSwu2uE8lF+HYcYi+22ml1XBHNMBeAdSEbSfDbwc///8QKtckUzbDvME
 S8j4KuqQhwvYkSg7dV9rs53WmjO2Wd4eygkC3tBhPM5s38/6CVGl3ABiWJs3kB08asUNy8Wk
 juusU/nRJbXDzxu1d+hv0d+s5NOBy/5+7Pa6HeyBnh1tUmCs5/f1D/cJnuzzYwAmZTHFUsfQ
 ygGBRRKpAVu0VxCFNPSYKW0ULi5eZV6bcj+NAhtafGsWcv8WPFXgVE8s2YU38D1VtlBvCo5/
 0MPtQORqAQ/Itag1EHHtnfuK3MBtA0fNxQbb2jha+/oMAi5hKpmB/zAlFoRtYHwjFPFldHfv
 Iljpe1S0rDASaF9NsQPfUBEm7dA5UUkyvvi00HZ3e7/uyBGb0QARAQABzSJBbmRyZWFzIEbD
 pHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgID
 AQIeAQIXgAUCTqGJnQIZAQAKCRD6LtEtPn4BPzetD/4rF6k/HF+9U9KqykfJaWdUHJvXpI85
 Roab12rQbiIrL4hVEYKrYwPEKpCf+FthXpgOq+JdTGJ831DMlTx7Ed5/QJ9KAAQuhZlSNjSc
 +FNobJm7EbFv9jWFjQC0JcOl17Ji1ikgRcIRDCul1nQh9jCdfh1b848GerZmzteNdT9afRJm
 7rrvMqXs1Y52/dTlfIW0ygMA2n5Vv3EwykXJOPF6fRimkErKO84sFMNg0eJV9mXs+Zyionfi
 g2sZJfVeKjkDqjxy7sDDBZZR68I9HWq5VJQrXqQkCZUvtr6TBLI+uiDLbGRUDNxA3wgjVdS2
 v9bhjYceSOHpKU+h3H2S8ju9rjhOADT2F5lUQMTSpjlzglh8IatV5rXLGkXEyum4MzMo2sCE
 Cr+GD6i2M3pHCtaIVV3xV0nRGALa6DdF7jBWqM54KHaKsE883kFH2+6ARcPCPrnPm7LX98h2
 4VpG984ysoq6fpzHHG/KCaYCEOe1bpr3Plmmp3sqj0utA6lwzJy0hj5dqug+lqmg7QKAnxl+
 porgluoY56U0X0PIVBc0yO0dWqRxtylJa9kDX/TKwFYNVddMn2NQNjOJXzx2H9hf0We7rG7+
 F/vgwALVVYbiTzvp2L0XATTv/oX4BHagAa/Qc3dIsBYJH+KVhBp+ZX4uguxk4xlc2hm75b1s
 cqeAD87BTQROlumUARAAzd7eu+tw/52FB7xQZWDv5aF+6CAkoz7AuY4s1fo0AQQDqjLOdpQF
 bifdH7B8SnsA4eo0syfs+1tZW6nn9hdy1GHEMbeuvdhNwkhEfYGDYpSue7oVxB4jajKvRHAP
 VcewKZIxvIiZ5aSp5n1Bd7B0c0C443DHiWE/0XWSpvbU7fTzTNvdz+2OZmGtqCn610gBqScv
 1BOiP3OfLly8ghxcJsos23c0mkB/1iWlzh3UMFIGrzsK3sZJ/3uRaLYFimmqqPlSwFqx3b0M
 1gFdHWKfOpvQ4wwP5P10xwvqNXLWC30wB1QmJGD/X8aAoVNnGsmEL7GcWF4cLoOSRidSoccz
 znShE+Ap+FVDD6MRyesNT4D67l792//B38CGJRdELtNacdwazaFgxH9O85Vnd70ZC7fIcwzG
 yg/4ZEf96DlAvrSOnu/kgklofEYdzpZmW+Fqas6cnk6ZaHa35uHuBPesdE13MVz5TeiHGQTW
 xP1jbgWQJGPvJZ+htERT8SZGBQRb1paoRd1KWQ1mlr3CQvXtfA/daq8p/wL48sXrKNwedrLV
 iZOeJOFwfpJgsFU4xLoO/8N0RNFsnelBgWgZE3ZEctEd4BsWFUw+czYCPYfqOcJ556QUGA9y
 DeDcxSitpYrNIvpk4C5CHbvskVLKPIUVXxTNl8hAGo1Ahm1VbNkYlocAEQEAAcLBXwQYAQIA
 CQUCTpbplAIbDAAKCRD6LtEtPn4BPzA6D/9TbSBOPM99SHPX9JiEQAw4ITCBF2oTWeZQ6RJg
 RKpB15lzyPfyFbNSceJp9dCiwDWe+pzKaX6KYOFZ5+YTS0Ph2eCR+uT2l6Mt6esAun8dvER/
 xlPDW7p88dwGUcV8mHEukWdurSEDTj8V3K29vpgvIgRq2lHCn2wqRQBGpiJAt72Vg0HxUlwN
 GAJNvhpeW8Yb43Ek7lWExkUgOfNsDCTvDInF8JTFtEXMnUcPxC0d/GdAuvBilL9SlmzvoDIZ
 5k2k456bkY3+3/ydDvKU5WIgThydyCEQUHlmE6RdA3C1ccIrIvKjVEwSH27Pzy5jKQ78qnhv
 dtLLAavOXyBJnOGlNDOpOyBXfv02x91RoRiyrSIM7dKmMEINKQlAMgB/UU/6B+mvzosbs5d3
 4FPzBLuuRz9WYzXmnC460m2gaEVk1GjpidBWw0yY6kgnAM3KhwCFSecqUQCvwKFDGSXDDbCr
 w08b3GDk40UoCoUq9xrGfhlf05TUSFTg2NlSrK7+wAEsTUgs2ZYLpHyEeftoDDnKpM4ghs/O
 ceCeyZUP1zSgRSjgITQp691Uli5Nd1mIzaaM8RjOE/Rw67FwgblKR6HAhSy/LYw1HVOu+Ees
 RAEdbtRt37A8brlb/ENxbLd9SGC8/j20FQjit7oPNMkTJDs7Uo2eb7WxOt5pSTVVqZkv7Q==
Organization: SUSE Linux GmbH
Message-ID: <88ce01d4-2694-eca0-770e-d4bd2869a258@suse.de>
Date:   Sun, 1 Jul 2018 19:58:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180701173706.GA15895@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 01.07.2018 um 19:37 schrieb Manivannan Sadhasivam:
> On Sun, Jul 01, 2018 at 07:26:20PM +0200, Saravanan Sekar wrote:
>> Hi Mani
>>
>>
>> On 06/30/18 11:32, Manivannan Sadhasivam wrote:
>>> Hi Saravanan,
>>>
>>> I agree with modifying the existing binding to accomodate other
>>> SoC's of the same family. But the binding should be
>>> "actions,owl-cmu.txt" since it reflects the family name.
>>
>> Agree, will modify the name
>>
>>> Andreas, what do you think?

I concur that sx00 is insufficient. Older models were called ATMxxxx.
Unfortunately with owl- it then no longer matches the compatible, but I
wouldn't mind.

>>> On Thu, Jun 28, 2018 at 09:18:05PM +0200, Saravanan Sekar wrote:
>>>> Modify clock bindings common Actions Semi Soc family S700/S900.
>>>>
>>>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>>>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>>>> ---
>>>>   ...tions,s900-cmu.txt => actions,sx00-cmu.txt} | 18 ++++++++++--------
>>>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>>>   rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,sx00-cmu.txt} (71%)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
>>>> similarity index 71%
>>>> rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
>>>> rename to Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
>>>> index 93e4fb827cd6..8dc7edb4d198 100644
>>>> --- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
>>>> +++ b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
>>>> @@ -1,12 +1,14 @@
>>>> -* Actions S900 Clock Management Unit (CMU)
>>>> +* Actions S900/S700 Clock Management Unit (CMU)
>>> Same as above. Should be Actions OWL SoC's Clock Management Unit (CMU).
>>
>> sure
>>
> 
> During the review of I2C controller driver, Andreas pointed out that
> we should use Owl instead of OWL in all places and also Actions should
> be replaced by Actions Semiconductor.

Actually I was just asking to include the company name and not just say
Owl. Whether it's Actions, Actions Semi or Actions Semiconductor is not
that important to me - that would be for the Actions Semi colleagues to
comment - which I see are not in CC... Please fix that! You don't need
mp-cs I think, but the others please.

> So, please change it in relevant
> places. For this binding, title should be:
> 
> Actions Semiconductor Owl SoC's Clock Management Unit (CMU).

"SoC's" looks weird there, do we have such precedence to add it?
"Actions Owl Clock Management Unit (CMU)" might do?

Saravanan, please compare other patch titles and adapt your subjects
accordingly: "modify bindings" is not very meaningful, since a patch
always modifies something and the prefix already indicates dt-bindings
as target. "Soc" is misspelled. The time-saving information to put there
would be addition of S700.

>>>> -The Actions S900 clock management unit generates and supplies clock to various
>>>> -controllers within the SoC. The clock binding described here is applicable to
>>>> -S900 SoC.
>>>> +The Actions S900/S700 clock management unit generates and supplies clock to
>>>> +various controllers within the SoC. The clock binding described here is
>>>> +applicable to S900/S700 SoC.

"S900 and S700 SoCs"? (keep the slash above)

>>>>   Required Properties:
>>>> -- compatible: should be "actions,s900-cmu"
>>>> +- compatible: should be one of this
>>> Change to: compatible: should be one of the following:
>>
>> sure
>>
>>> Thanks,
>>> Mani
>>>
>>>> +	"actions,s900-cmu"
>>>> +	"actions,s700-cmu"

Mani, should we order alphabetically? I.e., will S500 go before S900, or
will people just always append at the end now? Not saying we have to,
but keeping it consistent across Actions bindings would be desirable.

>>>>   - reg: physical base address of the controller and length of memory mapped
>>>>     region.
>>>>   - clocks: Reference to the parent clocks ("hosc", "losc")
>>>> @@ -15,9 +17,9 @@ Required Properties:
>>>>   Each clock is assigned an identifier, and client nodes can use this identifier
>>>>   to specify the clock which they consume.
>>>> -All available clocks are defined as preprocessor macros in
>>>> -dt-bindings/clock/actions,s900-cmu.h header and can be used in device
>>>> -tree sources.
>>>> +All available clocks are defined as preprocessor macros in corresponding
>>>> +dt-bindings/clock/actions,s900-cmu.h or s700-cmu.h header and can be used in

actions,s700-cmu.h for humans please or at least ...,s700-cmu.h.

>>>> +device tree sources.
>>>>   External clocks:

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
