Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeBJIpl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 03:45:41 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:38955 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeBJIpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 03:45:39 -0500
Subject: Re: [PATCH v2 4/7] dt-bindings: tegra: Add missing chips and NVIDIA
 boards
To: Rob Herring <robh@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, mark.rutland@arm.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
 <1517901757-15353-5-git-send-email-mperttunen@nvidia.com>
 <20180209224922.4fxlpl77kwibzfui@rob-hp-laptop>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <5105d996-8020-ebcf-cf46-2f13c6b8b35f@kapsi.fi>
Date: Sat, 10 Feb 2018 10:45:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180209224922.4fxlpl77kwibzfui@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.248.219.42
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 12:49 AM, Rob Herring wrote:
> On Tue, Feb 06, 2018 at 09:22:34AM +0200, Mikko Perttunen wrote:
>> Add compatibility strings for supported but undocumented Tegra chips
>> (Tegra114/124/132/210/186/194) and reference boards.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>
>> Notes:
>>      v2:
>>      - add patch
>>
>>   Documentation/devicetree/bindings/arm/tegra.txt | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
>> index 7f1411bbabf7..32f62bb7006d 100644
>> --- a/Documentation/devicetree/bindings/arm/tegra.txt
>> +++ b/Documentation/devicetree/bindings/arm/tegra.txt
>> @@ -9,6 +9,12 @@ following compatible values:
>>   
>>     nvidia,tegra20
>>     nvidia,tegra30
>> +  nvidia,tegra114
>> +  nvidia,tegra124
>> +  nvidia,tegra132
>> +  nvidia,tegra210
> 
> Some reason why this is not in numerical order?

They are in chronological/chip generation order, and for whatever 
reason, that isn't numerical.

Mikko

> 
>> +  nvidia,tegra186
>> +  nvidia,tegra194
>>   
>>   Boards
>>   -------------------------------------------
>> @@ -26,8 +32,18 @@ board-specific compatible values:
>>     nvidia,cardhu
>>     nvidia,cardhu-a02
>>     nvidia,cardhu-a04
>> +  nvidia,dalmore
>>     nvidia,harmony
>> +  nvidia,jetson-tk1
>> +  nvidia,norrin
>> +  nvidia,p2371-0000
>> +  nvidia,p2371-2180
>> +  nvidia,p2571
>> +  nvidia,p2771-0000
>> +  nvidia,p2972-0000
>> +  nvidia,roth
>>     nvidia,seaboard
>> +  nvidia,tn7
>>     nvidia,ventana
>>     toradex,apalis_t30
>>     toradex,apalis_t30-eval
>> -- 
>> 2.1.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
