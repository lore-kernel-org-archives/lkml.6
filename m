Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbeEONbj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:31:39 -0400
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:28412
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752863AbeEONbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:31:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 0/2] support kdump for AMD secure memory encryption(sme)
To: Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, dyoung@redhat.com
References: <20180515015133.4363-1-lijiang@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <55bda494-bee4-5696-03e5-fc21c9d6b631@amd.com>
Date: Tue, 15 May 2018 08:31:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515015133.4363-1-lijiang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0151.namprd05.prod.outlook.com
 (2603:10b6:803:2c::29) To DM2PR12MB0171.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0171;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0171;3:lYpuDHpwV3exVfaoP1tFZSWkCmxh5nDJf39ztZNEdgK4O81/H/uJ6OL6LCE7auW1t0HjcHh49pnoHo3ZSM5p7V8zdPUH2oknsWe05LsPmkbIJcFovGpHRsy0HkUHTQudJIC8qLW+TLilS+7aH9OShbrv0wegnEJP7ltl7SxkB3ox154RNsMN6u9PqUy9BkiRPgwWJa7NhJJlDi6UOQyuiHq5edR25lIUOD9Y5VtcNoor2Xa2eGFyxAxZLL9TEtmw;25:OuiHxAXUgMCxr3II4tCl5VyriLDF6BjH96pnknuAx7JdCU4lhGy9joi8c7IAUCIs2AYYUYsxg3i/TkV5f63Om6J+PL05XQgTZ9eJj0htKhGuRZGfJIcQlyyHiyk+p+dTTuV6/QonB9W2UC56PQKC2VbX1R+oGE6Fs2FHKIZYBHrfOAn9q56hi0s14Po46BxyTWWhgW7m8Sp0cNyBbIdy6Iff0W9mL0sk0GRuGUm1sVgd7AkkB0FgqHnCv/9ezytG2vT5uF7uEoX343F8UMrSvwOsIXkbQcJOmr+W5Cf3SiEUR8Lcu9ky2fXiUuxP1sGsEZ/ApA2Pdai7Uptjhiy3SA==;31:BAdR2gq8E6KfV2IiFwdlDJZAMSwcxjX3Zg25OZjzq8DraqZs/Bv434cYRS1VvLB+AAneIivXIezArcTc28m/bDp5BV98wa+uCYtUd9mRN0H0Jw1TzALxGvE3Tfrj+0Qz8gMnwolg3kRo41VbxZj7YvgYIw1kqqMjIRDRCn1cnCFjBb9lqkyAaK1To7qQHeh3ywe/FVfKF5XPdDMlzCXqSAr2N4JDyye2Erw7by5owHk=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0171:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0171;20:e283osbDYo717Vl79LN+4mVBMbXEFt0SkOn5YvAa/3ZJIAu+NS2W6mP+5FDjvf98INC8c3I037dDdmbu3kmdnwdTFHcCVemKurCdwnXTLF2yEazKQ3Gc6Ya4dfitp4wb6GYeE1Cujs4LrVB/36wnxXc4y/22+E57/8YRd9dwKcw02UP/vmg/0+nRDlTi91UXqlkosMVJ/Hbpmu7FdH4Wl+aEF2/34VHsGZqf5xd3BBWsfASjrbgpf7X27m2aVz1Vt+rOfOGbhmKsWRPpZTPQnG7JrH/KMr8LfE+l6dbUdidhQM65NXNiE31y2LVFPav+/mzT1245ps9cIVySOqn3gtwMWbfyOB1p0WbyUqvPxHgbQMspVet8GejFXXglqlZ314MP1ZhL3VUbhfvWz0spUA2W77VRcp079RFBcZdCVckNi5X1gejJNoOhihPu/aCuGhg6R0o1GVGit5TOMXW1cVc/dTrFNaVoYotNAjr7xg/YKHEEpWggpU/3mNZlJljm;4:D1uIvsHH5Ifoi5oNMXsjSMs4KedW2ExkvFL/E/04+dEOnOozzevTiwIP278/ZoyQqVA/k+9tApiLBQM6LIxVclGmUxMATbQBVQW58PwBEolbBVIKsX47wxqEkrGw8uCMxZHIDqUWrpBi8mGz776xcxCNF2roRMIvtyw9/dKzNXuo90/cOAoLXvQMGId7Uahx/bAFh6zUEs3npFCceSQnWmoaALQB+JvJluKqJG7JxgE/ModqIeYMk76Ez3UZG35/fbgIVh8EomN8Dp6WkancIdGJaJjk8PRBBjDSuFb4xcV3twW4TNlf1iyJo8Y6ftEJkebnbTKlMz8cDfDYZA5+1NLDVoqrie54P950YkavbsNE5vKwu2pXHNxE/Fu6Shru9WhFfjdpLvjDe24T+Irr9S18DaYF3WhNpO36iM5tlP0=
X-Microsoft-Antispam-PRVS: <DM2PR12MB0171EDC8CA6DD8BDAED75057EC930@DM2PR12MB0171.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(166708455590820)(767451399110)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR12MB0171;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0171;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(189003)(199004)(8676002)(31696002)(305945005)(478600001)(966005)(486006)(68736007)(50466002)(77096007)(3260700006)(4326008)(476003)(25786009)(6306002)(8936002)(7736002)(58126008)(6666003)(53936002)(86362001)(16576012)(81156014)(81166006)(31686004)(11346002)(446003)(59450400001)(53546011)(230700001)(72206003)(386003)(97736004)(316002)(47776003)(65826007)(26005)(6486002)(956004)(2616005)(65956001)(66066001)(36756003)(3846002)(2906002)(64126003)(16526019)(23676004)(65806001)(52116002)(5660300001)(229853002)(6246003)(6116002)(106356001)(52146003)(186003)(105586002)(76176011)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0171;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTcxOzIzOnJEWjZlUGZxN0lGOEkrY29LMWhGaXdWVkxL?=
 =?utf-8?B?VFE4YlI5QWxmRzFEY3lTbzlaVnZqSjRBVVhzMWYwUzRPUFdqOEdUYmdkZW45?=
 =?utf-8?B?cEN5OXloTW9XSVBULzdidWViNmJIQXVBRlNnN2I1NElSckx2bXppbmlJQUpn?=
 =?utf-8?B?cHdvTGRSeXlwK2ZrcGpsRUlFSUs1aUovbzQwNytoM2g5dGxpaWlNaFd0UGMv?=
 =?utf-8?B?QXRRSUFzei9sSmIvZm1mdHJQSnFDc0I1VTlkd3hCVkZHYjFSbVlBTkhTK0FC?=
 =?utf-8?B?S3orSWJTTUpKcVJYbUo4Q3Nja3lvdG9sSmJobTFiMWx2V1NqdDlhQk0xVlVL?=
 =?utf-8?B?ZDJCaEdlS1FGUkt5cC9nTDZnRy9lTlZUODNseDlLOEN5bXB4TDd0Y2xiV2p4?=
 =?utf-8?B?R0xRQ2VaSkJub1hpQUhsaXE0L3BHWFRkSmRNd1hXbU5XeUI4dnZ0ZFZqNko5?=
 =?utf-8?B?UkV6Mm9TR05KeFMyQ2t1RUQwNUhhNGRXM2lJbmU3WmQwclRjMDZOSDRMOFdF?=
 =?utf-8?B?bmFvYmhvNE9WeTRRbm1XVURKM3EvWW1GbUYzS2xoUWgrbkNuWVM3TCs2QUQ4?=
 =?utf-8?B?ZWNHRjhZS1owM3VZbExRQ0d5TXhDVU9Kay9veEhZSURVck83cUplYWxDbzFO?=
 =?utf-8?B?ZlBhMWdTRTU5MTNnUWcwLzN0cjdrdjBRRXBYeGRNSzNuQjFxei9QOE5zR280?=
 =?utf-8?B?aE5Vb0hGUXY0dnNwQUpOSUxkQjk0eGZvZFV2SGFRcEVDTzZKRit6YlFGTE8x?=
 =?utf-8?B?MTgxaWNqUkszWFZITTZzbWFLc0Q4b1p4bk5aV3BqUlJlb2p5Z0lMK1Z3TGZK?=
 =?utf-8?B?Mm1rWW55UlZ5NUcvZ1FtQ2lIMkJ4RWsrMlI5QmI1c2FHc2toTHhNWTZldlpR?=
 =?utf-8?B?dDNTR3g4WGJNOUdCbzlPU3RNTWNITHI1MnV3YWlHRW82ZmRDWllKbzhhdytS?=
 =?utf-8?B?SGxvQVFuSndMUUJPc2Rva0RRS3BLM1RxdEJyS3hQYW5KWlVFV1k4VTd3N1pm?=
 =?utf-8?B?QUt2a21Fc1ExZGhNY2FKZSszN1RqK3lDUmM3R1lQOGYwTXczS2lGM25xZnVS?=
 =?utf-8?B?U2RTSFA2eDVVNlRDLzdMS24ySzhxVTFEempaTXF0MU9NSzhkN1dnMEdHVURq?=
 =?utf-8?B?TlBIaXVLT1ZrSEdQMGY3emxBMzJIVlN1Sm1rVlA4SGY5RXk4MUllVmxkQ0ND?=
 =?utf-8?B?bjMveFI3R3ROSm9hcnhrQmY5bGNPT0xmRVJtVDlPRk9oQVFqMjFhR3A3Y1R2?=
 =?utf-8?B?VFFRZjkvdGVCZGQrRktHWk1PcEpmcUZjZ2cvT2pHWVhsd3dXb0N4a0ZkTVFG?=
 =?utf-8?B?RnRXaUFWRE1MWkVXd1FpazZDMVVCbS9EV2l0ZlF6NmZZd1NYMm0vSStlTkJQ?=
 =?utf-8?B?amFsYlRta284TFRVVjhlS1lFQW1xZDNmRS9OcTNFeTdLUW14Nkw0N0owZmFz?=
 =?utf-8?B?ZStyend0ZVVFbDdLVG1JTS9IODVhUFNZeXAyd20yODNUZXd2alpTODJnL3Y5?=
 =?utf-8?B?cnNndFNsSjRaWjV2eVhObGJOaGswQ3ZxYVZrQ3RBeTdXUFRxTUJiMkNpaWxK?=
 =?utf-8?B?VThGaGF5T1huajgwa0w3dXplK3pta2tRTTdDQXRBTnByRUNIVkxRcmtjNENS?=
 =?utf-8?B?d1hGcUk2cTZTMUZyZlpDUzNmWjVTY3A5bVBXaWxzOGl3d3VOTGp4RWtnRndi?=
 =?utf-8?B?ZEw5a042MXBuZ1RtUExrNWxlSXpSVVc3OXhGVHdkSFhydjlxMXdPdTZFb3Rv?=
 =?utf-8?B?NTYwQTc5RG9odXVoMFV1UVlDZlI1d3RlZkNmc1dadDFOYkk3NHEzRG1KRW5U?=
 =?utf-8?B?eCtaOXlaWEZZRUxIMlBkaGFzMmVmcGZnYSs3WGlDNVFLNVMrcWJsZ2FDT3kv?=
 =?utf-8?B?OVIxeVdlSDE3UHMxekkxZFNEdklYL296ejlacXRuUCs5Z0N4dTNJd05xUkRa?=
 =?utf-8?B?NlRNRDVIV1ljRExJL1FVZWsvYkN5VDZsdEdlejFoSzV5TGJXajg2UXcreEhW?=
 =?utf-8?B?OEMrM2JMVmVJclFYY0xFVkpVN0IxUHNaQUZ1dEdKc04zYnVlZ3BEb045b2pS?=
 =?utf-8?Q?Qwus=3D?=
X-Microsoft-Antispam-Message-Info: yFEkzlHssm8EE8luK7E75rDUnA0gbI7sO4U+J7w4kQIwLK3YWpyw9KFPK4byiZYH4JoWmWrj/69JsPoWKmG+u9u0EFdhPcl5Vwx6NBNotXgCMEry+0a+qXNwNvCiUMjUe6L1k+LpvK+4kcLP23CNQeQIVKM25i7K8qjl8BBJeYF1Aave+4aLk67/91Mtteyg
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0171;6:FXtlk0o4jvvAjFgeknIOtV1CGoG6EbzLEDWxDI4Xt/ygctRCN5PkNJHhsN443pLCTyJiB8KkmFQhiiCISmnY6bBt1wZ4PDBqPbHylTG32Vo5bSgAaASygQrvPnt464lo1UnleKj9oQZXHXZ53dfbP19XgsrCvE8Kx558ZE90VXOkT23izbqWs3Qp89tgdOk9gWkDKnC2rWqc4S5VW2TrC807dLn0Q8+5K2EPVN/3PV+mI4JGk0GTH8i/sxuHcW2fQbL1XdMHjJCl2AledyDXhOxYE3HFI6ze5/+7UEWBGjZSFR/sEo/xCDJZH+mVxZtOhD+2+hQqzHNP/q9bZOVgNV6d8oOqEEu8tUvVnuoiY/TZLWo8b5fXylitRYKHPhgzBwIYqDo9yDVlbPI1s09z0dMFuVSE9TTOTlhNcCERlpZWBdLNsP+9tkVMsJwn+AJPG+4mg5X68GO9PWCzJygWAw==;5:2BpOyJ6RJt4qdA8otLAR0I5rrVCOoHtsyHX3nHN25fXuDHA8x0rqfF1Osq7S5oWPACk1yz5PPgzEno3gIjx9+Q433sW7Z4NCZ4RXmf44XtlFTgeTsN+nDJ/NRA39QTPM2PxyA9aQvI8fHx2efXC8gNzmfE3kp0dAHyjIgtDXzFA=;24:Hf8kt8vTlfBOA0WMFtoFCQMgQdlxbzXsswms62mtbCxgo688GXmhxapL96/r7BEykq9sbxB0Z4/o2z0n03y/qZr3F5sOluEPSSIsgOvRics=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0171;7:zr9Ony4cTiOqBAeMHFmqt3clXyPwLhUwlDLRPWEIQ1OTcezMGjVWdHEYkSx0e2rmhL8xK8tmQ8P5PY1lZVWCDJqg6TSe6kgm/oJvme3KeWO9kyOkDHSUHy4Kx2UbbWrs0UPwlyEi+lCn01GN0HBZvdeIRuP0TSRs3sHZtQmeHft7EX0vx9j6XXVDkqvsgqtG+cj8deCwvFQFjnjyn9w1KxVj4Hn5IHUPYJHthLeWMHLyP859ve0Dxzkjo1Pg6oz8;20:kfTzo5jGXNqyIsxRWO7eiJFQmjebtWy0X/ONy6T23c8Kq/cz2I420VXImfKKOxd4thnXSz/rg4qKkDFRdQMYtXguekjIOSnSboEl9b4pZxKev6cCEcL70DFRtDMFxvj1IdhR4OAPw8vLdRXPIOAuYZTIGzcC8/paJGZWpFfXQWQeLTT5QD7Cj0+SdSevK8G7S3+DyOslCXLP/l1luWOPCM+ECFuj2zw0M2wLKAFmKqDaTv7iPONyr3VK1AgIonDG
X-MS-Office365-Filtering-Correlation-Id: 9e260eb6-c273-40f1-bd5c-08d5ba682be6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 13:31:30.7606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e260eb6-c273-40f1-bd5c-08d5ba682be6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0171
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2018 8:51 PM, Lianbo Jiang wrote:
> It is convenient to remap the old memory encrypted to the second kernel by
> calling ioremap_encrypted().
> 
> When sme enabled on AMD server, we also need to support kdump. Because
> the memory is encrypted in the first kernel, we will remap the old memory
> encrypted to the second kernel(crash kernel), and sme is also enabled in
> the second kernel, otherwise the old memory encrypted can not be decrypted.
> Because simply changing the value of a C-bit on a page will not
> automatically encrypt the existing contents of a page, and any data in the
> page prior to the C-bit modification will become unintelligible. A page of
> memory that is marked encrypted will be automatically decrypted when read
> from DRAM and will be automatically encrypted when written to DRAM.
> 
> For the kdump, it is necessary to distinguish whether the memory is
> encrypted. Furthermore, we should also know which part of the memory is
> encrypted or decrypted. We will appropriately remap the memory according
> to the specific situation in order to tell cpu how to deal with the
> data(encrypted or decrypted). For example, when sme enabled, if the old
> memory is encrypted, we will remap the old memory in encrypted way, which
> will automatically decrypt the old memory encrypted when we read those data
> from the remapping address.
> 
>  ----------------------------------------------
> | first-kernel | second-kernel | kdump support |
> |      (mem_encrypt=on|off)    |   (yes|no)    | 
> |--------------+---------------+---------------|
> |     on       |     on        |     yes       |
> |     off      |     off       |     yes       |
> |     on       |     off       |     no        |
> |     off      |     on        |     no        |
> |______________|_______________|_______________|
> 
> Test tools:
> makedumpfile[v1.6.3]: https://github.com/LianboJ/makedumpfile
> commit e1de103eca8f (A draft for kdump vmcore about AMD SME)
> Author: Lianbo Jiang <lijiang@redhat.com>
> Date:   Mon May 14 17:02:40 2018 +0800
> Note: This patch can only dump vmcore in the case of SME enabled.
> 
> crash-7.2.1: https://github.com/crash-utility/crash.git
> commit 1e1bd9c4c1be (Fix for the "bpf" command display on Linux 4.17-rc1)
> Author: Dave Anderson <anderson@redhat.com>
> Date:   Fri May 11 15:54:32 2018 -0400
> 
> Test environment:
> HP ProLiant DL385Gen10 AMD EPYC 7251
> 8-Core Processor
> 32768 MB memory
> 600 GB disk space
> 
> Linux 4.17-rc4:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> commit 75bc37fefc44 ("Linux 4.17-rc4")
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun May 6 16:57:38 2018 -1000
> 
> Reference:
> AMD64 Architecture Programmer's Manual
> https://support.amd.com/TechDocs/24593.pdf
> 

Have you also tested this with SEV?  It would be nice if the kdump
changes you make work with both SME and SEV.

Thanks,
Tom

> Lianbo Jiang (2):
>   add a function(ioremap_encrypted) for kdump when AMD sme enabled.
>   support kdump when AMD secure memory encryption is active
> 
>  arch/x86/include/asm/dmi.h      | 14 +++++++++++++-
>  arch/x86/include/asm/io.h       |  2 ++
>  arch/x86/kernel/acpi/boot.c     |  8 ++++++++
>  arch/x86/kernel/crash_dump_64.c | 27 +++++++++++++++++++++++++++
>  arch/x86/mm/ioremap.c           | 25 +++++++++++++++++--------
>  drivers/acpi/tables.c           | 14 +++++++++++++-
>  drivers/iommu/amd_iommu_init.c  |  9 ++++++++-
>  fs/proc/vmcore.c                | 36 +++++++++++++++++++++++++++++++-----
>  include/linux/crash_dump.h      |  4 ++++
>  kernel/kexec_core.c             | 12 ++++++++++++
>  10 files changed, 135 insertions(+), 16 deletions(-)
> 
