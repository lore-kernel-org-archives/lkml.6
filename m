Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbeEDIGg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:06:36 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:43114 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeEDIGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:06:19 -0400
Subject: Re: [PATCH 0/3] K2G: mmc: Update mmc dt node to use sdhci-omap
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
References: <20180425132746.13911-1-kishon@ti.com>
 <fc5f3498-62fd-15d3-90df-206c51649cb4@oracle.com>
 <0481f6f0-539e-4809-63cd-1134367a7b78@ti.com>
 <de0bd46a-21d4-14de-9695-9b0f3996dacb@oracle.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e4b70bab-d3bd-7071-aefa-2934c20a3e30@ti.com>
Date: Fri, 4 May 2018 13:36:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <de0bd46a-21d4-14de-9695-9b0f3996dacb@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

On Friday 04 May 2018 12:22 AM, santosh.shilimkar@oracle.com wrote:
> On 5/3/18 4:57 AM, Kishon Vijay Abraham I wrote:
>> Hi Santosh,
>>
>> On Wednesday 25 April 2018 11:10 PM, Santosh Shilimkar wrote:
>>> On 4/25/2018 6:27 AM, Kishon Vijay Abraham I wrote:
>>>> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
>>>> binding.
>>>>
>>>> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
>>>> Everyone who use a custom .config should also enable
>>>> CONFIG_MMC_SDHCI_OMAP for MMC to work.
>>>>
>>>> This series should be merged only after [1]
>>>> [1] -> https://marc.info/?l=linux-kernel&m=152465820531802&w=2
>>>>
>>> Keep me posted once the dependency gets merged.
>>
>> Ulf has merged the sdhci part and has shared an immutable branch
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git sdhci_omap
>> with his signed tag sdhci-omap-v4.17-rc3.
>>
>> Can you use it as a base for merging this series?
>>
> How about I apply only DTS patches and exlude config file update ?
> You can send the config patch after the merge window. Are the DTS
> changes also going to break anything without basing of this sdhci
> branch ?

Yes, the bindings has changed for sdhci-omap.
It should also be fine if this entire series can be merged during the 4.18 -rc
cycle since the dependent patches would have been already merged then.

Thanks
Kishon
