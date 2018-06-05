Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeFETl2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:41:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36847 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeFETlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:41:13 -0400
X-Google-Smtp-Source: ADUXVKLa5cke+lCtL7SnaYchUqSW9fjx/Kbeo88GsNB/aMTnGWGuzFoNXSl1BxP6ce+2gMtWKwc38Q==
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
To: Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>, Ryankao <ryankao@realtek.com>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>,
        "jrg.otte@gmail.com" <jrg.otte@gmail.com>,
        David Miller <davem@davemloft.net>, Hayes Wang <hayeswang@realtek.com>,
        "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hau <hau@realtek.com>, linux-pci@vger.kernel.org
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
 <9D9E2AF1-CD59-425B-85E9-DB89D620CA67@canonical.com>
 <B01FA80E1422A647BEB597328C544223D30B8F90@RTITMBSV05.realtek.com.tw>
 <20180605172805.GD30381@bhelgaas-glaptop.roam.corp.google.com>
 <20180605191142.GA214338@bhelgaas-glaptop.roam.corp.google.com>
 <6c6b579a-5be4-ccc0-f64c-9998e51145f5@gmail.com>
 <d50e04b3-87be-f300-b0ea-2da7e3660ebb@gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <15ef164c-9b7c-5a05-3b41-840a53c77a56@gmail.com>
Date: Tue, 5 Jun 2018 21:41:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d50e04b3-87be-f300-b0ea-2da7e3660ebb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2018 21:27, Florian Fainelli wrote:
> On 06/05/2018 12:17 PM, Heiner Kallweit wrote:
>> On 05.06.2018 21:11, Bjorn Helgaas wrote:
>>> [+cc linux-pci]
>>>
>>> On Tue, Jun 05, 2018 at 12:28:05PM -0500, Bjorn Helgaas wrote:
>>>> On Tue, Jun 05, 2018 at 06:34:09AM +0000, Ryankao wrote:
>>>>> Add realtek folk Hau
>>>>>
>>>>> -----Original Message-----
>>>>> From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com] 
>>>>> Sent: Tuesday, June 05, 2018 1:02 PM
>>>>> To: jrg.otte@gmail.com
>>>>> Cc: David Miller <davem@davemloft.net>; Hayes Wang <hayeswang@realtek.com>; hkallweit1@gmail.com; romieu@fr.zoreil.com; Linux Netdev List <netdev@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Ryankao <ryankao@realtek.com>
>>>>> Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
>>>>>
>>>>> Hi Jörg Otte,
>>>>>
>>>>> Can you give this patch a try?
>>>>>
>>>>> Since you are the only one that reported ALDPS/ASPM regression,
>>>>>
>>>>> And I think this patch should solve the issue you had [1].
>>>>>
>>>>> Hopefully we don't need to go down the rabbit hole of blacklist/whitelist...
>>>>>
>>>>> Kai-Heng
>>>>>
>>>>> [1] https://lkml.org/lkml/2013/1/5/36
>>>>
>>>> I have no idea what ALDPS is.  It's not mentioned in the PCIe spec, so
>>>> presumably it's some Realtek-specific thing.  ASPM is a generic PCIe
>>>> thing.  Changes to these two things should be in separate patches so
>>>> they don't get tangled up.
>>>>
>> ALDPS = Advanced Link Down Power Saving
>> And yes, it's a Realtek feature.
> 
> Link as in Ethernet link or PCI(e) link? Sorry too lazy to let me google
> that for myself :)
> 
Sorry .. Link here refers to the Ethernet PHY.
