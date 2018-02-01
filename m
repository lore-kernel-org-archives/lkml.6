Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbeBARds (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:33:48 -0500
Received: from mail-dm3nam03on0047.outbound.protection.outlook.com ([104.47.41.47]:13505
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752700AbeBARdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:33:42 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 1/7] arm64: zynqmp: Add support for Xilinx zcu100-revC
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
 <7dd5614c878adb30e38caf4002921c0ca995329c.1516366474.git.michal.simek@xilinx.com>
 <CAL_JsqKdEdyQP8maUmM39fvsAUcrvf6=_g21aRiaXqyv-ZogBw@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <57604f7c-8f0a-13a9-e03a-75b0441bdb98@xilinx.com>
Date: Thu, 1 Feb 2018 18:33:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKdEdyQP8maUmM39fvsAUcrvf6=_g21aRiaXqyv-ZogBw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(39380400002)(2980300002)(438002)(189003)(199004)(305945005)(31696002)(5660300001)(58126008)(36756003)(63266004)(31686004)(47776003)(86362001)(575784001)(2486003)(110136005)(316002)(59450400001)(53546011)(76176011)(6666003)(2950100002)(6246003)(106466001)(23676004)(65826007)(77096007)(2906002)(229853002)(478600001)(26005)(106002)(65806001)(7416002)(65956001)(9786002)(83506002)(64126003)(81156014)(81166006)(336011)(36386004)(8676002)(8936002)(4326008)(54906003)(50466002)(230700001)(356003)(186003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB3378;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT050;1:tROX0D24Eu74zr1iM7oZpiDz/jD8y8wGWVgUnUvpABLaC92IWaEu6wiQRRVwG52vv+viocMbYSW4s62acBhn1ONBYH7Igjun+Emn8N7bxOXnSmjeRYua9+3cOkeNjMZm
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 340ca089-1069-4441-84f2-08d56999ed1c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:BN6PR02MB3378;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3378;3:OVk6YLwzQsyQmWSxuS1CDjXUu4dgXTC7EtiZehgEqAFT7uD9IJmDUhVH2SijmKPLdm/hvBnu+zp6oaxX3Oqj6MpkDJGrQFnFL0z0pdYgOLGKGWBlb//LvWVoHTr+HPZspZMgupiOhCglmX9lUNpBHQ2tVyqQQa6MX/siwX8TkihC/Tt132NeYTARimrJlzj71JxLczHCSApPe8BiILWCRC5Jx/IL2yiU20MnldxvHvaRRJ5V+j+JWpDJThTMKwvAE9/TpwcJtAv0T+XqsIGrxe2rbcHALsZ/jW0Ejz9Fr2DkelX+MjP0dC0PTt7H/PRfu10c5K2/fzXue0I4JgyR58pRXIxI+tXEfzDQusXf9dk=;25:xY4Xp+fZFOR1UqBdpJDzAx6LTE0dEySwypYFoUCkqDWRoVimyZ3GuMXHUZ9oCvTaRyNR78gR+eTbWXSYX5f3Ncgn8egZKRIaGlIqugwfxjEw201SS+HM+Rc8W1eeJntOWyLCVbyFFtv+JPkQpWDVk3/QwtrK2ty5wsCG+uDw6FbGsOwqVEqIcE5Uk9b5hFnLGFVqa80AciilLBau0p3kbMFB1BiWKrT3oS81RqBsxUZVa9+s3t1ocCEsO3KbagmLaUdRfBpHb0lkxfu0jDlwYsYRVPZHbA2sqeV8mlkar2zMRl9Z2PTZccs6Zki5Y8/142uKH0+equA+3FoeuwL7BA==
X-MS-TrafficTypeDiagnostic: BN6PR02MB3378:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3378;31:NThDG1sl+FqRc1fDY8G1+Kwxv7fireCOa7vss3QwUN10EMeLDMs0zf+3cFvtDGI/e2RBgBAMFCnIsmWQ8Crj47Cs0/OU2QrjKfUCUJNYXu2Taw+yiPvHX+TFORvgWG1LAFl7yeHhuImgN2a5Hh0H/7Y73j00Z9K6/6Rbiws3WR+9FHnxDc2/AaWvZEiYOM0w9ggIHbBbg6Iqg3L4hWdJja+eeaYMnZrFNTj+r7D9mg8=;20:2SnLjorpRm8peQkI6fEuFy5vba5Vkgx36857k9j2PEFLGTH/Z/1FTPV4ZCq6XZWySjXP8ORypXb7N6ee1CVWlD/dLAGn/30t9WfOmnAHmKhzFGmVyqyQCPmiGrtenJE4I/8zGO3MF4nmmTv45SW1QUCAVQkf6fIpmN/K/KjkExEpeqKCOsfESZQJEQRXQBtL2rSOSj6J30dlkZTDNXIC6FEK1Wc9tavP8OJFae7XfN/BLjwu2H0PbIJp9jjXn6wO9FKHSNZxwL3gtiirk/AT3KGTh1A+G5ryCdI29pMCXqoP0CwI+WkA2CzYyYohCUAAwgK/OiBZ5vqcIN7iqh8GDEaqMlmjSOssmsw3PmK7XrEVWjoFBz7yhkFUkR5MJuiFFZ+avHEb94EHJp5X21HC7TNCfl2pM3oe+IjhT+ELxYRNpdZP721kmhOXCP+pRpcGiQKzuWK5B1ZXrPooOjHF8W6NVCqsdSH4rD+N2Bsj9gTVFDMFt3AXc5lbnQvHQlo1
X-Microsoft-Antispam-PRVS: <BN6PR02MB3378B951A2CA0A84070CA217E2FA0@BN6PR02MB3378.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231101)(2400082)(944501161)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR02MB3378;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB3378;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3378;4:8Mw7jBovkclTEml8xi/Y7yFxsgm8FL4D+GCOjdujWy4o1U2ZFBs+8FJ/hl2z5kTINj1vMJswou0aQsOeaNs5hm6BuMln6gu9nKw7fd3nzldMk4a64mHjRQmFi9N6Weh8w4gr9zItFaX2IpdkKEF/csgD+1iS302JlRpbXzzy3jU9iPIhV5iwgowBJCAvKOeTeNVskPOKRI/ImZ2lRWrw5vokWRCHBDmIBCyJvBnLRC91DGlZZZ1tTAJlMC2GD8a/XMxawF/I+YYBAdfvhAXA3Ll4lxva55UqVeprUiwrrj2JdEMsX3PhPkkTmasdpTwM
X-Forefront-PRVS: 0570F1F193
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAyTUIzMzc4OzIzOjZHSW9pcVA4dnFkbzRNSDhQY3B6aDFKcExi?=
 =?utf-8?B?dGE2Si9UQ0MvNVVDMktmUVBRRVVFWmJhUHptdGFMcG43Z0ZvMnIxWmtkWkFB?=
 =?utf-8?B?STV4QVNDazMwZG1QVXYyVDBscDJEdHR3WGpMUGQxejRrMnFpbVlmbDFLWWlv?=
 =?utf-8?B?bDBtQTE4TG5NdlZ2NFFMcTFyTkNZeHpmZUtjeDFCanZBSE9NQ1ZLZk53YkVm?=
 =?utf-8?B?eXEyRzdyV3IxWUI5OXB2Q2QwWnRhSlo5ZkRYSTNxVGdNTjdQNEhLZ2ZvRFFu?=
 =?utf-8?B?T1RzMG42MlBoZVRFSTRxZWtUU0FrYW90ak4vUE54ZDF5aHBrZWU5VkkzSzhN?=
 =?utf-8?B?emhDU1JFejB4UStjK0ZBWSt4RWJQL0taLzZZYU5aWEhhanRtMURGTG5XRDVG?=
 =?utf-8?B?ZTFuaklGd084b21JV1V2cTErQXprcDZ2OUc5eUtqUnplU0hDN0U4V3AzMHpX?=
 =?utf-8?B?QVBlQUJYdW1CU2p1UU5obnR3K2l4VTMzQWFYVDBOYUcyTEpId0VFSmp0RGg5?=
 =?utf-8?B?ckt0OEovR0k4MVNNemI3Nm9DMEJIRFhZTEsxWkVoQkZNTGs5Z1Y1VEFKLzBT?=
 =?utf-8?B?T1MwN3l0ekNYdk44WVV1OGlmTXNXWlRmZy8vVEd4RjlLM1FpMEZ3ekFFVGx5?=
 =?utf-8?B?c1JWaHRxRC92ckVzRHpuZmcwR0dSNDNXNWROKzJMcDdGNlN0TURzdEhEQ0Nv?=
 =?utf-8?B?cENaemk3YjlZdW5YVUY0UENYV3g0Y1NqYW5rNFYwM2VmU3VyRnJvcjNzRUt2?=
 =?utf-8?B?UjRmczlicjJxUDRQSjkzRk5hNHZGMnJiY0xoRklnS0FqR0tyc2g3alRoR1VY?=
 =?utf-8?B?V3pBbitnR1gyZUNvTEFsYlU5UHdJbDNhcitia3FKdVB1YkxqRFFGa3YwY2FR?=
 =?utf-8?B?RXRrY0F5UUFlckh2eHIzSzdtNVJRdVdoSEw5TEUyMFBrRlRnMGZ1VXNPREJL?=
 =?utf-8?B?clZsK3lzL3JZQ25Oa0RQZGdHODVyWHZqRUVOa1ZyZUJRNnhsMEtuZEpPWVps?=
 =?utf-8?B?ZE1IOGkyVGRDVUJBanZFZU1SaDRjeEJpRjJjUmVsWnEvRkNoazBpWGMyYkoy?=
 =?utf-8?B?ckNhM0c5aFpHcVZYRVQxcktQWVJlbFFyQUpTbEczOFErSEtCaklCT1EvMmR3?=
 =?utf-8?B?dzZ4aUp6WEdJcGs3WUU3cFNUSmw4Mk1Da1dkQ3NZZEh0UWpwUEFJSDdQTnZX?=
 =?utf-8?B?RlhDUGg0MGZDMGd5WEcvMFJzOWIvTno1SjFBUDczUDdJVVRZeDRHTE5LYmtP?=
 =?utf-8?B?WEhTeGdFUVV4R0lpRnhMM2V1SXh4SWlpOGg4QndpQzVXdW9xSWtXTW9NOTRZ?=
 =?utf-8?B?R0ZXVmxRN2ZYaExFd2tMNythdDB5eS9sOUhIT1ZjWDhUSndDMGQ0S3FtZHJP?=
 =?utf-8?B?NmU0S0dCYkwzMzZXdEFEY1MzOFJyWTNVRDBFVmdON2RxaFNjVzJwRkdZQkov?=
 =?utf-8?B?UFkzaTlJbERCbkVQQ1g3ZDF0NXllQndIVnMrckNxWXBvbC9lNXFUZWU3NlFT?=
 =?utf-8?B?KzVzVGhtaWZwK05xREhUSC9tZ0tSamhEdmc3WVVpcjBjRHdrNU5YYS9IMStT?=
 =?utf-8?B?OFlOQkNRelB2a293c0Zpb0J2aS9lbmM4bC9NM3k0VUEwK1ZZOE14VHNYV1hp?=
 =?utf-8?B?RHh0cElyZ1lCbXlXcFIvbHU5eHZvK1BEOE11by9Fd1c1SHNQb3JxK0hxRndC?=
 =?utf-8?B?WmQvTXhHd3FWNVZxZ3VHTzUxR0dBY3dxTGFIYTZkZUVJbGFXWWo0UUR5ckQ2?=
 =?utf-8?B?MjJyM2NuNWRCRFd6RVRaQT09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3378;6:CxxlP5iEPBZtBXK4sVALB+fNQ4GLcGIZjmoM5ZSUXDkJ3gr1CAdcqmk3ztwR3Qo4xHvcuJgCHA9zDjW/5XhkqqNhH98KXILkLZtxqewJfpDy5hFzG1jkZLULfMdUFynqAu3HtzPmTljzSpDzivfrcAELLwDV8OFl55K9tD4vAKAuCVvwhwtJSM1MszLcrjNjCfOSbuiY3T9V95bo7U6LaOsGJ3hR++ES6PoFiN8plpj09Te8mtL82ZplCBEevrEBNc1wdBMRzqhI/9x959SH7zQLHi2I9q4nuA57uqodXhxfWnXWmU7Y0DvqPUxSXon+5n4k4IcD7gt/eT3okJY6qtCz2+6G3J8tju9zs6PYWMI=;5:YWtcLvke/xdTrRWx2GVmXTzXrfFXEdaIpr4Nj6QGyyLuJNeUWYHPNBY+RY062MwyH6PbB8+xRKiJS4m+HVLdeRTcPGpy+1hrBy9yriCpXoBrgv0uJqS7qWkrwpIK+YqAImy6SkNgLN+m0lWxavJfuHfTkdVBYsmGI2IpZLdghi0=;24:El+mFhwwKEQz4umqmJstCbljZPanWQH/wkSphA9QD/GALSUSuBBGB4hsiios3UqqLZFDESQaz4iv1JIgZqMFMyj3n3f2iVjVfboKYsGrJ7k=;7:KR5wjWkzzvsIlVrqPSeRW5EkVQXT4EBC+HumiTij5YkjDxPgplHGace3FDoGmUs+L551+daO+ybCAovKtuWBGXkc7Tw9ZMGu9mItbXcew4bskBvRvivEKtG02qSuwpu1K71x0JjLGUR/gM2BS6SYmrKgXOy3No76bCxIPwpnhxVnCATiK6eV0nAjJsdgZ8J73ejr3k9dE6iW1nyV9YjzRujmiKR82SNukeaal1bTwL5zgpOOaxPmUlLdmTbihT/9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 17:33:36.3649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340ca089-1069-4441-84f2-08d56999ed1c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3378
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.2.2018 17:41, Rob Herring wrote:
> On Fri, Jan 19, 2018 at 6:55 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> This board has 2GB of memory, i2c, sd, wifi sdio, spis, uarts, display
>> port and usbs.
>> Board is using fixed clocks because clock driver hasn't been merged yet.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  arch/arm64/boot/dts/xilinx/Makefile               |   1 +
>>  arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi        | 213 ++++++++++++++++
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 298 ++++++++++++++++++++++
>>  3 files changed, 512 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
>> index eba179b23b17..7266a6a9c0cd 100644
>> --- a/arch/arm64/boot/dts/xilinx/Makefile
>> +++ b/arch/arm64/boot/dts/xilinx/Makefile
>> @@ -1,2 +1,3 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
>> new file mode 100644
>> index 000000000000..9c09baca7dd7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
>> @@ -0,0 +1,213 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Clock specification for Xilinx ZynqMP
>> + *
>> + * (C) Copyright 2015 - 2018, Xilinx, Inc.
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + */
>> +
>> +/ {
>> +       clk100: clk100 {
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <100000000>;
>> +       };
>> +
>> +       clk125: clk125 {
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <125000000>;
>> +       };
>> +
>> +       clk200: clk200 {
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <200000000>;
>> +       };
>> +
>> +       clk250: clk250 {
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <250000000>;
>> +       };
>> +
>> +       clk300: clk300 {
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <300000000>;
>> +       };
>> +
>> +       clk600: clk600 {
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <600000000>;
>> +       };
>> +
>> +       dp_aclk: clock0 {
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <100000000>;
>> +               clock-accuracy = <100>;
>> +       };
>> +
>> +       dp_aud_clk: clock1 {
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <24576000>;
>> +               clock-accuracy = <100>;
>> +       };
>> +
>> +       dpdma_clk: dpdma_clk {
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0x0>;
>> +               clock-frequency = <533000000>;
>> +       };
>> +
>> +       drm_clock: drm_clock {
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0x0>;
>> +               clock-frequency = <262750000>;
>> +               clock-accuracy = <0x64>;
>> +       };
>> +};
>> +
>> +&can0 {
>> +       clocks = <&clk100 &clk100>;
>> +};
>> +
>> +&can1 {
>> +       clocks = <&clk100 &clk100>;
>> +};
>> +
>> +&fpd_dma_chan1 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&fpd_dma_chan2 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&fpd_dma_chan3 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&fpd_dma_chan4 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&fpd_dma_chan5 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&fpd_dma_chan6 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&fpd_dma_chan7 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&fpd_dma_chan8 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&lpd_dma_chan1 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&lpd_dma_chan2 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&lpd_dma_chan3 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&lpd_dma_chan4 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&lpd_dma_chan5 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&lpd_dma_chan6 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&lpd_dma_chan7 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&lpd_dma_chan8 {
>> +       clocks = <&clk600>, <&clk100>;
>> +};
>> +
>> +&gem0 {
>> +       clocks = <&clk125>, <&clk125>, <&clk125>;
>> +};
>> +
>> +&gem1 {
>> +       clocks = <&clk125>, <&clk125>, <&clk125>;
>> +};
>> +
>> +&gem2 {
>> +       clocks = <&clk125>, <&clk125>, <&clk125>;
>> +};
>> +
>> +&gem3 {
>> +       clocks = <&clk125>, <&clk125>, <&clk125>;
>> +};
>> +
>> +&gpio {
>> +       clocks = <&clk100>;
>> +};
>> +
>> +&i2c0 {
>> +       clocks = <&clk100>;
>> +};
>> +
>> +&i2c1 {
>> +       clocks = <&clk100>;
>> +};
>> +
>> +&sata {
>> +       clocks = <&clk250>;
>> +};
>> +
>> +&sdhci0 {
>> +       clocks = <&clk200 &clk200>;
>> +};
>> +
>> +&sdhci1 {
>> +       clocks = <&clk200 &clk200>;
>> +};
>> +
>> +&spi0 {
>> +       clocks = <&clk200 &clk200>;
>> +};
>> +
>> +&spi1 {
>> +       clocks = <&clk200 &clk200>;
>> +};
>> +
>> +&uart0 {
>> +       clocks = <&clk100 &clk100>;
>> +};
>> +
>> +&uart1 {
>> +       clocks = <&clk100 &clk100>;
>> +};
>> +
>> +&usb0 {
>> +       clocks = <&clk250>, <&clk250>;
>> +};
>> +
>> +&usb1 {
>> +       clocks = <&clk250>, <&clk250>;
>> +};
>> +
>> +&watchdog0 {
>> +       clocks = <&clk250>;
>> +};
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> new file mode 100644
>> index 000000000000..01f5f95806d3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> @@ -0,0 +1,298 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * dts file for Xilinx ZynqMP ZCU100 revC
>> + *
>> + * (C) Copyright 2016 - 2018, Xilinx, Inc.
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + * Nathalie Chan King Choy <nathalie@xilinx.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "zynqmp.dtsi"
>> +#include "zynqmp-clk.dtsi"
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +       model = "ZynqMP ZCU100 RevC";
>> +       compatible = "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100", "xlnx,zynqmp";
> 
> Documented?
> 
>> +
>> +       aliases {
>> +               gpio0 = &gpio;
> 
> Drop this.
> 
>> +               i2c0 = &i2c1;
>> +               rtc0 = &rtc;
> 
> Is there more than one?

In programmable logic logic there can be plenty of them.

> 
>> +               serial0 = &uart1;
>> +               serial1 = &uart0;
>> +               serial2 = &dcc;
>> +               spi0 = &spi0;
>> +               spi1 = &spi1;
> 
>> +               usb0 = &usb0;
>> +               usb1 = &usb1;
> 
> Drop these.
> 
>> +               mmc0 = &sdhci0;
>> +               mmc1 = &sdhci1;
>> +       };
>> +
>> +       chosen {
>> +               bootargs = "earlycon";
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +
>> +       memory@0 {
>> +               device_type = "memory";
>> +               reg = <0x0 0x0 0x0 0x80000000>;
>> +       };
>> +
>> +       gpio-keys {
>> +               compatible = "gpio-keys";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               autorepeat;
>> +               sw4 {
>> +                       label = "sw4";
>> +                       gpios = <&gpio 23 GPIO_ACTIVE_LOW>;
>> +                       linux,code = <KEY_POWER>;
>> +                       gpio-key,wakeup;
>> +                       autorepeat;
>> +               };
>> +       };
>> +
>> +       leds {
>> +               compatible = "gpio-leds";
>> +               ds2 {
>> +                       label = "ds2";
>> +                       gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger = "heartbeat";
>> +               };
>> +
>> +               ds3 {
>> +                       label = "ds3";
>> +                       gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger = "phy0tx"; /* WLAN tx */
>> +                       default-state = "off";
>> +               };
>> +
>> +               ds4 {
>> +                       label = "ds4";
>> +                       gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger = "phy0rx"; /* WLAN rx */
>> +                       default-state = "off";
>> +               };
>> +
>> +               ds5 {
>> +                       label = "ds5";
>> +                       gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
>> +                       linux,default-trigger = "bluetooth-power";
>> +               };
>> +
>> +               vbus_det { /* U5 USB5744 VBUS detection via MIO25 */
>> +                       label = "vbus_det";
>> +                       gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
>> +                       default-state = "on";
>> +               };
>> +
>> +               bt_power {
>> +                       label = "bt_power";
>> +                       gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
>> +                       default-state = "on";
>> +               };
>> +       };
>> +
>> +       wmmcsdio_fixed: fixedregulator-mmcsdio {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "wmmcsdio_fixed";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               regulator-always-on;
>> +               regulator-boot-on;
>> +       };
>> +
>> +       sdio_pwrseq: sdio_pwrseq {
>> +               compatible = "mmc-pwrseq-simple";
>> +               reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
>> +       };
>> +};
>> +
>> +&dcc {
>> +       status = "okay";
>> +};
>> +
>> +&gpio {
>> +       status = "okay";
>> +       gpio-line-names = "UART1_TX", "UART1_RX", "UART0_RX", "UART0_TX", "I2C1_SCL",
>> +                         "I2C1_SDA", "SPI1_SCLK", "WLAN_EN", "BT_EN", "SPI1_CS",
>> +                         "SPI1_MISO", "SPI1_MOSI", "I2C_MUX_RESET", "SD0_DAT0", "SD0_DAT1",
>> +                         "SD0_DAT2", "SD0_DAT3", "PS_LED3", "PS_LED2", "PS_LED1",
>> +                         "PS_LED0", "SD0_CMD", "SD0_CLK", "GPIO_PB", "SD0_DETECT",
>> +                         "VBUS_DET", "POWER_INT", "DP_AUX", "DP_HPD", "DP_OE",
>> +                         "DP_AUX_IN", "INA226_ALERT", "PS_FP_PWR_EN", "PL_PWR_EN", "POWER_KILL",
>> +                         "", "GPIO-A", "GPIO-B", "SPI0_SCLK", "GPIO-C",
>> +                         "GPIO-D", "SPI0_CS", "SPI0_MISO", "SPI_MOSI", "GPIO-E",
>> +                         "GPIO-F", "SD1_D0", "SD1_D1", "SD1_D2", "SD1_D3",
>> +                         "SD1_CMD", "SD1_CLK", "USB0_CLK", "USB0_DIR", "USB0_DATA2",
>> +                         "USB0_NXT", "USB0_DATA0", "USB0_DATA1", "USB0_STP", "USB0_DATA3",
>> +                         "USB0_DATA4", "USB0_DATA5", "USB0_DATA6", "USB0_DATA7", "USB1_CLK",
>> +                         "USB1_DIR", "USB1_DATA2", "USB1_NXT", "USB1_DATA0", "USB1_DATA1",
>> +                         "USB1_STP", "USB1_DATA3", "USB1_DATA4", "USB1_DATA5", "USB1_DATA6",
>> +                         "USB_DATA7", "WLAN_IRQ", "PMIC_IRQ", /* MIO end and EMIO start */
>> +                         "", "",
>> +                         "", "", "", "", "", "", "", "", "", "",
>> +                         "", "", "", "", "", "", "", "", "", "",
>> +                         "", "", "", "", "", "", "", "", "", "",
>> +                         "", "", "", "", "", "", "", "", "", "",
>> +                         "", "", "", "", "", "", "", "", "", "",
>> +                         "", "", "", "", "", "", "", "", "", "",
>> +                         "", "", "", "", "", "", "", "", "", "",
>> +                         "", "", "", "", "", "", "", "", "", "",
>> +                         "", "", "", "", "", "", "", "", "", "",
>> +                         "", "", "", "";
>> +};
>> +
>> +&i2c1 {
>> +       status = "okay";
>> +       clock-frequency = <100000>;
>> +       i2cswitch@75 { /* u11 */
> 
> i2c-mux@75
> 
>> +               compatible = "nxp,pca9548";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               reg = <0x75>;
>> +               i2csw_0: i2c@0 { /* i2c mw 75 0 1 */
> 
> Linux commands for comments aren't relevant to dts files.

I was removing this from others and forget this one.
Just a note: It is u-boot command.

> 
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       reg = <0>;
>> +                       /*
>> +                        * LSEXP_I2C0
> 
> Is this a 96boards design? If so, using "label" and with defined names
> is somewhat standard for defining low speed connector ports (and for
> LEDs). That should also remove any need for using aliases for I2C and
> SPI. Look at hikey or db410c.

i2c, spi is easy
label = "HS-I2C2";

leds are also fine and fixed.

serial labeling depends on configuration. It means serial0 can be
LS-UART0 or 1 or PL based uart can be connected there.

Thanks,
Michal
