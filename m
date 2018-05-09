Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755888AbeEIGWv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:22:51 -0400
Received: from mail-by2nam01on0063.outbound.protection.outlook.com ([104.47.34.63]:24874
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753176AbeEIGWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:22:49 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; moxa.com; dkim=none (message not signed)
 header.d=none;moxa.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH] dt-bindings: Add vendor prefix for Avnet, Inc.
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>
CC: <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <treding@nvidia.com>, <linux-kernel@vger.kernel.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, SZ Lin <sz.lin@moxa.com>
References: <d860eb7551e343fa59b77fd3e144a633186a8378.1525249073.git.michal.simek@xilinx.com>
 <20180507204937.GA21052@rob-hp-laptop>
 <933bb0a1-2ea2-3f23-492e-56805a804300@suse.de>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <47d7a8d3-ea6e-200d-2426-d0fe3671196a@xilinx.com>
Date: Wed, 9 May 2018 08:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <933bb0a1-2ea2-3f23-492e-56805a804300@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(346002)(2980300002)(438002)(199004)(189003)(11346002)(44832011)(446003)(65956001)(47776003)(65806001)(4326008)(15974865002)(53546011)(426003)(478600001)(36756003)(966005)(356003)(8936002)(6246003)(6306002)(50466002)(31696002)(305945005)(81166006)(8676002)(81156014)(77096007)(126002)(186003)(26005)(476003)(2616005)(486006)(86362001)(31686004)(2906002)(58126008)(54906003)(2870700001)(6666003)(2486003)(65826007)(106466001)(110136005)(63266004)(64126003)(36386004)(7416002)(5660300001)(316002)(106002)(229853002)(23676004)(9786002)(336012)(76176011)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2848;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT024;1:xYSYlMAqxUr38voGf+QQRIPPexU3kniJ68VHUgrECi42fwsi89jUyI2/GvxmYX6tcxg7/gRBhrPGFwmkqViVjIkGNdUyp18BnYXLIE4oYq9JaUGtW2TuXndCbPH0gjJJ
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2848;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2848;3:gnFbnlOcLmd9WUpFLLHriwyxec2DfrKI5zOMCCKm85JgmxR4zfzXkkeoJPeqZk9CxQqgo/x2JGhaNCW5nv4mnToXOJ/ta0JXfedP9JkX8H0INWaL0qhtTLrpX4GBWVslPuu9gjzz9dBgVAcUca21OIXAjzGC9Ezadq1nsKCpUXaqibHTWZnNqTXxuBuSqhjyDArdzjOVvIqTq2rYf84uqxGYPi37ssvzI/acCjtlBVB2M12PO8g9SvOgDhicaWXRwMT3pzJb8AJM4FIPEDc/NbwyTjPdIk4pyN3YsLWO2XDUILDzTlimzWPkcVU1EpjqIvA7ddOCUucpGLdcaqUsJLlBFJoCx9SeGYmuYgFajYM=;25:Ks2J0oQ9liN4k+gEE8YxxPBop++BGXyclnjJvAwJtpvXFOo4s2rzxSAe7YWXn6fTvylvLbzCLXoIpBLayrj532ZNKJNSBPJjSTAl9jSlFlhNJC/xnslbclF6v+RSwATPkxCgjq/4a0i4AKBXiSgbg/7s6Bf0tJN2qsbJ1nFB1CeHLP3M7cstFVRQLuBlU9WeW03aiEv8xZWq65Tqq91oquZgRRuCiZvXNITaemklsGAls54cUZ66BQwlJSSQD8FagafqeM0vLOMSKkOKr8nqb6oK62RRw1mhuKUZDL7Kxd/ftSKT8Tb5KBSp/Njh/BMhqk+V26daxy+mXiJDrDuQug==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2848:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2848;31:fvAfLXWI0eCOgFgNm8dpWEjaSMWtfbd8Gfx174w+1Ed7Jf8yIseF3x91HBEmds0IcVB5y3Z8RiZTz5pbMxs0gg7TSJYp4tx98ImDMxAxtq7aKSegTMmwOT0zXbD5Sm6GVWughFLQUx5ONkjGkn2XsHX4fEcSZTSoMiIen3+xyHEi+GMftrO/TnN/bXIsbyO5FonyZitAxpDTgh5CwRAMCBfHSJA07OnyhdleEVK1g3Q=;20:cGA6vIqmKxZEYpRd/GSzkevkUu7gvzZd81Lv9qDEV/ET22XizAaeNJhvgfza0AOXmHAASJVzP68MWq9dXS58irlPIU2a4fnN1VHB7+6W6ujI3cETi5laSm28rwbA5qG9ad+pvlFR14PFwQhzKByEQPRy6eWXEd7SWkMNFWpuhal4iPfxP9Xqi+mX+N0N/Pt1sVEHgGe/KmPNY1CfT6AN8BaiJYgznrgpV6IXNKqQkmVVOkEU3QFNHTpuTu4KEvUb02pq0YlnqTajpqoqdPySht5FBzAAl+euTCHDqVoZBgpOvtSj0SL1F+bBvTRqdFuAyfDvkpWRdXS4NJaD5OL+p2Y5dp72EI8uhMV9NYTVYZ4lCaE2eTrJEWQDGffGXYBv40G2Fd41PNdv51NpUN/6lgGmpSJgCmhjwcfQfs6yBxA/p0TM12NdxiAqpTCcV6Po9pIytxeQ7/6MXCpnXI+ikLNR6gh0GCLZAbczhjKc9VT/GAbUwQqpNxaH9iDLTjay
X-Microsoft-Antispam-PRVS: <MWHPR02MB28482E1D9CB59F326F7762D8E2990@MWHPR02MB2848.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(5213294742642)(271673078716365);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR02MB2848;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2848;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2848;4:yCaOuLbsPbL5yzDUoHoFZZixfzmvjGVb2sVBA0qPCk2PD1CwG4lCr9ws96XxfMUWmoFWOt8HFhdsLtv5rtmxpgF9PJLpVVPD3E/Ym1fTsGgsbZAenYRkOa22PZZPgwSGALCuNYZGog1/xOkpjKqt2jbXLE1Pok4P39lXdtF7M/yu+/P1MVwD6cfYymlOn+L7r2Fp7MBLIFTB8RaAVDqfnyk3eB73YjPsnu57QM2HAmD97meVfNEmlNl7ybR7k4YgAfMuKAnrUoULn0b14D5Hy8UVXCyXXpeDECKlf6tl2IDmpGr2hkl69sVIruccid84kBSk4h31QH4JNQx87ezCDVhqhgODGO1CWlSdjxvbfmGjmpNdUyJSR3zi7r7ows+3
X-Forefront-PRVS: 0667289FF8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAyTUIyODQ4OzIzOlZSKzFscUQvcy80VjVocFBCSW5rd3htSUN3?=
 =?utf-8?B?M01QcmRBVGlUdnRXOU9LaWtMWURFWWpIR3BiYitHVzM0ZlVTNWxwRHpocERa?=
 =?utf-8?B?RTRZUSt1N1JsSVRiRmI4c0Q3dXRqRmxzWWZUS0JJK3lQZkZCOVVGWm9SQ1dJ?=
 =?utf-8?B?RUtOWGxvTTN5RXlqMU5HalI0OS8zUFNJU016eUdlbWlFKzZldWN1eGtENm00?=
 =?utf-8?B?VWxFemplNjY5cjBnZktOUVFBRDBjZyt2c3VjdTFhSURORVhscTR5WmU3aGho?=
 =?utf-8?B?Rk9Kb281TCsybTVBK3p1dkl3b3ZDck5zK0pzUnN3eWZITEh6Z0IxTGJnTUZJ?=
 =?utf-8?B?VHoxc3hhVWNpQnVvM3lKNHg3SkJwTi81c1pEb3NiU1VpajRFMDl6d0xTSk93?=
 =?utf-8?B?czJldkFWNkRnZDZrVWJva2xRa2RVYlBCZWV5M1cyRlhYdko1S1JRTWpCeEpW?=
 =?utf-8?B?cUY0SzhIMGt4VjJqMkpIUmk5QmcrbDNCTjVHMSt2YXMzSzY3K29VOHBDU2hs?=
 =?utf-8?B?WFBUeUtjaG1HTElRUEd2OElGUklwKzI4VU80SjF1R2RYbzhheTc3WG1hYmZK?=
 =?utf-8?B?Q29yWnFmTkhKQTN0cEYzcDFIczAwRDlUcjFzOTg0SlpuMFlid3UrdW0vOTZL?=
 =?utf-8?B?RVppSXN4bU9GODVjSEhuVkR4U3dvR0VmRXVjck1rQ1MzM1lQbXpMUlFDalBT?=
 =?utf-8?B?aDhCdDFJMjNuR1ZnREw3K01hNU5jSklFZUM0UW56bHNSNVUycGRET21LRU9s?=
 =?utf-8?B?cHR4cVF6WGM0dVZid3lNcWY0TmlteDNrVkJrckhXWXVhemtRREZ4b1NmL1JO?=
 =?utf-8?B?ZmZzUjB2WGtYdWplblp1ejg1SHAxUnJsVktkaTBPZjcrL0ZoTHpSMUh6T0tR?=
 =?utf-8?B?YTNSMHdYZUJYWmozSDgyWUNFWFFvcVJZTk9CVzdxMDVRM2hCcDFMU0xqYXIv?=
 =?utf-8?B?OE9vNkVTdkRpRENJSDErWnRkRmRoS0N6OFhWTllza29CeVdDRTR3eEFVUVdP?=
 =?utf-8?B?RGh3RnNMcmNnYnJIdVJwS0k3K1k4czMveDJhZGtxV2FTNDFNcDl1dm9aOFgz?=
 =?utf-8?B?UXVGT3JWVmxFWDR1MWovSWM2UjBRbjJjNjQ5S2luZ3k4OVJtbmZTSmdyN2hK?=
 =?utf-8?B?d0d6YU8ybEViUVUwdmVzbmhiTVBMN0xDVW83ODdoSmpFTGEydzZhbHRRcHYw?=
 =?utf-8?B?SlU4eFh5SmNyOThqZzFhZVhYaEtXdjNkaTloQmgycFBGVDAraUVWTm9scTBj?=
 =?utf-8?B?cmcxVGJKSXNHRHlrancyb1piVTdORWVCWFFoaTVXTG8rZjRtRk9lZjNtSkZV?=
 =?utf-8?B?YmhtTkVRcHc5emVTalF0c2FvWlA2RzY0ZjF0dklaNkpPUThXUWVlZ3gycmVa?=
 =?utf-8?B?VU40aHFCcG9ydHVIbnZnZ3RIUzl3Q2REVWdXZHZhSm1aL3pmcDk3Vnh2ZlN4?=
 =?utf-8?B?RUo4bjZUbnRkamtyVlhjbGJjWnFNWVRpRkt5OVZsem1HTVJINEF0MXEwdjY5?=
 =?utf-8?B?b3JVODEwRzQ1WWlDWjFBZDJPdWg5NG9XK3FOcjAzUlJWd3pxb2VkZHMzdWNU?=
 =?utf-8?B?bWRxQ2ZOZk1FRlp3R0gzN1R3bTFWcEQzNENLVXkwMU1xdytCaFFSSGpjN3g1?=
 =?utf-8?B?eVczKzUvWUNMaHlSdHNUaWZPSlFZMHIwNzNYZFkvY2Zwd04rSzQrengyV2ti?=
 =?utf-8?B?Z2FJQWZUNG5jRnlYd2xZRHRkaGFLRmdUc0ZoNFpDSTEzTkkzbzhuRzBXY1lH?=
 =?utf-8?B?WE8zakpNcVkxS0lnU2FuVlM3ZzZIT2E4WjhOTXZwMDlvLzhyR3BEQmtzRW4r?=
 =?utf-8?B?Ym9KRGcybUNKK2hMZ1JXVDVENXNUMkcxUDNtSng5dmFQcW4wWWVPSW5KZkFE?=
 =?utf-8?Q?iq0aPoa5foNKFdkg8WxgHlFEduN+jT3S?=
X-Microsoft-Antispam-Message-Info: HNYlCn9kaeFC/XlgByBcWH47S0OxcJhXXGHg4/UHgW3TpLCcsvOe4Y8Ra+Eh6a25vNOX2M8/sMISyNp9WB8dmT5Qf0odxaYEXMdqH7bdk4oFA1T5cNuR8vfuUU7ww10qW2pRuxhUu+I9ncEBOZY+RzxwHXq4278rvurTLpovEHu8UMJYqxtgtONJXLmbD1Rc
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2848;6:90gl+/lej64JY5+ccU9eR/J9/PG2jL0Txt9B8SYKo/IktSBlORybmYSMy/NLgtUt0Ca/k0lYZGsisWdhSiosc6Q6lS50UoLtgi00NSlDE23Eeqd1164oQk6G+UziMS9V1wofl7JhPx8/8S4HUmeLav0Lj0AOGzKZJmnViAIefUvTRxv5oRSAKLRtOIExSGJy9EinhSIwqrT33gU0Ohxu/QPF0SoX5tDo4/UJ/KM7oKwKpAdZq5uu4CF35HuaxkEo8F+FllR6tV/Q8l856kXd3UPGWew/gl8Qza3+JMjwc6VBPtfLFy/nhWVfzkXPBDgd9KK3BAMvjfROgE+f5mRxqdrfK5DTQJA+ZfNtrhM/VlS+gEVTe0nys0UVNygvN+BadXGJEP/xrYnJyIiiOroOaKRtL74h4xPH4XurKWVtJdI9CZyJ26kDrR42c4uducE0CFem6KcOyZrCfWmschEGtg==;5:iKov6egVCRUB+kXwEkUr/y3LEP7gNfUzE5htVjzEZgbhzmIy7CZonYMg0lICzRG3vi0IkhBSpmXj1LDiOI/ZkOV4jkKUwHgWW7qg/F57ThoPVnxqfTtIAxSswdIxKPS050OoFWMOumZKjTiQc/F59xQqolx405yMEfGM2M/wCqE=;24:JlSbYG/57FyV4yMgd6f8L9FvVanccFFsOs3BI9xwnP+KDts4i+1sQJhCvXMq2g61cLE/U17XGwtwRSBjYpUk8Bk5mSXuXxy+oXJJNfdvtSs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2848;7:Fkc9XB2k6d5YQL+9LUD8SrnRByFJc1JupcIgsQmk2p18o9afObaA8AOv1FJ1ZgiGlGgip0LXiqoBeE3cnDqTW/I7rJ1LizC/Rg7FUx57RkwYPSr5FU4RoRcuJAiAl/bne28iRBebcBTEJr6GUQyiqR+VOdQRUd5H25/D3N9QikQnle84znCHlannHFE8Zjt5ZKctYTSPzYO+OJETMMQIj0yDxXfHOiAwdwgLEATsXnC5aDBvYLAOzEoF+yFgcb04
X-MS-Office365-Filtering-Correlation-Id: fe14d945-6181-4781-f1f9-08d5b57546e2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 06:22:44.4399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe14d945-6181-4781-f1f9-08d5b57546e2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2848
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8.5.2018 14:15, Andreas Färber wrote:
> Hi Michal,
> 
> Am 07.05.2018 um 22:49 schrieb Rob Herring:
>> On Wed, May 02, 2018 at 10:17:57AM +0200, Michal Simek wrote:
>>> "Avnet, Inc. is one of the world's largest distributors of electronic
>>> components and embedded solutions." - Wikipedia.org
>>>
>>> Website: www.avnet.com
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>
>>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Applied.
> 
> What is this standalone patch needed for? Looks fine, but it doesn't
> appear to be part of a series using it - is it for board compatibles?

This file is used by other projects but that's just side note.

I have sent a patch which uses that separately because it will be
applied separately out of this patch.
https://patchwork.kernel.org/patch/10375553/

Thanks,
Michal
