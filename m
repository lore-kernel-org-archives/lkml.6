Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeDISEf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:04:35 -0400
Received: from mail-sn1nam01on0066.outbound.protection.outlook.com ([104.47.32.66]:52818
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751549AbeDISEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:04:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 00/11] [v5] Use global pages with PTI
To: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, aarcange@redhat.com, luto@kernel.org,
        torvalds@linux-foundation.org, keescook@google.com, hughd@google.com,
        jgross@suse.com, x86@kernel.org, namit@vmware.com
References: <20180406205501.24A1A4E7@viggo.jf.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <c96373d0-c16a-4463-147c-8624ad90af61@amd.com>
Date: Mon, 9 Apr 2018 13:04:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406205501.24A1A4E7@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:3:16::28) To CY1PR12MB0165.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82fdbdf4-60b0-49d8-839b-08d59e4453bf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0165;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;3:RDuKQ71urkubVF9MBkTs2n8xi7TC2kNF0plDigoWR3dJEyueNkL4iYg2sUQQSMzmtKcmqGHOPpuP1IR54IZs/8+S4u1swnR/ulMbmmKYDmgEsRyg3Qf2L30I1TpctjtMbO3E5Fsc3fZfvbvvCVcJElYMpbJjClXGcLOrJFklG6HjoKSOqq6NFcp39APYCZ2DbvnvXkJ/BFQmv1QycUTym0Qm6nz9uvN8izdw4zfJEePp/QQdl++2jSma2qoLr301;25:vSa/7ICsUx3iAt5rD0fbasnIQfuWRVMp/2zfhs9ihM9rfqflawRKnSb07r5EXn8Sh+NcaKQMGGsAgb6EoD5clin9FrWa35WgkDZIgDUOY7QbPBrU7RIqrUHju8OHzHcqCXHIW3UKaShu7rjMqmbT4XyKHCG/uMRKIB/uF8P9khvqBcKfEZNApVrjzod7RhNbgOwtg7q8Mq+Av8Qyhaw7loaGDPvINp135GtlWMN73gAH7Oo2MUCoC6R234QoitGgF/cLwcf27NOiJn0Tr9VXvX4JimESIj3vQaPMPMe/OXZHIag8zNh7lpJvnW67oIbo/Hfb2a+J5aNsxxRX8eoSuw==;31:ifty7fVugfJbyMA3UjAtnKvXh543al9G2LDCSIHQkRA6b9N3BDcIDJ44fpFdfPJOPrJ1R+N7UA+EXLyrVzpelOyF/+0OfOJaPE+eSUys6+qYuOFVZhATD1dB8Ty+nMeZUXgGngcP8TzC/s5x05ovUSNjBERmQnX7GpxLg4ImvE6utTYnJ7RB4wMKQeYe6xuBN1Axpz6eMzQHxFDxrRMsnYLqo8re5dGaH8gc3N/0p/U=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0165:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;20:hzuieyDMQEILkQfYo1XHRYELj51/tlA5jNM9vmyYhO9NG79oridRqMv7bqXJU9j6lVBBWA5zQJ3QY3H66ceC91EZKgvreUeXTMTYPEbJi0YVocLW5UUqGQsRRLZIMCUqF3K3L+nhUKa3T6++4QUGlLv4OBdcucCu/aTTLRts6GMotzqWUsbb33OhnVTInU8eJ5bft4iBVeFwZCe5u4cKG/ZS5u4gR15Q4D5s3OW6Er1eVSTRaNYspcqTaQY+gy9zpNZhxhHQWwy8Nn8kteMlJ31uCTDhaov9jdw8CwI8zetC4FJ6jZWcAH/SAlSwmtN9wpB/VXKXz1RTP6/j7UoUsXfbfbyJYwUBynP1SR3r+UolnuUaxQ/u+lxezTBYgU5efI03bRY3fx48DmF9C0PQ4GnviOdBt/7quTYLgMM/glWxnCP6g+blBheQicCjimOK2kps9wbObiuDivCPQXT+TzvvoHOOD6+52bMukxJTzM1oSLMD2Qrw7VXNLvEN1Ddd;4:qQEJ8NjGL/7ejd3DLw2RDanZul0114GVacqrm1dW485hncjulDRGJzjKIQiDLX/XTR4Gb6cWcolqcMPUl/7MRSr2YQzLX6XHmVeMmor0nuf0w9HZMaDhPy+pV+sa5mU9DjQUkbzOimgb//BEOE3KdBj8MIdA+B1MTa3IvonKdQWVeKmpXfM2jvYRcSfLCwYF9ghVkWLmd0TfJuWHUaskTdEs3Kowcoq2FCNcgFzDy+rfvyu8D/zmP4iDYmiI7KM+cS/tA7pF3+l1S6N9ppmmK6Rh8n7XMMkgLNfffrImNr8Qr0GPwd4ePYEtq0At5BwrsAM7OkeEvjkbpCXWeLJDh9kPIc+1OtnhAW+qpB6UBftABfkv7oS765rOqiwjsRDMptbFdu9x9ZBr1MWGRVOEbziB4eaz7u8nYeeA+zhRK6g=
X-Microsoft-Antispam-PRVS: <CY1PR12MB0165BBA60A5A2E79D3A8B1F2ECBF0@CY1PR12MB0165.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(166708455590820)(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR12MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0165;
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(54534003)(189003)(199004)(64126003)(956004)(486006)(7416002)(65806001)(478600001)(65956001)(229853002)(25786009)(7736002)(3260700006)(186003)(77096007)(26005)(305945005)(86362001)(53546011)(81166006)(16576012)(11346002)(8936002)(81156014)(6486002)(446003)(8676002)(31696002)(16526019)(65826007)(2616005)(58126008)(97736004)(476003)(316002)(6666003)(386003)(50466002)(68736007)(106356001)(230700001)(36756003)(52146003)(2486003)(23676004)(76176011)(2906002)(52116002)(6246003)(5660300001)(47776003)(6306002)(3846002)(53936002)(66066001)(966005)(105586002)(6116002)(4326008)(72206003)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0165;H:[10.236.65.235];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY1OzIzOkplUHlHS1IrcEQzMFNldXNkbFFxNjhnY0NM?=
 =?utf-8?B?UzhuUVhQcWQyV0hodDBFYU1mRGpkMlFRTTgyVG9Wanc0OTkyVWZBYXg0YkZN?=
 =?utf-8?B?eE5rT2lyZXdoeDMybm1pOTczTGtTSm56SFRwZXJkQll1V2djNCtkOWx1UWhs?=
 =?utf-8?B?YlE0N25WUXptM3BSOWJsU05TM2ZwYlhqVlF0Rkx1a0NoL0pCUUFUSjdkOU1N?=
 =?utf-8?B?bmlsdktyUDJDUTd3RndkU095akh5eklQRGs3cXlPalJGVlBBdTdDUGJRS0sr?=
 =?utf-8?B?MTMrYlZTYUxoQ2tjeVRVY0VodkJGWFV0K2svTisrVzFyRzMzc2MzNTV0eUkw?=
 =?utf-8?B?SzZtaGtHVkUzVitwWWcrQUh3Ky9SMjdXeFRGcXlGT0YrNFhVelU5L2oyTGkr?=
 =?utf-8?B?bWpoWUZqaUl3YzZybHVVRDN4ZWtLcVRLOTl4V1EwcWI4U3JxODRJdjB3aWcy?=
 =?utf-8?B?a1kxY3N2UlkwaUZUUHlQNUdDTEZoOHNYUGQ4NFJPRTdhUzV1V0RZM2tQTFdG?=
 =?utf-8?B?M25VRG1VTDVxNUtFQ2dXYThGaXREZHdMNnRtZVQxdjBqOGxkRVQvaGR4UHdN?=
 =?utf-8?B?SEI2TTN3WDMwbklOOVRkVTFXK0E0OXpqbkhxb0NUalhmc3dxclljVzY4UlUw?=
 =?utf-8?B?anBFbGRESlhBaWp5d3ZzNE94eXEyRUpQU3FlaWtxRlI3UCs0eFFFM29IbjIx?=
 =?utf-8?B?eXBpNnBvdEp3ZjNsNHFJZWJhdCtDMGpyL3NubXptNVZMaDNVNEZORk9QRk9v?=
 =?utf-8?B?NFRjUlNsV3dkeFl6Q3ErM0hRSDJJbEc3L0hzdS9mbyt5VlpMajUzbDF5VFhx?=
 =?utf-8?B?a3pTY1l6SDlFNzFHeEFCajd4Und1WGI5dmR3a0NUVzZLbnRCb3dQWnRFTEZj?=
 =?utf-8?B?OEwwc2Fua0pyWlNGNnZ5SjNCenJva3Y2WVJVbU9WVkYvYlV2elg4amxGb3Zs?=
 =?utf-8?B?eTR6L0YweEcwek1wWjNDTFFYOS90UWVZMmFSNFRwcjAvQ3hQNGV4RTMzSytr?=
 =?utf-8?B?SGc3OGJiVUNCd280WDJ3bjhlM1IyY2NZQU96WEszS29xZENhYko0MVhFdU9n?=
 =?utf-8?B?dmtIZlhPb09PRWx2TnNmUForb3ZRZGd4V3NTQUFxclBPQ0RGdzVWbVIrelJx?=
 =?utf-8?B?MzdDTHZrbHlDa1R5VGJEQWFaNzVIT1d5YVdyNlNDdFZURnJxSkhWc1pqUnRm?=
 =?utf-8?B?djhTVFhiazd2ZXF3MnBxY3BwdVljd0FJclRDZUhMYmNVb1NabEwvM0NqYW9B?=
 =?utf-8?B?QXVXSWI1SEpBSmlaTXJjcXlmOUFSb1J0cytza1NZY1o5TkVyVWNRci9iS1Bv?=
 =?utf-8?B?STdlNDNpWHBVT1dJdENBcHh1UjNUSERRN3pnaGp6NHo4ZUhPd2pkQmN5WUlw?=
 =?utf-8?B?cCtaZUVxeS9IZXVtNHpBUzM3TXhKcDN6WEpDK24xVy9wd1ZQc2RDM3RUbzlU?=
 =?utf-8?B?NWdWblRFZTIvTWpwZ2FNMUh6ZjRYRWwxSFNvMmVtdTZmNFVFWVZsYnE0akgx?=
 =?utf-8?B?N2IrQ1hzN1ZaSnF3SUlZRFUvQTFDc291OE15dEFBSlBnME5DYUQxRm5ZeG1E?=
 =?utf-8?B?YVlHK1d4SnFIM0FJeGFBNDBWY2ZyQzFJR1N3TzdBaHJDbEhBaHNuMzdDd2tw?=
 =?utf-8?B?YkxGcjI4REFZMzQwNno3NTl1NllBSDBqeGJlcjdYOWx3K0hQclA5VFpzODNj?=
 =?utf-8?B?cEV0MlFuT3VERm1pdGFZUXhxdFgzem5ZdWVVQXBid3cxUnpZQjVsVmdoYTVP?=
 =?utf-8?B?UFE2VEs0MHkvb0M0YythQnFwQ203akE5c0piQ3VDUHpIUS9pNERFRGcwY0d6?=
 =?utf-8?B?V2l2WGpveS9Wb1YyVU9CdEpUanZCTEZjQmJzbkZwSFd6SlZrMTVFUk10amxE?=
 =?utf-8?B?RlQ3S2NRUzRmaFF3NGwzMWtSMEFWc2lPUGF4Tm9kZ2greDk5Vm0yYzE2Nldk?=
 =?utf-8?B?QStZWStuUWVlZ0x2ZFp0Q3dpSTAyZlRlTFRUWENLVDZDcUFzN3lBSTZGTzZy?=
 =?utf-8?B?RW1MZm5BYWlYRjlBWkJQMStGTzJJTG1OT0sxeGtGRjlrQnlNZkRNNGNsZTBZ?=
 =?utf-8?Q?CRgU=3D?=
X-Microsoft-Antispam-Message-Info: t/tZZIAZSZO+C+fZCQ3MoRWbaHZ9PD1WdSWyMCU8hJtjNq3BwxW4iDLgUzmLnO3yVQ+X5f+qisEe8B6KqvI7htzdEn7Zz79xwRlyt9+9fgoYp86sCKnxWmypQlJbXr76hvYKuQGHdYqPMUyCqXwt6td67NGz7zEInlDJ7zzoDUNQ9V5z8hcAXKspl9f+VvlA
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;6:BwSK+jqLPjWDfCszQwya1Bun7xxjxLB51oLtTORQRHOrHbwKYgBGOT0XHbWiidIGN2l37Std3286W5PEPB6j172MxfSFl5bULK2x13r4okQJg5hEwojNACWoi8gtcNOtb+V9yD/uVd0LKclVklWdb2Q4+rp/ecxA4AMBDFahXRGMMgrsIrtQ0b5zKTqGLkGlnu+Cdd3jWfYFcD5JFCVDVb6EIdkJ8I/cqVlIFcSzpjXD0ILZ86ypx694Z4HYfX0C/H6QEf3dkhJN/fNKtQFFwAHAdD1hQElea3NNir2DN6sgZnaSs5fsrf95/17s8H5S5ROcCmKUKyHpL8ncdnqE96fTl2tzz902JbjLkMPhN4MoMsOsEmiFJwZxl3N9yA9w73q/kllw19BOxWvpJgcLD4stO2XtZEEpVRjGtMpf262LW6szglc1rISyW1pigRdHP3te6lmbYH2bccx+49rVsw==;5:d3IwcWKB+WRoYJaiWyseF9EKp/1o/vOt26BZudKkFOCg0YoaGX38YHDeF2k7pMoE0hwp4M525r1qxR3APwa8vYsh2QTCIe5CH5Spq0xp231QNqf4joXziVEIQvcP/oc7zb2EkfifRbDFfL0LiC1Ql2RWW+HapRotXYBgboEJ5Pw=;24:AurtHyrkp9tlbEagUxv+xTTq4h0qDFcGkxgLUJHhgSTO9qym0TZS6mFTE+OIp2HM1uaJMe6bb0Av4FBtS7CphSMyWAg6TTdmF+X7kvlK3uw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;7:PrgVa2wLynpfmcdgjXRxtcQuMetc4c56FRsf2Gq8NVWl2ajDX6xs4KtX9Z9e0sTRwYn7SxkVgYeySL8e1hlmkUnGelVMCfS+/Dakzyl8GNi8mx76Qut1cigqV1t8qdA8uxtHXwZGReUpSjpZqGrj74IB2BQWn6idC522taW1fRBdlg8wny89WcNUjGJvVLGCPVI770pg1s+OXWi+842Q6iy8Z0btgRMZqE0lLAW5w1Ow2vLwWHgbuKLkjptMuosB;20:lSQ4R7hXzbrrPo79F77d8VWQaZmAaFgYYqEkPhuO4k/5xTWqJ3uxZ5yp3e/ut2u677YINBB9b+oJsB2T29Y5D6nlhJ77kZeUC/lW3o4IPzHeN+Ih7WVXLsE//OLxbkma7U2E/kuNLSsJllve0ZWK95EnO4O+1l45K6xwXP5c4rQZgxXhXnBM0ozm+5pzBVJe+DTWXtqN8IAFJ94OZzJEpuOFIhGKHa3rl5Rj2CeiiGt+u/gkUIOd4UDozv2umr9i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 18:04:23.4693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fdbdf4-60b0-49d8-839b-08d59e4453bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/2018 3:55 PM, Dave Hansen wrote:
> Changes from v4
>  * Fix compile error reported by Tom Lendacky

This built with CONFIG_RANDOMIZE_BASE=y, but failed to boot successfully.
I think you're missing the initialization of __default_kernel_pte_mask in
kaslr.c.

Thanks,
Tom

>  * Avoid setting _PAGE_GLOBAL on non-present entries
> 
> Changes from v3:
>  * Fix whitespace issue noticed by willy
>  * Clarify comments about X86_FEATURE_PGE checks
>  * Clarify commit message around the necessity of _PAGE_GLOBAL
>    filtering when CR4.PGE=0 or PGE is unsupported.
> 
> Changes from v2:
> 
>  * Add performance numbers to changelogs
>  * Fix compile error resulting from use of x86-specific
>    __default_kernel_pte_mask in arch-generic mm/early_ioremap.c
>  * Delay kernel text cloning until after we are done messing
>    with it (patch 11).
>  * Blacklist K8 explicitly from mapping all kernel text as
>    global (this should never happen because K8 does not use
>    pti when pti=auto, but we on the safe side). (patch 11)
> 
> --
> 
> The later versions of the KAISER patches (pre-PTI) allowed the
> user/kernel shared areas to be GLOBAL.  The thought was that this would
> reduce the TLB overhead of keeping two copies of these mappings.
> 
> During the switch over to PTI, we seem to have lost our ability to have
> GLOBAL mappings.  This adds them back.
> 
> To measure the benefits of this, I took a modern Atom system without
> PCIDs and ran a microbenchmark[1] (higher is better):
> 
> No Global Lines (baseline  ): 6077741 lseeks/sec
> 88 Global Lines (kern entry): 7528609 lseeks/sec (+23.9%)
> 94 Global Lines (all ktext ): 8433111 lseeks/sec (+38.8%)
> 
> On a modern Skylake desktop with PCIDs, the benefits are tangible, but not
> huge:
> 
> No Global pages (baseline): 15783951 lseeks/sec
> 28 Global pages (this set): 16054688 lseeks/sec
>                              +270737 lseeks/sec (+1.71%)
> 
> I also double-checked with a kernel compile on the Skylake system (lower
> is better):
> 
> No Global pages (baseline): 186.951 seconds time elapsed  ( +-  0.35% )
> 28 Global pages (this set): 185.756 seconds time elapsed  ( +-  0.09% )
>                              -1.195 seconds (-0.64%)
> 
> 1. https://github.com/antonblanchard/will-it-scale/blob/master/tests/lseek1.c
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <keescook@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: x86@kernel.org
> Cc: Nadav Amit <namit@vmware.com>
> 
