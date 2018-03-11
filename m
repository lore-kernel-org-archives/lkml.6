Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932576AbeCKWqy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:46:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40898 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbeCKWqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:46:52 -0400
X-Google-Smtp-Source: AG47ELsizZurck7cKPiWJKqqRApvXMrq90TOVATYesH28s6gwR6ep5I9eMUVvs6pj9QH0kDlpT80rQ==
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: add SCPSYS binding for MT7623
 and MT7623A SoC
To: Sean Wang <sean.wang@mediatek.com>, robh+dt@kernel.org
Cc: rjw@rjwysocki.net, khilman@baylibre.com, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
 <1520414224.677.2.camel@mtkswgap22>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <25eceb5d-7f5e-8bac-0bfd-ad547520a9b5@gmail.com>
Date: Sun, 11 Mar 2018 23:44:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520414224.677.2.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2018 10:17 AM, Sean Wang wrote:
> Hi, Matthias
> 
> just a gentle ping to the four related patches
> 

All four pushed with Ulf's reviewed-by to v4.16-next/soc

Thanks a lot!

> 	Sean
> 
> On Wed, 2018-02-07 at 18:22 +0800, sean.wang@mediatek.com wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> document the binding for enabling SCPSYS on MediaTek MT7623 and MT7623A
>> SoC. Where MT7623 SoC has the same definition about power domains with
>> MT2701, so it's fine to using MT2701 ones as MT7623's fallback.
>>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
>> index 76bf45b..d6fe16f 100644
>> --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
>> +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
>> @@ -21,6 +21,8 @@ Required properties:
>>  	- "mediatek,mt2712-scpsys"
>>  	- "mediatek,mt6797-scpsys"
>>  	- "mediatek,mt7622-scpsys"
>> +	- "mediatek,mt7623-scpsys", "mediatek,mt2701-scpsys": For MT7623 SoC
>> +	- "mediatek,mt7623a-scpsys": For MT7623A SoC
>>  	- "mediatek,mt8173-scpsys"
>>  - #power-domain-cells: Must be 1
>>  - reg: Address range of the SCPSYS unit
>> @@ -28,10 +30,11 @@ Required properties:
>>  - clock, clock-names: clocks according to the common clock binding.
>>                        These are clocks which hardware needs to be
>>                        enabled before enabling certain power domains.
>> -	Required clocks for MT2701: "mm", "mfg", "ethif"
>> +	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
>>  	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
>>  	Required clocks for MT6797: "mm", "mfg", "vdec"
>>  	Required clocks for MT7622: "hif_sel"
>> +	Required clocks for MT7622A: "ethif"
>>  	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
>>  
>>  Optional properties:
> 
> 
