Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeEVV0H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:26:07 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:48728 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbeEVV0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:26:05 -0400
Subject: Re: [linux-next PATCH 0/4] Enable network driver on K2G ICE and GP
 EVMs
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>,
        <ssantosh@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
 <8e1aa492-ae7a-de2b-f5d2-8756b10ece79@oracle.com>
From: Murali Karicheri <m-karicheri2@ti.com>
Organization: Texas Instruments
Message-ID: <7df564c7-25af-f8a4-1f53-b41ee499c1eb@ti.com>
Date: Tue, 22 May 2018 17:28:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8e1aa492-ae7a-de2b-f5d2-8756b10ece79@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20/2018 11:17 PM, santosh.shilimkar@oracle.com wrote:
> On 5/11/18 12:29 PM, Murali Karicheri wrote:
>> Now that NetCP driver patches for K2G SoC is merged to linux-next master
>> this series add patches to enable network driver on K2G ICE and GP EVMs.
>>
>> Thanks
>>
>> Applied the patches on top of latest linux-next master, built kernel and
>> booted up on both EVMs. The logs are below
>>
>> K2G GP EVM: https://pastebin.ubuntu.com/p/ycZDnZXYPx/
>> K2G ICE EVM: https://pastebin.ubuntu.com/p/bdCpzgdrXr/
>>
>> Murali Karicheri (4):
>>    ARM: dts: k2g: add dt bindings to support network driver
>>    ARM: dts: keystone-k2g-evm: Enable netcp network driver
>>    ARM: dts: keystone-k2g-ice: Enable netcp network driver
>>    ARM: keystone: k2g: enable micrel and dp83867 phys
>>
>>   arch/arm/boot/dts/keystone-k2g-evm.dts    |  53 +++++++++++
>>   arch/arm/boot/dts/keystone-k2g-ice.dts    |  59 ++++++++++++
>>   arch/arm/boot/dts/keystone-k2g-netcp.dtsi | 147 ++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/keystone-k2g.dtsi       |  13 +++
>>   arch/arm/configs/keystone_defconfig       |   2 +
>>   5 files changed, 274 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/keystone-k2g-netcp.dtsi
>>
> Looks good. Will add this to the queue for 4.19. Thanks !!
> 
> Regards,
> Santosh
> 
Thanks Santosh!

-- 
Murali Karicheri
Linux Kernel, Keystone
