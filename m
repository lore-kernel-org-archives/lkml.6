Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeFDFsK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 01:48:10 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:16049 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeFDFsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 01:48:08 -0400
Subject: Re: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
To: Stephen Boyd <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC: <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
 <152792116258.225090.5279546677198775320@swboyd.mtv.corp.google.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <19b3fa0b-ae8a-96d8-1a08-850d85a9ae74@ti.com>
Date: Mon, 4 Jun 2018 11:19:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152792116258.225090.5279546677198775320@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 02 June 2018 12:02 PM, Stephen Boyd wrote:
> Quoting Faiz Abbas (2018-05-30 07:11:32)
>> diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
>> index bfc82636999c..57b8dc0fe719 100644
>> --- a/arch/arm/boot/dts/dra76x.dtsi
>> +++ b/arch/arm/boot/dts/dra76x.dtsi
>> @@ -11,6 +11,25 @@
>>  / {
>>         compatible = "ti,dra762", "ti,dra7";
>>  
>> +       ocp {
>> +
>> +               target-module@0x42c00000 {
> 
> Drop the 0x on unit address. Also, it should match the first register
> property. And what is a "target-module"?
> 

Will fix it. And please see
Documentation/devicetree/bindings/bus/ti-sysc.txt


Thanks,
Faiz
