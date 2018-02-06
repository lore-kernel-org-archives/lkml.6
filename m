Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeBFOCM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:02:12 -0500
Received: from mail-bl2nam02on0062.outbound.protection.outlook.com ([104.47.38.62]:14752
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751190AbeBFOCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:02:03 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 2/7] arm64: zynqmp: Add support for Xilinx zcu102
To: Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1516366474.git.michal.simek@xilinx.com>
 <63760114db981535bf22c25be2daf0049f1b9709.1516366474.git.michal.simek@xilinx.com>
 <CAL_Jsq+N-_8s0d=jD=fMD4y7e76M=tT0kt2vsH0kbOqs-eQ95w@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <e29f3553-2452-05fc-568b-17395a42bd37@xilinx.com>
Date: Tue, 6 Feb 2018 15:01:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+N-_8s0d=jD=fMD4y7e76M=tT0kt2vsH0kbOqs-eQ95w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39850400004)(396003)(346002)(376002)(2980300002)(438002)(189003)(199004)(5660300001)(65806001)(54906003)(8936002)(305945005)(83506002)(6246003)(356003)(478600001)(81156014)(2906002)(7416002)(230700001)(63266004)(186003)(64126003)(59450400001)(336011)(110136005)(106002)(76176011)(50466002)(8676002)(2486003)(81166006)(23676004)(106466001)(316002)(36756003)(53546011)(31696002)(26005)(47776003)(4326008)(31686004)(36386004)(58126008)(77096007)(65956001)(2950100002)(9786002)(575784001)(86362001)(229853002)(65826007)(6666003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR02MB1338;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT062;1:UBGorfBUo+QYb8Feuyo5wvey5KEBo5C0wEcNAEZn/0Cyx/gwZ2w3pjCGYkRuSoJcZ/QlTYt63FwGH2qpASx+CkgR65Ko8RVGC9/kyc4kL72UdT0zmnj9SKrxyI3qC6BR
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5abe3368-90b5-4dc4-8adc-08d56d6a30c5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:DM2PR02MB1338;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1338;3:RHoDiYmZyinur8glB17NzrJFKyoYzaP+dE9dLeRLNqnRj56usqrDYb8UYi3JH5IUaA2/m5HunQee78Dtg5SBSY/V79ySBy5S6Fe69wPeEsqC7ZTAu2tc/y+Z6w7BTOQs1yAE3dWZF1XpaU/QP8WDev+u3ODLnHMQPRXmsMG/AjW/yR9seqqOW4xCiCYfjmzT4z5zB5dTsk0Hm/rOHbYkUOcLyH86a3oIO4uECgxZrkJwd/DhBZUSzzMYrcdsz4o8BjlKUE6gWllUQ7sSI7C/GJWQiETvFuK5sqxnJnjVBomq9u1Wk0sop4pYY2xv3nE8WtAPpiRCSTaFEsrT+aY76JcmRX3HzHasl3qo3PtgKoA=;25:v7XU2Di4hzf8gSfvjzjURplr5cro/RhuwZfBcegfRUVyOH+DqGm5S2uR/cM4WVPTPOvWnK5q3WkOAKCOepYU5+Irs/aOKusFnw/SQuYNjvNhtBcaLFhgx9L97wqXI5KceMlkMXfyRtvo+i4do7UKvvcOviALnbGry82S2NkZ3uuwSBkUOUcGvd2dVLzkdLMO0IkE/rWSePkIspAAVQ0YbkvRQkPJsMkQx8Bkni3kJ/AhTsY2ZF2hyXf92Z0/e5kOVQd363PMrkmTwFRhM14zwqZy9jzF9qpTkE7zht+N3djxwGCFfseCWuffUbhJctO46cYjqDqtHrpBkdFmFQNM2A==
X-MS-TrafficTypeDiagnostic: DM2PR02MB1338:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1338;31:I45uWy9gH+Lgg+IWrBuZXZ2L+bn5OSJ8oP64oD/CTjYz6Ckd+vO9EB9EQt8venUtBLIibQhL315RvuTJ35wH2LLl7jKfjuUhlmGepsD2tlmBhWQAXQEKHvgsB9J36K3rmz9jjUPHnJ3bmgjJ8Wb/trmymjnt1lA2h8LBANhODK4NLO4sknkQiLodvE8vjKxRzm+QWn9RQ4NxmgBzD7SmBh7zagYHgIEiumdXh6UKz5o=;20:viAm4UVOERAg3jwcB0TfO+cfJTAg6pBy2bEMUUYivbs0TLZmbHwf95hRaupx6dl/5QpTZJu0B09rPpCG0NxwsEofSOVVS6MftQa1/PhQluRsWy8J+bM5a4yj4ROL8LpB0/iiLjqkNoWgN93N+LaWQF/w7x11yyggwELJ3/u3K0Y1YcWnsjVOFIHpTGjj3OGzmWETesCfcJPdbFRHbB/qo2DSLiexfhxmMJ5qJujwKEqXq5Mq2wgOvCyivbQWqjELQwf6zMvFOvvQmaqHB6k8OcU/r/Nypq0nCVdP7FyTLotn3jVCVZ4f3jodB/SJkmxmTjga7tkQezXdJMukH3QwqQ4FJtCco+Y6WkIJuKK4eiSFZg59Dz8Nawza0UsLfCdDfMhgY25JuJdtZr772QqMMdm2bwhS1MDSiuxjoX/uv0BKEOmWGQVRutYGWvtpdvkX/QVNcYy+2ofrZm4GFm5xri+uTNS7mQpHqj5wSBePTL/KfnVouzIswf29rWA8j4nA
X-Microsoft-Antispam-PRVS: <DM2PR02MB133833D9BD81455D43BBCF96E2FD0@DM2PR02MB1338.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM2PR02MB1338;BCL:0;PCL:0;RULEID:;SRVR:DM2PR02MB1338;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1338;4:ZGa86hzOPu9D9S4+QkpDLmxFEyNhFLSffDFrLQUcjUCcKnzCsm/UINJf1tey6KCDc6EpPCRmMNMVkOLlls5ZepToP3Qr+zQa0x+pnnF8YDBHceaa77udgAloce7ShDA/qDB/KfvQEABJ8W+5IXFXhCVqx1yRk3cShcoHjZOIqTx33fgO8K9Z0aspBYFsSoSodwO5z0h3l6INj7zkXnQ7vf6r1rg+8C1vWVhZIZpF+qjCuyR7pDDp44DhpySlP82v9j8N2YxvWFSG6jGn0JOl3seHysNTL4XZ+plKet/v0P2PWxYLfc+98J97DtmPyZXb
X-Forefront-PRVS: 0575F81B58
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjAyTUIxMzM4OzIzOklDODY1T21HdkZ6dHNmUHloRU5GSlgzeHlx?=
 =?utf-8?B?QzJHWFBtRU9teHEvemFTQnhCSGVOUVd1cVUxR21jN040ZUozMXVTZERwSEVT?=
 =?utf-8?B?bmJZaGZ4NnMwem1LNDZGaWtIRDZ6VVFRYnIzU1Vhc0VKczhWTDd0UTNmZVFW?=
 =?utf-8?B?T3ZmVlo5bXJuWTVZL2JubUN0dnFhZnYvUjZ2WWg2NE1sWHdhZE9aQkc5UlRH?=
 =?utf-8?B?cWFON2w4Vzg0R0hkazlOVEZEUFJuSVpNTW5GUWVZRXNOd0h3TDdvdHp6V2NS?=
 =?utf-8?B?bXJOK2VPemtMZHlJRll2L1pSVjR5ci81bzQvSlMwRkFPTVZwZ1ZReVA1TmdZ?=
 =?utf-8?B?ZHpwcWZNQ0M4d3RDM2g2emdnK2JqNGZkVS96MGpWNjg3NUFyN25MSnZXYnov?=
 =?utf-8?B?U1Y0cVZsSURsVWN1UC8zSUdNRjhzWE96dVNyeE53OGZKam15NTR5MDBCNlNF?=
 =?utf-8?B?eE83bFI2c3ZDYTNabEhsYlRYaUx6aDNFOG1mdURuSFJRa2Fyb0xCRzVFVUxL?=
 =?utf-8?B?WUM5OEtyTEtqN2J2KzJkWHA5N2tvcW9ra2I1SHRKbEFUaTgzMWtESWczWllH?=
 =?utf-8?B?bWRNb1AzMjNkN2xoL1ZXUUlBbWU3NkJqaFp1Wm5zdUpiK3p6ZitmTmhHNlBk?=
 =?utf-8?B?QUxtVGRFRGtFSC80S2VlL2dQVCt3Y3BiZnh1Yldzdnpyc29yWThJdXZsVk5T?=
 =?utf-8?B?Q0d4dmc1L0xDaDBJZ3JXUkpYV1NHRm1VQnFjK2x3S3M3L3lxZHdzeTdhMVpj?=
 =?utf-8?B?MHpLdzc3aDJRSUkyYW1PMDFEVGk5SXhtcHFVb3Izb1E0Z2pHbjhqS0JoOUla?=
 =?utf-8?B?U0hlVE4rN2E1VGswYTIwd2JvVFBCcUc4WXhROStGYisvNXNqMXdVMnYyTkxa?=
 =?utf-8?B?T08vZy8wdHQvTXpwbGkyMERmejhQL3h2dk9FZ3UrUWU1WnphL0Q2MUMrMVFs?=
 =?utf-8?B?My83WHFraEpkWTZoQnBGYitHbGNtZ0ZTK0poWDJoS0xRQUhKV1NBNnpOTHhW?=
 =?utf-8?B?UWFVSStpclBwQ3E4cElDd1BRL0F5STFEeng4ZkVkYXFkdWZMY2g5Z2hmOTVv?=
 =?utf-8?B?SWxCV0RmbEcwMXZRaTRIVXg4bCttSjFUcVBFckhxdExJTmkwRFdhYUlzWUt5?=
 =?utf-8?B?VTlzbEZXT3FKN0FOUG13TWlhVFc3YTlyMGs4TGozQitUazN1YlY2QkJmRGFw?=
 =?utf-8?B?OCs5cy90UVh1YlVGRFFvZCs4S2J0dUlIRmZnMVJLQlB1SzhQUkZJMk9kWWJJ?=
 =?utf-8?B?Sm9lRXlmVzVYWW1KcGNlMUZCakVOWTAvdlpQclZGT0xLcUNadlVQOFAxSjBX?=
 =?utf-8?B?NE10U3Y2VnlyZ2d6SHNVN0Vka2tjU1M5MXdYVWg4UGFtaEtzY09ZMDlvWGJ1?=
 =?utf-8?B?aHR6RHBwYjYzdlpNeEVCMXF6RWlZdEpaOENhSW9SalVydm15U1dNTERMQkVa?=
 =?utf-8?B?R2hCS01KcmQ4OGx0UXlCc25FaGsvNE1OQm1WN3R6UmZYSmZIK1p2WUxlSnMv?=
 =?utf-8?B?dnRsRHZ0am9BTU5IT2RtOTByS0RybWxPcUIvd0tUWW8vZzlzSFBQS2VaeWZ4?=
 =?utf-8?B?MlNxajBhU0tnZUdsUVlraGZDZWhBZU1VUkphR1V6N3JibkNLNFdUekwxQ2xx?=
 =?utf-8?B?K1JGUnlTNmY0RHQ5YUpqZFRFam1zMXhkZVUxU3ljM3FjMFNKdGNPM3R3aTRE?=
 =?utf-8?B?THNtc29Hd3p6Y0lFQzFhT2VOTjV4SVdVSHlNL01WRjhkK0ZzWHI0Q3hNd2FY?=
 =?utf-8?B?UEFmL3FkYkowT3pQSmpQQT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1338;6:zsvMZ6YCbFTd+hMuEHM1adK6vckqWtKHvbfJZDntpWSMUAUuQFncyTZqJ4J4Tn/958ekdQ+8yTaGxA2JUXm7q/eHMPJ4W5rNyd12RcV0zbURLyDXY6sGajCg9eNytktTdSKg80pAqneNqvsSfoG/4gu4BlCkO1aQUZckzr1dt4qNaR96z9V13vuAsp2tyuSL73IC1pLF2LITMvJIwJKu5dXlcODH2g/bhgHrNDkYGjw7z0qK3SBKewY33zvYXolrumLaUO1tac5IocbxqFakQtc2687RCGttZ01kCvRw0h7XEEpWYIOz/tEZEJmAFTeIq8TFb+BPvbWgtkxR4OT8AP28+NTlUrKJrrhRqjnAjP0=;5:59w36xoHOptgpQK20lxOccw5RR1AVckspRFqqxZY/bg22/LkCk+YuWYPQQ9VqaWEPo1cdq8NDHJf/vQOLS/pY91ZDlS0pA+kYFjxiNvi7ofiag6PuTPWZQRlhA5xcIX58/vh7I4stavkoODHYkrdRoH2d0wpoZbO4EtfP5RnG1g=;24:fR5DofatHu7BphCg42uYmnFMfhTyYRvwOtne/bbUsb/YCXaLlo9WZvsDqFnw68+F1+1qizKSOg4NnvBrqutaiN+MgEaivbuG2R6V3LXHG8o=;7:rG7Z5PLbNUzuKO0+k5wK/wnTUmPknlf6qAkfzk1QQubqRIh4/iJ7pQC/jgSGiKeDXiBQyE3QSFO9U6piPVyTf4bas9TF+uvYZl4vM2mJ1Nnr2D3HLqQ6QnlBfzmRUtpnXrz0YUTxKu/AkDOrs1BguCJe8c3nTecE+W6Fu8uOCFGT3jxjxboM68vJLa6DhQMBxeboPKqY69KQ0FmjG/ZoLJ6+YIoZEU59+J9qdCZj/xLQmYn48xAACCSM50wwFxQo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 14:01:59.2506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abe3368-90b5-4dc4-8adc-08d56d6a30c5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,



On 1.2.2018 17:46, Rob Herring wrote:
> On Fri, Jan 19, 2018 at 6:55 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> This patch is adding revA, revB and rev1.0. There are also other
>> revisions between which should be backward compatible with previous
>> versions. Unfortunately all revs are still in use.
> 
> Similar comments to the 1st patch. I won't repeat them here.
> 
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  arch/arm64/boot/dts/xilinx/Makefile                |   3 +
>>  .../arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts |  36 ++
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  | 556 +++++++++++++++++++++
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts  |  42 ++
>>  4 files changed, 637 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
>> index 7266a6a9c0cd..24e3ce801304 100644
>> --- a/arch/arm64/boot/dts/xilinx/Makefile
>> +++ b/arch/arm64/boot/dts/xilinx/Makefile
>> @@ -1,3 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
>> new file mode 100644
>> index 000000000000..4b7477795fbd
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
>> @@ -0,0 +1,36 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * dts file for Xilinx ZynqMP ZCU102 Rev1.0
>> + *
>> + * (C) Copyright 2016 - 2018, Xilinx, Inc.
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + */
>> +
>> +#include "zynqmp-zcu102-revB.dts"
>> +
>> +/ {
>> +       model = "ZynqMP ZCU102 Rev1.0";
>> +       compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
> 
> Documented?

Still waiting what exactly should be documented and where this should be
added.
I have seen that broadcom was doing this properly for arm32
(bindings/arm/bcm) but for example brcm,stingray is not documented.

I am happy to document our strings but I would like to do it just once
when I know proper location and style.

> 
>> +};
>> +
>> +&eeprom {
>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +
>> +       board_sn: board_sn@0 {
> 
> Use '-' rather than '_' in node and property names.

I will change this in node name even based on spec and Table 2.1
underscore is also permitted. Maybe priorities should be reflected in
that table too.

>> +       i2cswitch@75 { /* u60 */
>> +               compatible = "nxp,pca9544";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               reg = <0x75>;
>> +               i2c@0 { /* i2c mw 75 0 1 */
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       reg = <0>;
>> +                       /* PS_PMBUS */
>> +                       ina226@40 { /* u76 */
> 
> Should be what the device does, not part numbers if possible. Standard
> names are defined in the DT spec (additions welcome).

I have suggested power-monitor name for this case. Pull request #15 for
that.

Thanks,
Michal
