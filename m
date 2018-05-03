Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbeECIPd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:15:33 -0400
Received: from mail-by2nam01on0078.outbound.protection.outlook.com ([104.47.34.78]:27040
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750999AbeECIP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:15:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH] clk: x86: Add ST oscout platform clock
To: Stephen Boyd <sboyd@kernel.org>
Cc: djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1525072055-17898-1-git-send-email-akshu.agrawal@amd.com>
 <152521188500.138124.10561048787941050422@swboyd.mtv.corp.google.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <b8fc236e-032b-7806-e44c-0bbe9faefc66@amd.com>
Date: Thu, 3 May 2018 13:45:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152521188500.138124.10561048787941050422@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: BM1PR0101CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::15) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2355;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;3:486Z/B9YsXApRtj3YU6ycMjpyuIcU7hqII5pZx/DyZhZWEqK9lippBBVkkCikQmOht90Tbo6vAHBdfWy4QZZqtkjc9QMsumrUNBtVfTKpgf0P0OzFxV0wpnPTjCOmcyhKsMFGbEWibU9y6puaSgZyUAwsmuqauANATQsBjzpCcPS0kdqWO3JlNZppJE9FrYzmJ7T/7twuNI897P8TVTcXZziwKw/pv4x7fNQ1Z6YpaIhLZKZ8VZ0ddvZ5AHJhHl0;25:hjEYNfI3jGkR3Y0uSCmexij+xsiVGTzkiBZK4uEOrJT73N4z4LIaun6LVUaBIMMky/E2NSHQvgtTuO4fa5f+MSAfY+ZH3afqv6q8aTMgb2uxFUGfEB8TxlbTEhyzgYh8x4ScZCnceL2hn+ORNCkFZd6iEzLl11wRT5TfauxQc4nzVKYn8s5T1FKC806rsTHqZT9sScYR6nuqD/U7bhuI4WJnyZtDTPofMlzc1YvCQuNvZ8rJTDZRCcmIfPTPfzYu87rcXzmX3TCIlsut8w88EWrsBTOk/9u0uYb+lLVBtNb+0fJCpQj90M45Bu4tixT/4hN6+96+weYIsarPfoocTg==;31:kzzlk5TYKXeWzsxWQvF0+4GQU+lgc04crgZ9ZftUIF6hfUh+LAO5rC2TM3xgc9AjJEBLeoqdRtK5cJHu+38eT+oRkUFDucORxw63Wj6g2O9N+2HmNcXc5zqGh78q+ft/REu24gE4Ejmhyft3ZjUhe0qcwrTxN2zoicbHMmwbnMYhYwTdKMtEnZ8AyPQUZYfz0R7wuK9//e2z2Pg0CucrFlYQ+H7hgohasIyrFK5GT3g=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;20:9qsj1qNLnG8Ux2aGqZT4GKGb4lwwmQ4dHp5CLwQm2MXcTd8zwJXWijJo0hHLgNR4+o2O8YsUxUGOK53Eb7cE3lEsRWPT83V/ffe0pd7csMyjzE6bDZA5Sdf8cBs48A/PohQSHwzpkAGZDJb+5KTl4ybbeuFOSzRCnIMdY2rKqwIjnLVXUyqu0KJGzL2nVe/OpzEj3ojYTzyYdKfuIf4V5rSbfpA4N3u4RVDoWN1p1aWeje1qJ/wgCvz33lwrjsnJZi93YTe+UY+3eCr/dbLaJARxattcIWZvEz0OeEfoopRMGNaxR8B0BgwdmgKyWCdYFul+oD/e+yBDrLT8lX67N4Ghy75jkY2TOmpM2SZ59vPK6iax1FixaT3A3z+Bfl726nYgEy649yXFJU5xPAqW86KHWUJ4tuOJh2B0agw5O/XmLQzEPj/xS9JX8RRjC0HpU5RCRW2gnrABBJbwEqLDgvLq0Yhk6YEBqdzUoOR95zzLUe79uFT69HWrdSKHTYyj;4:arNDFGkLIw52sb7jRcrTylD+0RxXFCdZ3Inn0QTDKYCOe99M13N0AFJ/bJYinAr2vP8W7VQApdWDJfFigUAoCg9E73UA8aoxOpfqisb8iCT53eKD9lh9YmmpwfB0yv6qiVp3sPlIPKfipG9FsdQQj4r2Ah90PhIm4MhNh9I7ZHQLWJfF1i3G4tGKZQZaU7M422K6za30CtGQ21bbKIpc0HYP8oT35KxlD/rwVYnBedwEoOBPLuCLr7kpzSqHgSLvRTwWTLe9JVG+FFG36LtXFw==
X-Microsoft-Antispam-PRVS: <BL0PR12MB23556E98D18AF8430FC23184F8870@BL0PR12MB2355.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR12MB2355;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2355;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(39860400002)(376002)(39380400002)(396003)(199004)(377424004)(189003)(47776003)(52116002)(16526019)(575784001)(5660300001)(31696002)(86362001)(50466002)(53936002)(2906002)(16576012)(6666003)(54906003)(25786009)(316002)(3260700006)(58126008)(68736007)(6486002)(6116002)(77096007)(186003)(64126003)(386003)(11346002)(305945005)(65826007)(4326008)(2616005)(26005)(486006)(229853002)(3846002)(6246003)(7736002)(956004)(476003)(6916009)(446003)(65806001)(31686004)(230700001)(36756003)(72206003)(59450400001)(8676002)(97736004)(23676004)(65956001)(53546011)(8936002)(2486003)(67846002)(81156014)(106356001)(66066001)(52146003)(478600001)(105586002)(81166006)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2355;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjEyTUIyMzU1OzIzOnRXbjZtclVnRW91cnNFUFN3OXFzZVJ0TmVy?=
 =?utf-8?B?ZFZsS0ZITnVZVWQxeUFFeWc4ako0cjZjVEs3UmlWOXE5WW5FYWozNWtCZndh?=
 =?utf-8?B?RVpoOTdiOWJjb2tDTk8xT2JBMFBCVHI3MktWcTFsOUZjSmVhcFVQTzd3Tkxy?=
 =?utf-8?B?UnV4V3l5d25ZY3VGeXlid2VmaTZKSWFTMjQ5dnhhUk5WN0pnNjh3STB1RkNZ?=
 =?utf-8?B?MzEwWU9wbHcyT09lU3MwYTU4bnBmcncwK09Ody9sanh6L0lmYzNseTBVWDhD?=
 =?utf-8?B?ZHdZOU4wNXFTeXFtN0hlb1YvKzlOVlRjT2tjSFJ4SnRQR3FPRVc4NXRZRFhq?=
 =?utf-8?B?djdLSG1LdW9mTXFzb0dmUlZpL2FJL1ZEMXVoNzhHY3VBM2FPZmRhd0hEY0E5?=
 =?utf-8?B?UFk2ZTRSYWFpeXMvc0c0cWxyWDlDMHB5anV3dFVlRTJhZEE4Q09SWFNFSk5I?=
 =?utf-8?B?SkVreWhNZ0RXNG4zbWo3b24rT0VjQ2hJM1VnbEF5RG1PWmR5K0dJUTZNZU5i?=
 =?utf-8?B?OWw4dmYwYk1yMFkvMHF4YmNaT2JPSDUxVkhGVzZvMnIva2trYVJzSDB2N3Vm?=
 =?utf-8?B?KzZkSmxFdENyMi96dGVyeFNyekt6US9LTzdqZSs3aGxnMi9SQURWTVRqNlRL?=
 =?utf-8?B?YnJZblo1ZjlYN2NCdVFCVVQ0RGhOSGs0NnRoK2RZcmJVbEpuRkxFVlNPNDkz?=
 =?utf-8?B?UUZmSDNMQlhDa1NSdzVTSlNwSEk3cHBlVTRTSXM4RFJvYVk1UTJ2a2VZeHBM?=
 =?utf-8?B?NitOSVJnbWFkMlRtL2pjK0ZBYUx2Nyt4M3NPanhmL2liYTcrMTRCV1E2cUs2?=
 =?utf-8?B?TUNnOGEzcUoxVEdJRS9ubFZsbEtnMXExK21uS2ZRdW1KZ0szRFBIZ3ZjNTJa?=
 =?utf-8?B?dUt5dU9RRkZpeklFc1hLQ2dnNXYyWFdMaCtSQzVGamNlODVPTzkxdjFxSmFG?=
 =?utf-8?B?RGk1b0dlNmNZZmdlODN0T0ZZWUExckpGbmVibGpPa21xQjRMYS85SnArRVA1?=
 =?utf-8?B?MkNTa3pqQkJvcVpCQS92R3BCWmIyeUY4WjBzRlRXQzEzcHA2Q0NEQ21CTFlE?=
 =?utf-8?B?WHFiV0d5QjdmcFVoLzdqbG0yMThtUmU2blVSc1VTRUZhUkVwZnZqVTFjTXpZ?=
 =?utf-8?B?aXVFWnRjeFpiVU5zVER1WXhCa2tDT2lrbmxjRlNGbkFZMXZrVjBjcHc1NTc5?=
 =?utf-8?B?cFhGaXhKcUdtS2xOT2E1Y081L1pqYUtHcmJhSzNmdlMzUFpxYlVSeXlRcm14?=
 =?utf-8?B?SkwzWHRQenJneGdwL1F0bHFwekNMb2RpK2JRd09Tb1FjcVptQWxZRkllN3lo?=
 =?utf-8?B?dWIxYXUySGljQlBoR1htY1hVREJ0cHl4OUd2VHgwVERRYlpKUmpVcTJTSmFX?=
 =?utf-8?B?SzBKU1dKNFRPelF0cG0vV3VnNUdrb2hyTjNYQytrbElTNVlTSUk1KzJKMktW?=
 =?utf-8?B?dmRZVTFlaGtwZHFDbGNuakoxSXE4d0RqMkN6UStad3dIdWhoYklEaVJIQ2Mr?=
 =?utf-8?B?dDJrMXRLbXhMWUJOQTRSdEJ2aDBmQ1hWQkJmTm8wQ0hXb0xRV2JpNm1UYWo5?=
 =?utf-8?B?OGl2eWVyRUt4Z3RreXVuVjVlSzZYZG1VUnVPc21lQmEwSXRiRTdnZjBDWHpO?=
 =?utf-8?B?NlRSOTFqNzdCZWZMQXhMeGJJUXZtSWVPVzIxaThrMHRKTEdaNjNselZtZ0VF?=
 =?utf-8?B?Ni8xQmIzM3NSUmFnR1JEVWg5NU5tU0ZWS1U1MEJzNmVrWjFsdmUzQkVTR1pO?=
 =?utf-8?B?Rmd2VHZnUnNkVXEyNUM1WXBqei8zYjBQbW0xQ0xjaWxUbkNVbGRrSnJlYVhS?=
 =?utf-8?B?ZFdmT0xZVUVSWUtaOWRXaktOeExUR1pSaWc0c29TTFNyTWlubXNMM1pTM2hD?=
 =?utf-8?B?WWJMRjIrQ0g0THQ1MzAvUEpMQXNHN09vRnlrWWlRZmNjdlUyVXY5citUWndh?=
 =?utf-8?B?a2NWcUpWUnJDT3FkcU5tRExmbzVVRmFadVhsQ2QvcDNwQUxCRGVLUVhvdGVV?=
 =?utf-8?B?L0EyTmp5UGY2aGdXNTBaMzRJUmpRUGNYdWtRVGtQWVlhVnhadVN0YzI5enhF?=
 =?utf-8?B?OTJXMVlBU0pRcXdqbnVKbWdHUTJyRVVNNmQ5SURpMFV1YUFtK2VsczgyaHpT?=
 =?utf-8?Q?8fjq3IShoooXco9vZRZeYk4=3D?=
X-Microsoft-Antispam-Message-Info: aJq8cFGuZRK/hFGFsk/O09dcpxm+DXtwmbxm/JQ0XaPLnaJwNwd1XhPxlgVPnzVYK6sEtNTJNhdJVhNWyXwlGXU0EyWwpBzOePAogpANteEuYACVJIz0OPb3Z4+8sgMGBteUtPeRefhxeMoeS1sbU0N1/WDZVO1Yt89YF9kcTEXe6hTdlsHjgc7C+sXuT/KE
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;6:1eq4AqXRusIwZ3KcC1bmx9rv/IZ/OLIgIs5wvGB5I6aKSdGfcxBywsEMWXXu5ZjIOPpsj3Hc9ITPFsoPjx+AZcJ1yDWCzL5lTCw8lVGkkP0KjLWRJURdR0sZAXlhC+4ZOf6+kQTz+e4Jy88sVAzsSnqPkYDVxcJI92Ms9zCsyqEqgXU0uzLNDQaJvFelTUYM/SSamb/+Q7Ffnk2/GnibseGGiV/asiB9TjN8ueTTYPo/6/ACsE+C3ukGeQjrsBFKirZaf0gPAwjy4zx8J3J2D0CXOwvwoRm2y12a9RS0xZpCMKQNHtMapBwbjOF6cpV67+YIxFk8ktg/d8sDvP2N6BXROccYsGnBg8kT25Q5eIUgGKNN7Mx6485IH1kuPfKLDZRxo1QGy3SY5ZA6Zu7psgAi56lO0yU8QopCzlh7cyxrbwIPG169254FrSxzO512vgrmH9jq6cQ+F1/NbImtow==;5:dbwi6bgA3cw4LCvuuD0SJBGhk6mlHBJBzTAmsvgVIohhiCyBLy06ZlEfGDZEl8UoF9R4mn9lQvQLwl/wV5wM/jVKUZ7r2naV4sDpxopnnlXk/aPoOBB8bfXLefTKkVI1YAChYKrawNhJjlea1ecd+Gi7MKLoi9f4GSP19W6zLKI=;24:I6i6W8HP56SHn/qjsOm3TrYRsptxHKxGrPCmwSUl7OYuVxIonmD0CZAeAbaF5FX39XWIWIz10ZG1LfSsVQIU4ZyUmLe3uNhM/VhN87+ciEc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;7:ZD94PAkYavnUdH2WhEUjpMrLFaZ7Nt3E0UlfJOV/1sZqCH2PxaDSTkRWR/C2QQFrCNGOb6Q3jeA1CujYgoqTPdUFjA6eGCEl1czJMfiMiMlQBOcQ49B/r2ztNVmDAt4yWd8vJMEILsjEmPGzXR94yMcD8BfSFcUaEMsV1apjUrgGt5Iz3xnwp70J1S59ZRy3HkmtU9CnGiMbseTm/tauh8Fg+lqcPLbRlskvyLmBkmD82oNpow0z8QOmb4jEi2O6;20:+JmamiUxOeu4BU2ora9gQB0Rk4kN8cDyWO04XlMKQX2byP5ya80UqLP6GVwTUWFbdFYROgHGJ18QcYyhInUxhUWGp+ibb4ZDSq7zqFd1SJdXTpsEDDe11oeMN+VU6fjc2aL7dWrA3LwO0TuCFyrYBSpcw+lgKBolMRYVS1a/1mJ0BsgEYpMKxjoq95cVPuP1qpK3bRiB7gV3mQLXU6HNwz0mCEkyaVHmDfD13ldVBgh8vyJtwstEzkeNIKbWfAdt
X-MS-Office365-Filtering-Correlation-Id: 904ed895-a1ef-4c33-d0d8-08d5b0ce05d6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 08:15:22.5664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 904ed895-a1ef-4c33-d0d8-08d5b0ce05d6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2018 3:28 AM, Stephen Boyd wrote:
> Quoting Akshu Agrawal (2018-04-30 00:06:53)
>> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
>> index 1367afb..f7ebae1 100644
>> --- a/drivers/clk/x86/Makefile
>> +++ b/drivers/clk/x86/Makefile
>> @@ -1,3 +1,4 @@
>>   clk-x86-lpss-objs              := clk-lpt.o
>>   obj-$(CONFIG_X86_INTEL_LPSS)   += clk-x86-lpss.o
>>   obj-$(CONFIG_PMC_ATOM)         += clk-pmc-atom.o
>> +obj-$(CONFIG_X86)              += clk-st.o
> 
> No desire to make a Kconfig for this driver so it isn't included all the
> time on x86 devices that don't have this hardware?
> 

Accepted, will use AMD specific config.

>> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
>> new file mode 100644
>> index 0000000..6ac0dc5
>> --- /dev/null
>> +++ b/drivers/clk/x86/clk-st.c
>> @@ -0,0 +1,80 @@
>> +/*
>> + * clock framework for AMD Stoney based clocks
>> + *
>> + * Copyright 2018 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
> 
> Can you use the SPDX tags here?
> 

Accepted. Will add in v2.

>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_data/clk-st.h>
>> +#include <linux/platform_device.h>
>> +
>> +/* Clock Driving Strength 2 register */
>> +#define CLKDRVSTR2     0x28
>> +/* Clock Control 1 register */
>> +#define MISCCLKCNTL1   0x40
>> +/* Auxiliary clock1 enable bit */
>> +#define OSCCLKENB      2
>> +/* 25Mhz auxiliary output clock freq bit */
>> +#define OSCOUT1CLK25MHZ        16
>> +
>> +static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
>> +
>> +static int st_clk_probe(struct platform_device *pdev)
>> +{
>> +       struct st_clk_data *st_data;
>> +       struct clk *clk_48m;
>> +       struct clk *clk_25m;
>> +       struct clk *clk_oscout1_mux;
>> +       struct clk *clk_oscout1;
>> +
>> +       st_data = dev_get_platdata(&pdev->dev);
>> +       if (!st_data || !st_data->base)
>> +               return -EINVAL;
>> +
>> +       clk_48m = clk_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
>> +                                         48000000);
>> +       clk_25m = clk_register_fixed_rate(NULL, "clk25MHz", NULL, 0,
>> +                                         25000000);
>> +
>> +       clk_oscout1_mux = clk_register_mux(NULL, "oscout1_mux",
>> +               clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
>> +               0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
>> +
>> +       clk_set_parent(clk_oscout1_mux, clk_25m);
>> +
>> +       clk_oscout1 = clk_register_gate(NULL, "oscout1", "oscout1_mux",
>> +               0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
>> +               CLK_GATE_SET_TO_DISABLE, NULL);
>> +
>> +       clk_register_clkdev(clk_oscout1, "oscout1", NULL);
> 
> Can you use the clk_hw registration and clkdev APIs? It would mean that
> clk_set_parent() call up above would still be needed but I guess that's
> OK. We don't currently have a way for non-DT based drivers to configure
> the parents of a clk when it's registered.
> 

Accepted, Changing in v2 to use clk_hw_register_.

>> +
>> +       return 0;
>> +}
>> +
>> diff --git a/include/linux/platform_data/clk-st.h b/include/linux/platform_data/clk-st.h
>> new file mode 100644
>> index 0000000..5ede980
>> --- /dev/null
>> +++ b/include/linux/platform_data/clk-st.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + * clock framework for AMD Stoney based clock
>> + *
>> + * Copyright 2018 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#ifndef __CLK_ST_H
>> +#define __CLK_ST_H
>> +
>> +struct st_clk_data {
>> +       void __iomem *base;
> 
> Can you include compiler.h in this file for the __iomem usage?
> 

Accepted. Will add in v2.

Thanks,
Akshu
