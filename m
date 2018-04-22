Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbeDVUDA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 16:03:00 -0400
Received: from mail-ve1eur01on0120.outbound.protection.outlook.com ([104.47.1.120]:22976
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753438AbeDVUC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 16:02:56 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Subject: Re: [PATCH 2/8] dt-bindings: display: bridge: thc63lvd1024: Add lvds
 map property
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie
Cc: daniel@ffwll.ch, linux-renesas-soc@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1524130269-32688-1-git-send-email-jacopo+renesas@jmondi.org>
 <1524130269-32688-3-git-send-email-jacopo+renesas@jmondi.org>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <17d6f6b0-e657-4a5f-63a6-572cdf062bd3@axentia.se>
Date: Sun, 22 Apr 2018 22:02:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524130269-32688-3-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM3PR07CA0121.eurprd07.prod.outlook.com
 (2603:10a6:207:7::31) To HE1PR0202MB2777.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:JlLzgvodorTgJcvAe3l5aodhDodVAd8Fi3dPtj2pM2yMn3p+EnvZFuo1lPNyeBuDJHR0wwJmuLSNlhw6t7RKb1Th+eT6dp+ySII1+ZHp9oNdfyEZTenoo0uuQqntwwG6VMxbrd0cicfqEiQtsC+6odtEsMNbzpQQYH9mfoRxp3ej5zy2SwMecY/lv7DY7HTO/6N9Yz58iO05K+p1DSEb7joJrD0H/TsVnENTQPzEtXWDsnT83+cqBbWxxQGhOvs8;25:dUFywWb2m0v7XJpCZ6jV2fAKcTE45ds/kT9wRQnhwBtO6l8k/An2kJM6YyooueXhcOiu58JxfFycbEjjYl2BuDmKMxYIlS84yFljg3gR0+sP4G78JRoGsNvTIJSAJPYhEv+ksUzIpSapaAfyyaq/kdoYD1sLH5bhwUr1pUYCUfRai+sW1ZSwLJyFFS5B1liHjxpWJyDODYnlUTugPYt6sAmcZXlUMI9gphO1X1ONC2mPxsLVmN49M85awcKtNUvDTdI+b3CLENtgX5WHp2x0b40/8B+SMBOwasAsliGwNOu3Ckt0wEvPUb4Te+VsmiFZStShQ0kKMUOqwuN5PnA+sg==;31:c0mldsy2fzE4s7c1v6AlLefKYGPGaEU9zjGwxU7whAS1vSb4SBDQyMVx4k4f9agA6UsVTNRg+UDutcy3+8a+PXwFG3uJjNfVb18Zw4IrsdbaVgr5XI7qYPqNgnwC48jLQfwRg0UObHA7QWYZIAgByUgvNpKCyqU6ys3OjOSJsszk+s/DstMna39eeCziaHPakSOB3bsNZUuiYyQSOrbTsPoLDexxGNtlwuI67aJFBeo=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27773F6D9ADC5EBB17830577BC8A0@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:r8eOHFZJaZmoILLTowXEKoL3NWTIw60CMrAiLSepdmoremxrn7rQj0Ms8whygBwbFEnFqojWMJg29d8SUNiTrdJTI4WVqWUNcSt5+LAdobd1xRVEqYhsBhgnrV87M1amzk2yp15V2HJk2H33j4rFvxYZJPPucO11hjnEcRhWrkIlr+bIxtqPGiSw75QduIVoOfg4xkOZiV0G+dzzjVeLiNDTAdiduu/m7HT1X7/KQKcYZ1BAEdlbKbCPGw/+jikCgaKDMTZDTJKW4y+LFntniQ==
X-Forefront-PRVS: 0650714AAA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(377424004)(47776003)(8936002)(575784001)(6246003)(31686004)(86362001)(478600001)(50466002)(74482002)(4326008)(229853002)(3260700006)(25786009)(31696002)(81166006)(8676002)(2906002)(117156002)(6486002)(11346002)(23676004)(2486003)(36916002)(52146003)(16526019)(186003)(16576012)(66066001)(230700001)(5660300001)(65826007)(76176011)(52116002)(305945005)(53546011)(316002)(446003)(77096007)(26005)(7416002)(6666003)(36756003)(956004)(476003)(3846002)(53936002)(7736002)(386003)(6116002)(2616005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzc7MjM6YkVwZHpTTEdvQlU5MVNncXdWVVRKaXZQ?=
 =?utf-8?B?MGNZcm04czBiOGtJVnRjQ0pMS3hBUVp6dG4rLzNiMlAzSW01bWNFdkpkR2gz?=
 =?utf-8?B?d0FPNEQxakdkeDBmcHkvaVJySEJ5VU5yOGNSQ3YxSGJHSFZJbjd0VmxoOEhw?=
 =?utf-8?B?eS9lMHcrQm5EcmZNRzJTYlVXYzcvMUJUOGMzRTNIR2FNYytSLzlGM1plaTRH?=
 =?utf-8?B?cE5zL1doRXRsa040OFZ2aVVPUU4wSjA4ZXRsN3cxVWRYS3ljY3N5RXcwYmlm?=
 =?utf-8?B?RndxQmpXV3pTaEVCV2p4Tm53RWxUdmQvV0N1MjVJbi9uMGhFZEVwR0FKWFV4?=
 =?utf-8?B?SmdRNURxZEdCMDJ1aW5pelJjVXkrbDFtMTRMbWpuY1Q2U1VENEpUTkR1VGFE?=
 =?utf-8?B?SExITUo4RDdIV1VGcCtXK2Q3czJJRnVsYXlDTHM0cUZQNlB0UHNZTVBFcEV1?=
 =?utf-8?B?NGh6TU5sYUZZWlJBYUgrWWtLWDZ4aEJuRS9DWWx3YTJYNklyTjhmd1JTTEsw?=
 =?utf-8?B?ZFdXeG1lL29SRjFGbWRPbHFzYzd4Z09FNFZIZXU3czBEUzRiallRRFN1emxm?=
 =?utf-8?B?T21pbU4ydmtvbFd1NkNKYm9wUnlLeGpYeW05dXFZQTc3UFJUcFF3VzFjZmtD?=
 =?utf-8?B?WTVYTjNsb1pIakdhY01uTlpUdmFUM2s1SWo1TjVDUVdwZ3V0MGZUZW1QS2Ja?=
 =?utf-8?B?dUlXcGFpd25PaXhXM2lFYzNUV2lackNRSHB0RnNHNHlTRnNPWGw5aExMYTdy?=
 =?utf-8?B?Q2NMc3ZQZFZEUERMcWdyYVNEbzloUitWeFJYcVJSOThPbnJPK2R4RWxaQWpL?=
 =?utf-8?B?dU1SaFM0VmJUY09VZU9SWDdkWjVFeHlXMDltSmszU0dRT2lFSG4xSGhUYnI1?=
 =?utf-8?B?ZWhYc1hqdUdteE9DWlNIRWh0NDF0dFduK2FGeGZYOFEzWWdzQWpEQmNiY0ZL?=
 =?utf-8?B?azBNNWpTS2dRTElhWVdNRVNhRjR2QmJXUnpZb2FGM1dFaUVNYXBPNkgwRWhJ?=
 =?utf-8?B?YmJHTTRXWjNYTE9oZXRLbnRxamFTQzRpUFlMbVU2Q3NVRVpKUi9leFQzRzlr?=
 =?utf-8?B?cXZUV2xZWVlycXA3MmlsVU1MbXRMdnd4RHQxdzM0ZWtiVnQ4dy9mM1FHVis4?=
 =?utf-8?B?NVh6Qm5Md2lkRlc3SG5RWjFZNzZ3R1hDdTdqR2ZhQ3d0dytncjdtSlMyNVNq?=
 =?utf-8?B?cUpWUGlPUUZsb1c1N25jWVVpUjZ6d3BlUkVIcVUvd1lKcHdHZTZsc1ZuaDhH?=
 =?utf-8?B?b0FuL0xnT1BvYitDc2ZIRzRNbkR4bGxuMlB2THo0d29RQ05qWGdoN2diSy9p?=
 =?utf-8?B?SndtamlnQWhUaEJSTEVlb21SRWc1aTA3d3pUWDVLd3ZiYzFCY3l3eFRTcEtI?=
 =?utf-8?B?ck56T0Z3ZmdBY2M5dC9VSkRpTVYxZ1psVm4vc04zVG9ybmNIa01QcFpCZEhk?=
 =?utf-8?B?QU5TNURGTmxsODVSb2puc3BuZ0RnV09VVzBPZnN4R2w1K1FLNG1VdmJJVVRU?=
 =?utf-8?B?WFNTdzlZWkZVcER0angyTTdFZXQ0WHFGNmdPd21GZDVwbktHRmJ0UXlmc2NP?=
 =?utf-8?B?QmpmR1JrazErMjhPbnB2d2dEOGl4NjZMS1pCR0E5SzdsWE5NN1gxVzJKSEV4?=
 =?utf-8?B?VGxYd3RFM1N6Vm5NNk5uRHFpR0lUd2VtTlpiWGtkSVUvaDlMdmVIMHozUTZS?=
 =?utf-8?B?Unl0d21JcUdWUlBTU0ZaRkZIN05EcFFoWENyZ2EvL3pjZGhvZEl4Qm9lM2VR?=
 =?utf-8?B?SjA4QWcvZC9iN3RiY2wxcVhRPT0=?=
X-Microsoft-Antispam-Message-Info: QpsSM5AUd1KZ9ujOndsxQAThxPlkVWxy13yRRlpi6ioMJJ4K2oBfCG79Igf4AF5vmWfy/SnG/yKDWhd574CMAkiSlCx0FJiPEfYA4KHj77uw4y1+8gnNuOg8gwCaiVUnhw1dt5UuBzW3NHq4n8YaC+0UCgzR4Aj082MYld7OWDyzRV1Mx4mcVivqL70uw9iW
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:I0T8K9QEVc90+PFCrexWHNUINzfi3cwgvf6lEzBc/xoVc5hLYYQM2rHaEc9z9t2cXc1KbKUnRjwbalR/yOta6YJ7n5kKdBZDmUWv+efltVjGH2V+vxfEARY6vENioAb87yPb9L0zqaxB098lk+Dm9uk5JRELyAia4MsQUltDeu4MjIAyvSLJvBVjX6G3IodqL1SIJSBO9UXYuukvQjRL7BZ3Z2bPaOfOSE2zvTscIkfGeSCEywSpMfVK+Hxnvh7FukmjPjJxBOFx7tkOHja5QdPpHy+TE6iRAYyWaVaczSjKR0BinDhnBb83NjF7MR6klnP9LWDaOWdpKDhUur7OTF8F39G+OGaidvtlWTnB1oRi36AqYwIkf/6rRb8xkbRn3vNpQKuKuyQvQyS+MTC66q+b67u/QJjcVlcYe9o2IPT4c97bJrmw7qoj1DZMObwBaeoPPKjLmlYZePazzornUg==;5:k9otwTzcmooiG0JbLpiA10HEpGSe53QxbI0h7qJv8BZYe+eLhKwUhklPWDoVCr8ctqAMBGeAaGav5ts20FMO5v9a1SsbGuKtEV2k/ENUjtVKq/l58R0c0dBOFI0gfJaWLyZrjd1wkiLBpWkEdASBSAYjTTOxBS3DVNv22gWNpN8=;24:ylciVRwmMJgs/vjN8fq4XApbwiX17zc67WMZOwIv9o3/igJ7gThHeuE1kVH5ocecNZ/vOy9wQeReIH//TIoyboMEv0Ash10sOasPas1+zYg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;7:vRwQ7Y45wQ2AR2YeI4RJa22BBvKMrpVdFfoC2addQksreL1iKY4CYfnFSyUqg269D8yhQLPy2L7fauCjS3LWzbhmZ4tPo3jqtEaVVCrZy5ZgMDl8KK+Gny4VGppzUOilWEx53tipT5dwTZr3bn01xsAQiZ6QfbZuLklwCNAnVmyEf2FquQHnVu5TiKPFwSDgQei8/gfIGFHoCm4X9ilbPiKzngVlKiCU0DWZNkx6YOxoeDZ69QodOXvdeB5tyulP
X-MS-Office365-Filtering-Correlation-Id: caccc68f-b3fa-4a2b-374b-08d5a88c0777
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2018 20:02:50.4121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caccc68f-b3fa-4a2b-374b-08d5a88c0777
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-19 11:31, Jacopo Mondi wrote:
> The THC63LVD1024 LVDS to RGB bridge supports two different input mapping
> modes, selectable by means of an external pin.
> 
> Describe the LVDS mode map through a newly defined mandatory property in
> device tree bindings.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../devicetree/bindings/display/bridge/thine,thc63lvd1024.txt          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> index 37f0c04..0937595 100644
> --- a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> @@ -12,6 +12,8 @@ Required properties:
>  - compatible: Shall be "thine,thc63lvd1024"
>  - vcc-supply: Power supply for TTL output, TTL CLOCKOUT signal, LVDS input,
>    PPL and digital circuitry
> +- thine,map: LVDS mapping mode selection signal, pin name "MAP". Shall be <1>
> +  for mapping mode 1, <0> for mapping mode 2

Since the MAP pin is an input pin, I would expect there to be an optional gpio
specifier like thine,map-gpios so that the driver can set it according to
the value given in thine,map in case the HW has a line from some gpio output
to the MAP pin (instead of hardwired hi/low which seem to be your thinking).

Cheers,
Peter

>  
>  Optional properties:
>  - powerdown-gpios: Power down GPIO signal, pin name "/PDWN". Active low
> @@ -36,6 +38,7 @@ Example:
>  
>  		vcc-supply = <&reg_lvds_vcc>;
>  		powerdown-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
> +		thine,map = <1>;
>  
>  		ports {
>  			#address-cells = <1>;
> 
