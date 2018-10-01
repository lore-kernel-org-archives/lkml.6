Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B10C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4CE208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4CE208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbeJAVCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:02:34 -0400
Received: from serv1.kernkonzept.com ([88.99.87.17]:52079 "EHLO
        mx.kernkonzept.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJAVCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:02:33 -0400
Received: from ip5f5b9406.dynamic.kabel-deutschland.de ([95.91.148.6] helo=localhost.localdomain)
        by mx.kernkonzept.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
        id 1g6z7b-0008OM-Mq; Mon, 01 Oct 2018 16:24:27 +0200
Subject: Re: x86/apic: MSI address malformed for "flat" driver
To:     Thomas Gleixner <tglx@linutronix.de>,
        Cyril Novikov <cnovikov@lynx.com>
Cc:     linux-kernel@vger.kernel.org
References: <d407ee89-3d6c-b55d-d633-abf7644e9766@kernkonzept.com>
 <alpine.DEB.2.21.1809072012310.1402@nanos.tec.linutronix.de>
 <27bccfd2-0ede-cd3a-2717-741d3dffebdf@lynx.com>
 <alpine.DEB.2.21.1809111024020.5110@nanos.tec.linutronix.de>
From:   Philipp Eppelt <philipp.eppelt@kernkonzept.com>
Openpgp: preference=signencrypt
Autocrypt: addr=philipp.eppelt@kernkonzept.com; prefer-encrypt=mutual;
 keydata=
 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
 khuLCBwcsLPhxbjZ6s1AXffYGA==
Message-ID: <f4406990-668d-917e-3880-4cbc71012555@kernkonzept.com>
Date:   Mon, 1 Oct 2018 16:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809111024020.5110@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 02:29 PM, Thomas Gleixner wrote:
> On Mon, 10 Sep 2018, Cyril Novikov wrote:
>> On 9/7/2018 12:11 PM, Thomas Gleixner wrote:
>>> On Thu, 6 Sep 2018, Philipp Eppelt wrote:
>>>>
>>>> The "flat" driver defines the MSI addressing scheme to be used as
>>>> logical addressing in flat mode. The MSI msg address is composed
>>>> accordingly, but sets MSI_ADDR_REDIRECTION_CPU which is a zero at bit[3].
>>>
>>> Correct. That's what it means:
>>>
>>>    * When RH is 0, the interrupt is directed to the processor listed in the
>>>      Destination ID field.
>>>
>>> So for DM:
>>>
>>>    * If RH is 0, then the DM bit is ignored and the message is sent ahead
>>>      independent of whether the physical or logical destination mode is
>>>      used.
>>>
>>> which is means that the delivery does not do any magic redirections,
>>> because the Redirection Hint is off. If RH is set, then the delivery can
>>> redirect according to the rules in the DM section. We are not using that
>>> because we want targeted single CPU delivery.
>>>
>>> The interpretation of the DID field is purely depending on the local APIC
>>> itself by matching the APIC ID against the DID field. And the local APIC ID
>>> of CPU0 is 1 << 0, i.e. 0x1 which matches the MSI message you see.
>>
>> I believe you are wrong here and the local APIC ID of CPU0 is 0.
>>
>> processor       : 0
>> vendor_id       : GenuineIntel
>> ...
>> physical id     : 0
>> siblings        : 8
>> core id         : 0
>> cpu cores       : 4
>> apicid          : 0
>>
>> The fact that the code works means that DM is not ignored when RH is 0. In
>> other words, RH=0 DM=1 means logical destination mode.
> 
> Sorry, I did not explain it very well. Let me try again.
> 
>   * If RH is 0, then the DM bit is ignored and the message is sent ahead
>     independent of whether the physical or logical destination mode is
>     used.
> 
> The PCI device simply writes the message data to that address, it does not
> even know what the individual bits mean. It's a write of data to address.
> 
> The write gets then directed to the APIC bus or the Processor System Bus
> depending on the CPU by a translation unit.

Ah, so there is a translation unit right before the apic/system bus
which translates the MSI address & data to the system bus format.
I missed that bit in the manual. I assumed a connection between RH and
DM when the APIC interprets the message.


> If RH is not set then the logic translates the message without
> modifications including the DM bit.

Albeit RH=0 the DM bit IS interpreted by the local APIC at the end as
the DM bit is part of the system bus message format? Can you point me to
some documentation on the translated message format? I guess it is
similar to the local APIC's Interrupt Command Register?

> 
> Hope that clarifies it.

Yes, thank you very much for the additional explanations.

> 
> Out of curiosity: What kind of problem are you trying to solve?

I am in the process of writing a x86_64 VMM for the L4Re OS with Linux
as a guest and are working on the PCI subsystem/MSI handling of the VMM
for virtual devices.

Cheers,
Philipp
