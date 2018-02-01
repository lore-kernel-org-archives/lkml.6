Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeBAR0n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:26:43 -0500
Received: from mail-sn1nam02on0074.outbound.protection.outlook.com ([104.47.36.74]:29696
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752653AbeBAR0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:26:39 -0500
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
Message-ID: <8136bf01-9571-2dc2-dcb1-d05b078772a9@xilinx.com>
Date: Thu, 1 Feb 2018 18:26:19 +0100
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
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(305945005)(36756003)(31686004)(4326008)(47776003)(110136005)(54906003)(65806001)(106466001)(65956001)(230700001)(106002)(83506002)(229853002)(575784001)(86362001)(2906002)(6246003)(36386004)(31696002)(50466002)(77096007)(8676002)(336011)(7416002)(316002)(76176011)(23676004)(59450400001)(2486003)(58126008)(53546011)(478600001)(5660300001)(63266004)(2950100002)(8936002)(6666003)(356003)(26005)(64126003)(81156014)(186003)(9786002)(81166006)(65826007)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR02MB1340;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT004;1:i580fFLJxhLjglg3oqFN7axlVpU+/manB/dS4bDT1JKMg2/5t6IfVqrr6IjoGoOsSHK0j0xafJ7csxoI0vhuxudViZCayNyvcmOsBiaCDOzJGWG3PNmo2md6Ektr2tmv
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b244a1b9-980c-4e4b-67b3-08d56998ee08
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:DM2PR02MB1340;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1340;3:TxTG6BHlnHU4rCQslQuwB55L5PkBDsED/JqJ7OaGHXRxAX0/uSQu2WXmkFHlxbMXQdU1d0sPeTnGOtxBsz9JrUO099IuLlqhla6ZSuTD+GzpkPVxdrAEm3kdzB+7P9dPzFNCSsQ5pVF0UfDiUVN8vz1uzJyISs61iGSQn7cKMzR+J6GpziTuFitNnPGs0jvntbcMwyDWBn0PsQgSaDysxlNuTkIyPX32mmN3d4nzNaqo3whKyx6lmbvCVFjm7t1ta/liJzB8uv5WkS9AQ+s8TB3uLBO+lpspQqCDL+rCUiRancx+PxZgFj+VhkbR/Olf+ymwmD6zaq0/jH22IhTkm3Vk7XaugCoJ9uZJMOnd0aA=;25:KV8sekvBL4xSnC8rizdu8t82aSusKiQQVIBUsKv+zYabjpWeTfkqoRCVA/4S4iLMgS37UTAWrBDW0C1mkm3lhY7p4AnrsaR0650xIwvi2kwsWY+mU83SaHIBV7d6bvfP3D9xIaTpi4VmMY1OS0AO3bLp4bYL/wrEbsZpyxzn+/zX1dXIn5SC+jFj/yIN7pz9gGdjaSn8Ef2AJ5qIMx6MLPPsrA+Q6UwexK90vQbkSV1gl+zMeVShaTqmgYfNC9H0v+TBklB8b4fa6SZv/PHdDSCugdQANgoqhPQ0SYNRLjuFfk5eA1m9ZA0tmtr0ZdRXa0MDZWb2Iq2dfgwPx6g2dw==
X-MS-TrafficTypeDiagnostic: DM2PR02MB1340:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1340;31:pNQyn8UzJUOeJJSMGUzvSkxSE/ONDAyoack3E6fcr6sOIOTPDY9GGxvv1/XeeuRfVjcv06nHakbN/DJdO0mVaMLhGiDl7NtckGfCoHOMUilj4Aw80dCe9t2Rupw+4Lm7F+9AdBuYW6/MKkn7uGViUkhl9dgwGpyzn6FZbcBtvzgy6vE55v11WUj4SSPtaMKb7xqUCOdR/vNkpgGbpnSWWnt6y1wnrdpp6JIrG4oBg5k=;20:IerF8ZktS8N4VFzWE9w+FTWLXy+sdMe96MIKeXglBW5vcsGvip+dn+oroVpEO8R+6rxNjj95ZglL7WBFGxzBCFZe9RYEgIX2AfFTAqEjGSfGmFehDkkLDN6nygnBlZmMomVW7AzJcNPlrTYXcrWQMWKsB8WGAjOrdAUhT4ompFodN8cmi6/C8aVEy3lz0NMDdWYTxpdAu2CRYXT0aWWolKQc6kD8T4dydJuhpxvLvuykO1NSrvutrd9/bU5yHZfPDhOjPoCq7o/aa5Zvpek1XmYLLZLm/auxTkDMlpUl7001RBteEi4sU/qVLpoj1Qs9w/PmIqRZIV7CcF5Du18WkSNL91NqQ4Wbk4PCwRtgHjJ2/nB7S9ujR271hrkWdClAK7Qk67ViKYmMEwRUEtrIpHJ7ekCLdtoFTyvjlTsxJFRShtsr6f2N+v7SHwEMOJe9jY8QMB40e022hsq5qQ/Fny1Gt4YzI5QdsTEFywh1jKCgw792b41BVJR2ylw+0b+C
X-Microsoft-Antispam-PRVS: <DM2PR02MB1340F0E446F1151FC1B2D9D3E2FA0@DM2PR02MB1340.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231101)(2400082)(944501161)(3002001)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR02MB1340;BCL:0;PCL:0;RULEID:;SRVR:DM2PR02MB1340;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1340;4:iezZYGD7of/J9AxTfNh1fePZXfkRS0oAUBYbkiVKfgN1NZB09sSCVW1Z2bYQcPVENv1PJ7Ei8xgoOo+wW0il8uJuyDm4Kx/OTpMipHj/afHDQkeZ6QmI/nxreYV8ByDp3xVivyIEkGmrth6OLSgisgKuj/dLrtM0o9THbqLJLPjhSK/+D81hdVotYrJSFwYWRykYHTWTMqBma9kKrPYEJBayQDk6u2fSi0Msb35vSeAgcbjRMvFCT72ordXb2Nop576vy2H59xRetPftXNWQtprVDYceyX/J3EV9DrYQRp5Jn8A+dT02RueKCyHde8nR
X-Forefront-PRVS: 0570F1F193
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjAyTUIxMzQwOzIzOk43K2NYcEY3MEgydlViNUlYdHFJWjNiWnNo?=
 =?utf-8?B?Um82ZFk1RTJkNjlCSi8rZHZ2UG9KejRKZ2FyS0M4c3FsTkUvYno0bloyM09p?=
 =?utf-8?B?SytNNlBOOG1YY2lCNVgxcm94ZzhrOGphMjN5Z2V5aEp4VEppWE9MSk5heXRR?=
 =?utf-8?B?aWU0aEJqQlAxYnFMRmE3UjJBaStPejhDUmkwWXMrN1NIcEplTXlQUFZZUEUv?=
 =?utf-8?B?VTd5eDVCN2N6UDFWMy9ReTZhYVZWcFptdHVwcUJVb1VBKzM2UHE1NHNhQXQ4?=
 =?utf-8?B?L0ZCYk9tMU1tVFRpb0RaV0VIclFlU21NU2VuaE5qL3cxWkxpblc1RWZZbmJw?=
 =?utf-8?B?TGk0SDdTbGFKZ2F6eWExV0cvcklGL0VCOHNZUGE3czUwRy9DR2t5Yk9vdGlC?=
 =?utf-8?B?dGd4U2p1N1lYUlRVTHBVV1JaeldFR0xVQStxNlRSREc2WkxkNUpNQ081bkNl?=
 =?utf-8?B?VHcrY0pJb2txNGN3NUZsYU8zeGVpeGYxb2lWd2l3NE13L1RHTXZaMmhqNFJh?=
 =?utf-8?B?QVp4TlFoYjdRN0g3QS9RTDUrSmduamJ6L1ZWV3ltMGRlQWxDYkZCak40c2Fy?=
 =?utf-8?B?d2tGRzN2OVYycVU5THpvM1M4MXhyT1hubkY4aTlscVFvNHdpdzV0UUNzNUI5?=
 =?utf-8?B?YmtSb0o3VXNaY1RWZ1ZjZmRvQkpVY3FYVXVIbm5qejFnY0I3WXEzVkF6YXM3?=
 =?utf-8?B?WWJFUk9KcnNlQmpoTjY0KzVyc0lZT0xXcVplRldESDIxYlVvN3ZZektjNktw?=
 =?utf-8?B?K3FWZ0dXdWM3RUtEa3hkQUVlZlZCd0RMeXljM3ExRnJzRjlDa0k0MCtXaHU3?=
 =?utf-8?B?L05remFxM09veUNjRmxxNjY2OGRBL1lzajdBcEJPdTlCOHhSdmlDb2liUDNv?=
 =?utf-8?B?cVVCNDdtRklhT3kvaFAwbG40NDR2OW5ZR3hBOE1ycDl1Ukxpdis2Q2RUcFkz?=
 =?utf-8?B?ZTMyK2RkTTA5bHlmTGZZdDErdk9SK2RZMTVtR1FRMnBYYTFmcjgxRFFDRWRl?=
 =?utf-8?B?NjJ6SXZKTUxDcEpVN1lzVWszNUhoZTI0K25qQ2VnSUx2eXExYXJ6MXpNSmlq?=
 =?utf-8?B?S29MbjhvcG4wVDcyVTdGdmZ5a05wUDVNUFo5SDUxdTFlUmwrUVFSYW9aUXph?=
 =?utf-8?B?SkZOc0prTU4rY1piTnpBL25KbHRPdVQxVFlGYkhnQkNoN2pVbkdiZjFHMHpt?=
 =?utf-8?B?aVpSZTlheUUxT3UvbVdDeGwxS3FlemN0cGhqcUV1eEY2RHdtUndPd2FON1Rx?=
 =?utf-8?B?aEFiYlN4L1BVWWNGd0xrTkx6UUdQejZzd0tsNzltTVMwNTZSd1VSQ2lrUGRS?=
 =?utf-8?B?UTVTd3NLaEpuNGhvMU9HcmxLak1TbDdxTTZ0aUV2ZlEwc1lHZFdRckIwNDRq?=
 =?utf-8?B?L25iNWttcUtSbGMyU2x3TXY3aERtSDhXTXJ6OU4vWDhEU1RYTlZXek1Cd05M?=
 =?utf-8?B?VUZvNDd5WFFOMmNnZkZCQnIxbmFRUXpsYkF5eTZDbFhIS0s3UGJ3Vys3UHJt?=
 =?utf-8?B?SVFjWk1JZy9BMUNUblJZQzhpdW1jVVI4ZHhMVzYxQkpEaWlHQlA1ZExPd3o5?=
 =?utf-8?B?aDRlK3BPbmVpNUtDSEtjbXBsaG5Ya3dQYVVMWkZwTGthenc2bzJJdkp4Y2Ey?=
 =?utf-8?B?a2FTRmlGUFlhK0w2NlFrVE9sZSs1dUVmUE1sdW9semNDQUVVeDdYbk5iMWJj?=
 =?utf-8?B?WjNpZmR1Y2xLSkdzVkxoOUp1OUN4eFExVVptTWNoT3JZckM4aVQvVmFwMzhw?=
 =?utf-8?B?bkhsMEFPV2dlZVBEeldRUT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1340;6:qbbziq3Eu69ucdk87VllJNlEQxNntnYGtr4P7JYbfcZwwm030YkmEKnXpYhzzP+BmS5C4VnK6Oxz6Skm5X/lgeAXMx8ycbASXpDe1rAOdnTx3Atl/wpYNprfUm1dYElsp1BU2CfO7NuIhFo6mQvScbP4/Xfl5CuzrXc/p3KipPNnns3cy/OcsDQcZI9ss5L5mDzDJeumGvShxb+f6+9AjLmgz0jKcmBIrbAebbfLrhFCq6R1eCz9UhxclqYYYuiea+VqdEnKTunKZlYEP2kaMglqM52gGrcRRTre1wtXVX7P87RBoXW6IxcGM9oIsm/WxJOhOMDZ1veBZ/sM4LfM+6fH8YRkRI5FnKi6VByXS5Y=;5:P5jzHeQLGCftsqHT/+bcqCGg+V4FE/wMtdddArJP2dhYa7nK5XRqdGZL2ECVZrXQ7zSJ955xMUyYvL9v6aqVk5peRYV+QHt87wo74/+cP9Nv6OGyr/h2S8KH01pJGyPk7mu67bJy7U8VnddWj67LZw6ATCRE1EQEPgHBVf6fZEQ=;24:E8JfeIFQZvjNBZw1R3W0hhbyUQofNwk0YToEJzyiRtewLuREGgdJzKF0UrLls4mSZ3EsKSFA8TpC1ydHtZpYBBBx6qsJ0MlKPT2sPCm8wD4=;7:RCq+/Ld2+vkxCZbeV5DWs4pmP1waONP8BYcTBnDGDYkP3nNEFKEgpSpbWBNpGP0esBAXtPsaS+euKk+xlgaYg29UIIpA347xWbDu6F4OVoMf26rEU21GLOqKVTPHFYIKLWqZK0eVdXzPeWHUWVxuZP9OnOnUO0jP4TyXuheLJuFi+/MX9RWIZNZywh2jzb53fsefn6fFl2QucsrmYUlbsS2WMqjx8VGPdXrgb8FhYJSPLKKS1bu5NrYRRuszmsVx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 17:26:28.7423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b244a1b9-980c-4e4b-67b3-08d56998ee08
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB1340
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

What exactly should be documented? All compatible strings?  Or just
xlnx,zynqmp one?

Some user space libraries are checking this compatible strings and
changing behavior based on that. That's why I am putting there all of them.



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

ok.

> 
>> +               reg = <0x0 0x14>;
>> +       };
>> +
>> +       eth_mac: eth_mac@20 {
>> +               reg = <0x20 0x6>;
>> +       };
>> +
>> +       board_name: board_name@d0 {
>> +               reg = <0xd0 0x6>;
>> +       };
>> +
>> +       board_revision: board_revision@e0 {
>> +               reg = <0xe0 0x3>;
>> +       };
>> +};
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> new file mode 100644
>> index 000000000000..6a15aacf65ef
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> @@ -0,0 +1,556 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * dts file for Xilinx ZynqMP ZCU102 RevA
>> + *
>> + * (C) Copyright 2015 - 2018, Xilinx, Inc.
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "zynqmp.dtsi"
>> +#include "zynqmp-clk.dtsi"
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +       model = "ZynqMP ZCU102 RevA";
>> +       compatible = "xlnx,zynqmp-zcu102-revA", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
>> +
>> +       aliases {
>> +               ethernet0 = &gem3;
>> +               gpio0 = &gpio;
>> +               i2c0 = &i2c0;
>> +               i2c1 = &i2c1;
>> +               mmc0 = &sdhci1;
>> +               rtc0 = &rtc;
>> +               serial0 = &uart0;
>> +               serial1 = &uart1;
>> +               serial2 = &dcc;
>> +               usb0 = &usb0;
>> +       };
>> +
>> +       chosen {
>> +               bootargs = "earlycon";
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +
>> +       memory@0 {
>> +               device_type = "memory";
>> +               reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
>> +       };
>> +
>> +       gpio-keys {
>> +               compatible = "gpio-keys";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               autorepeat;
>> +               sw19 {
>> +                       label = "sw19";
>> +                       gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
>> +                       linux,code = <KEY_DOWN>;
>> +                       gpio-key,wakeup;
>> +                       autorepeat;
>> +               };
>> +       };
>> +
>> +       leds {
>> +               compatible = "gpio-leds";
>> +               heartbeat_led {
>> +                       label = "heartbeat";
>> +                       gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger = "heartbeat";
>> +               };
>> +       };
>> +};
>> +
>> +&can1 {
>> +       status = "okay";
>> +};
>> +
>> +&dcc {
>> +       status = "okay";
>> +};
>> +
>> +&fpd_dma_chan1 {
>> +       status = "okay";
>> +};
>> +
>> +&fpd_dma_chan2 {
>> +       status = "okay";
>> +};
>> +
>> +&fpd_dma_chan3 {
>> +       status = "okay";
>> +};
>> +
>> +&fpd_dma_chan4 {
>> +       status = "okay";
>> +};
>> +
>> +&fpd_dma_chan5 {
>> +       status = "okay";
>> +};
>> +
>> +&fpd_dma_chan6 {
>> +       status = "okay";
>> +};
>> +
>> +&fpd_dma_chan7 {
>> +       status = "okay";
>> +};
>> +
>> +&fpd_dma_chan8 {
>> +       status = "okay";
>> +};
>> +
>> +&gem3 {
>> +       status = "okay";
>> +       phy-handle = <&phy0>;
>> +       phy-mode = "rgmii-id";
>> +       phy0: phy@21 {
>> +               reg = <21>;
>> +               ti,rx-internal-delay = <0x8>;
>> +               ti,tx-internal-delay = <0xa>;
>> +               ti,fifo-depth = <0x1>;
>> +       };
>> +};
>> +
>> +&gpio {
>> +       status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +       status = "okay";
>> +       clock-frequency = <400000>;
>> +
>> +       tca6416_u97: gpio@20 {
>> +               /*
>> +                * Enable all GTs to out from U-Boot
>> +                * i2c mw 20 6 0  - setup IO to output
>> +                * i2c mw 20 2 ef - setup output values on pins 0-7
>> +                * i2c mw 20 3 ff - setup output values on pins 10-17
>> +                */
>> +               compatible = "ti,tca6416";
>> +               reg = <0x20>;
>> +               gpio-controller;
>> +               #gpio-cells = <2>;
>> +               /*
>> +                * IRQ not connected
>> +                * Lines:
>> +                * 0 - PS_GTR_LAN_SEL0
>> +                * 1 - PS_GTR_LAN_SEL1
>> +                * 2 - PS_GTR_LAN_SEL2
>> +                * 3 - PS_GTR_LAN_SEL3
>> +                * 4 - PCI_CLK_DIR_SEL
>> +                * 5 - IIC_MUX_RESET_B
>> +                * 6 - GEM3_EXP_RESET_B
>> +                * 7, 10 - 17 - not connected
>> +                */
>> +
>> +               gtr_sel0 {
>> +                       gpio-hog;
>> +                       gpios = <0 0>;
>> +                       output-low; /* PCIE = 0, DP = 1 */
>> +                       line-name = "sel0";
>> +               };
>> +               gtr_sel1 {
>> +                       gpio-hog;
>> +                       gpios = <1 0>;
>> +                       output-high; /* PCIE = 0, DP = 1 */
>> +                       line-name = "sel1";
>> +               };
>> +               gtr_sel2 {
>> +                       gpio-hog;
>> +                       gpios = <2 0>;
>> +                       output-high; /* PCIE = 0, USB0 = 1 */
>> +                       line-name = "sel2";
>> +               };
>> +               gtr_sel3 {
>> +                       gpio-hog;
>> +                       gpios = <3 0>;
>> +                       output-high; /* PCIE = 0, SATA = 1 */
>> +                       line-name = "sel3";
>> +               };
>> +       };
>> +
>> +       tca6416_u61: gpio@21 { /* enable it by i2c mw 21 6 0 */
>> +               compatible = "ti,tca6416";
>> +               reg = <0x21>;
>> +               gpio-controller;
>> +               #gpio-cells = <2>;
>> +               /*
>> +                * IRQ not connected
>> +                * Lines:
>> +                * 0 - VCCPSPLL_EN
>> +                * 1 - MGTRAVCC_EN
>> +                * 2 - MGTRAVTT_EN
>> +                * 3 - VCCPSDDRPLL_EN
>> +                * 4 - MIO26_PMU_INPUT_LS
>> +                * 5 - PL_PMBUS_ALERT
>> +                * 6 - PS_PMBUS_ALERT
>> +                * 7 - MAXIM_PMBUS_ALERT
>> +                * 10 - PL_DDR4_VTERM_EN
>> +                * 11 - PL_DDR4_VPP_2V5_EN
>> +                * 12 - PS_DIMM_VDDQ_TO_PSVCCO_ON
>> +                * 13 - PS_DIMM_SUSPEND_EN
>> +                * 14 - PS_DDR4_VTERM_EN
>> +                * 15 - PS_DDR4_VPP_2V5_EN
>> +                * 16 - 17 - not connected
>> +                */
>> +       };
>> +
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

I need to document also identification from schematics because without
it it won't be clear which one is which part on schematics and at the
end it will be just a mess.



> 
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x40>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@41 { /* u77 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x41>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@42 { /* u78 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x42>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@43 { /* u87 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x43>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@44 { /* u85 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x44>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@45 { /* u86 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x45>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@46 { /* u93 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x46>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@47 { /* u88 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x47>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@4a { /* u15 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x4a>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@4b { /* u92 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x4b>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +               };
>> +               i2c@1 { /* i2c mw 75 0 1 */
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       reg = <1>;
>> +                       /* PL_PMBUS */
>> +                       ina226@40 { /* u79 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x40>;
>> +                               shunt-resistor = <2000>;
>> +                       };
>> +                       ina226@41 { /* u81 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x41>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@42 { /* u80 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x42>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@43 { /* u84 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x43>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@44 { /* u16 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x44>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@45 { /* u65 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x45>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@46 { /* u74 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x46>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +                       ina226@47 { /* u75 */
>> +                               compatible = "ti,ina226";
>> +                               reg = <0x47>;
>> +                               shunt-resistor = <5000>;
>> +                       };
>> +               };
>> +               i2c@2 { /* i2c mw 75 0 1 */
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       reg = <2>;
>> +                       /* MAXIM_PMBUS - 00 */
>> +                       max15301@a { /* u46 */
>> +                               compatible = "maxim,max15301";
>> +                               reg = <0xa>;
>> +                       };
>> +                       max15303@b { /* u4 */
>> +                               compatible = "maxim,max15303";
>> +                               reg = <0xb>;
>> +                       };
>> +                       max15303@10 { /* u13 */
>> +                               compatible = "maxim,max15303";
>> +                               reg = <0x10>;
>> +                       };
>> +                       max15301@13 { /* u47 */
>> +                               compatible = "maxim,max15301";
>> +                               reg = <0x13>;
>> +                       };
>> +                       max15303@14 { /* u7 */
>> +                               compatible = "maxim,max15303";
>> +                               reg = <0x14>;
>> +                       };
>> +                       max15303@15 { /* u6 */
>> +                               compatible = "maxim,max15303";
>> +                               reg = <0x15>;
>> +                       };
>> +                       max15303@16 { /* u10 */
>> +                               compatible = "maxim,max15303";
>> +                               reg = <0x16>;
>> +                       };
>> +                       max15303@17 { /* u9 */
>> +                               compatible = "maxim,max15303";
>> +                               reg = <0x17>;
>> +                       };
>> +                       max15301@18 { /* u63 */
>> +                               compatible = "maxim,max15301";
>> +                               reg = <0x18>;
>> +                       };
>> +                       max15303@1a { /* u49 */
>> +                               compatible = "maxim,max15303";
>> +                               reg = <0x1a>;
>> +                       };
>> +                       max15303@1d { /* u18 */
>> +                               compatible = "maxim,max15303";
>> +                               reg = <0x1d>;
>> +                       };
>> +                       max15303@20 { /* u8 */
>> +                               compatible = "maxim,max15303";
>> +                               status = "disabled"; /* unreachable */
>> +                               reg = <0x20>;
>> +                       };
>> +
>> +                       max20751@72 { /* u95 */
>> +                               compatible = "maxim,max20751";
>> +                               reg = <0x72>;
>> +                       };
>> +                       max20751@73 { /* u96 */
>> +                               compatible = "maxim,max20751";
>> +                               reg = <0x73>;
>> +                       };
>> +               };
>> +               /* Bus 3 is not connected */
>> +       };
>> +};
>> +
>> +&i2c1 {
>> +       status = "okay";
>> +       clock-frequency = <400000>;
>> +
>> +       /* PL i2c via PCA9306 - u45 */
>> +       i2cswitch@74 { /* u34 */
>> +               compatible = "nxp,pca9548";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               reg = <0x74>;
>> +               i2c@0 { /* i2c mw 74 0 1 */
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       reg = <0>;
>> +                       /*
>> +                        * IIC_EEPROM 1kB memory which uses 256B blocks
>> +                        * where every block has different address.
>> +                        *    0 - 256B address 0x54
>> +                        * 256B - 512B address 0x55
>> +                        * 512B - 768B address 0x56
>> +                        * 768B - 1024B address 0x57
>> +                        */
>> +                       eeprom: eeprom@54 { /* u23 */
>> +                               compatible = "atmel,24c08";
>> +                               reg = <0x54>;
>> +                       };
>> +               };
>> +               i2c@1 { /* i2c mw 74 0 2 */
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       reg = <1>;
>> +                       si5341: clock-generator1@36 { /* SI5341 - u69 */
> 
> Drop the 1 on clock-generator1.

ok.

Thanks,
Michal
