Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbeDIUtJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:49:09 -0400
Received: from mail-sn1nam02on0042.outbound.protection.outlook.com ([104.47.36.42]:53221
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752422AbeDIUtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:49:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 00/11] [v5] Use global pages with PTI
To: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, aarcange@redhat.com, luto@kernel.org,
        torvalds@linux-foundation.org, keescook@google.com, hughd@google.com,
        jgross@suse.com, x86@kernel.org, namit@vmware.com
References: <20180406205501.24A1A4E7@viggo.jf.intel.com>
 <c96373d0-c16a-4463-147c-8624ad90af61@amd.com>
 <b9802f89-93b3-b535-742c-f84e9f5be832@linux.intel.com>
 <1b45ffd1-99bb-4ac1-fb65-0de3e42c1c0a@amd.com>
 <f87b6f47-2416-4c12-55dd-5f0cb86f1464@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <12a224de-b298-94ad-9a09-79ac67fac80b@amd.com>
Date: Mon, 9 Apr 2018 15:48:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f87b6f47-2416-4c12-55dd-5f0cb86f1464@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR1801CA0008.namprd18.prod.outlook.com
 (2603:10b6:910:74::21) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 506beaf9-02bd-4cd0-774e-08d59e5b5483
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;3:5rsGLS1+tpWmVll9PhkLHZBLmrooXWYt87wnhipY14RwuiqReS6kF2RQMKbxkpDCEqNtZM2g6/RTfmsPbO/faxXmS4ZIaKjfkQwrk0hAjcfe5uUP8FIMzJ7wyzF0yjcxFQNZYBzKB/h2p6am41Rtob3SCL46cy6f0Y2MAL2vlDg0SoOng0j05/kRzO78Kcoii3dqZ3t0Gau3EmPGumRlFg2RToM229zFWcwvexr4qbKtzkP9R7ncD5L7nCHKvVNk;25:OYrRus5rrbGxmwoTWxeAX+reSypXYbLc1Ko0hwZelTWIMIF7zpAQi9TRQhF5BUmt4o4uX/2ccNv/odfKqaO6Op1M7GxuYDcBZ+eepFrQb6LsLMynvpKE5CRiQqiCW7AAz/Pm05695riBlW0nBwjNkTqY937zpdAjdd+AwTis+SfS1Nu6q5+Gcq9JfpZQRqCUFVjld0YiX2z2prZ9FL4VbSXPu+wfFIzhD/BbcsvtTtGpH/WAOMijFAokNIPUOfubPMT1KanWVgf1TvVCEuaSGa3tEXEPKuzB3n9RNCQdErE4PoKCsrpTb+NWBSjJ2GBffROAXXmDTUt8wurRtM3B1Q==;31:3RwTbPyfyXW2VDWjQVrxbQQJweAxYHhAttiGcXXAKFn/MVRdyIhAHZgb4Ned31ke7t62+Xk2FD5+4xa2nQBhNGfqCdCk+Fbg0YAtxE9TZ/DH55Ut+l6t0ZsEL14ofoEEcdEOD1MaABE8G2DmVMv9/F+92DPAYpj/eagGp+Z4pXN5LiovzXaRTtqhA0LOXk5KVHQjO4LvgK220xq20rgxdA65ZY+UQ+WAVB4y6CCxjFg=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;20:LyYX4zbdcyvfusCd+hOI8hJBsVf2prl2aZ2J1HVL72bZQYAiZgdANpTJgI5wvZjOKNAYM/+fDLCN1niI9G0pChCqbqqzjlmS9tpYokkom9rSKetW542Amawm+ayTbqImBkAOfLYaYbzqwS3x+Zvj3+JS+JvOgvt33/Ql8RlduD9x85+o4LPCQ02Q6pxcguU3bPfqACj7YohUAYOOi7o4rg7o2f7E/waETtVzX2Fc2fbNVEHhpqHWnVALHBH/8wbqwjrsQCerxagT02oOX+By8D2Wno13DiaAvQHQqU0d04OfHtje4Vo4SnRuxmO0iaqQT25ssMN19YMnAdqrZ5CnDxOAu1SSNLGTMjw3xZOCjlIJqUHJXC3jlv+D65edBD3+CTtPmmT97h1LyaaHbWMriBmgt82RY4HoAqky6T24ngH/Ku1kJhAQTGT2klc2gFWUlzZ7JFJ1FK3opP2yURdj7jkHcAcqulx6rYAw734H83XUDH6rcyOMM997hNzkLYfm;4:RQG9ZlUxtNGCnLnwU/ND38h4fFUorTPrk1RCPYzVe4iCXlonGix4iHMs3frjO2WrnlI/QeGSvgehBDMgvLc7OEkVRPIVQ62ydsVAm5Si8wbihzlxdE3XDtEcka5uyFXUxjQuozhjKnap70Oard5T5cxQoFCozZrFmQOIU+OGaJSpNhZmUlrZfod0ZQyK6KQsfc6G2Z0n9ZK1+MXlfqlugIvt7+W4Qvy2Dqxhc+Z75ihH+fxLIIpNTUNauwte7e5bhazN52CUiZWCqHziPoVo2Q==
X-Microsoft-Antispam-PRVS: <SN1PR12MB0175567BBF339F83D1817A49ECBF0@SN1PR12MB0175.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:SN1PR12MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0175;
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(366004)(396003)(39380400002)(346002)(39860400002)(199004)(189003)(66066001)(65806001)(47776003)(76176011)(6486002)(23676004)(52146003)(2616005)(2486003)(6666003)(53936002)(476003)(956004)(11346002)(31686004)(64126003)(50466002)(486006)(3260700006)(77096007)(186003)(26005)(36756003)(68736007)(25786009)(446003)(6246003)(305945005)(65956001)(386003)(53546011)(2906002)(16526019)(4326008)(81166006)(81156014)(93886005)(86362001)(8936002)(65826007)(72206003)(16576012)(316002)(230700001)(52116002)(6116002)(5890100001)(31696002)(8676002)(97736004)(3846002)(7736002)(229853002)(105586002)(106356001)(478600001)(7416002)(58126008)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0175;H:[10.236.65.235];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTc1OzIzOkJuTkhIRWFJdmF4U3NsbmExS1NTdVUzbU1I?=
 =?utf-8?B?Vkw5aURYZEhNdzIwYmQ4M2ZrOVNQdUFjTDZ2K0xWbldDc1lPNGMwTlA3QjNX?=
 =?utf-8?B?MWRtYTczWG1MeVhXandLWmNXRlNPUnFoWVVjU09udzNnajZYQ09lL0lzVlho?=
 =?utf-8?B?VXJrdFIveDRCWDBPQjBJaWJVTTRhMm0waGdMUVl1bkx5UHJIalAxZVBEdk9s?=
 =?utf-8?B?cmt5SThodmhQbDNmOFg2cjU2dWhEZm1TeVlLM1JNZ2pmY08ydGdRdkNva0tu?=
 =?utf-8?B?M0VJQVorb1FDOWd6SFZvOEJKZGdlVkN1WUpDSitoSC91Wmx1VlNWUkRkYkdo?=
 =?utf-8?B?NmNuYVI3NWI5Nmg4SU1pcDFzQ1ZURW9BUnloclpGR0tJT0huN2IzSEhUOXVD?=
 =?utf-8?B?TzhpdHZFV0ZkcTUvUjgrWm9EN1p4QlhhQlFOc0dZWjNHVUJ4MThWdCtUMDJr?=
 =?utf-8?B?NXhHRHhOZVVLMDBoaEttY1A3UkhVN0F3LzBDVXNjQjZISmxZSDhPMzI1c0xm?=
 =?utf-8?B?UkZPZGxlaU1xZDVCcWw0K25SV1ljbG1zVjd2Ym00UWNycy9qZm1kTW8vbUNW?=
 =?utf-8?B?bHhyZDU5MU9yRGlpcmdOdjBqN1c2dHFKN2JVVDVOcWdSU1o1VlMrTGVaRWsw?=
 =?utf-8?B?R05HNzgyZWdTdjVMQVlRYk5qSUlacWl0ZDhMSlZwOWFsTmJlSlBWcTJRdVZ1?=
 =?utf-8?B?VFRLYUV4TEVsMXZuR2RwZWVaWjhrOElCbTJlenFHbXZwN2ZYU3pSZXFtUjBW?=
 =?utf-8?B?KzlJbFE1TE1sNHVUSXkwWnhOejdzalFISEtQSEdGQ0hPUmJtMkZrblhZV3l0?=
 =?utf-8?B?cTZVVnRhcmo1allNaHpVNzFxQzdKNjVTMkVJamN0cjZIdXlyYVhTS0poeWRs?=
 =?utf-8?B?RGhKTnBDUU5RUzdYQ2I2T2hCbVpPd1U0dG1VMjBSVE11aHVaQWpUODI3bzI0?=
 =?utf-8?B?Um9STWpMVGhPRW9XWXhPNGh1azlWMVBQR2pMTUNnZVdKSUZ2aXpRS2FMQlgw?=
 =?utf-8?B?YmlkaUVVaWwwT01MMkozYWtPTmFpOVFJUkVOSXNLMDZpK21saTdxZDB1YUY3?=
 =?utf-8?B?RGpENWtpZDM2ZnVoQlowN1Yvb0UwTzdlS3BPc2JoOTh1Q2VrK2poRXBQZCt3?=
 =?utf-8?B?Wlpxdm0xQkhDazZKdWE4TWZtRmVsenJnU1JjWUpNZ1luRXU1TEFuRmJuVDd3?=
 =?utf-8?B?dVAwaVFZcmZIbVVMbUs0b0ZSYnJxRkh6cnF3SW8rNFp1ZFk1SEpFU1ZPeXFq?=
 =?utf-8?B?UTU1aEVaZlVtS1ZWSHA5djZXanRrcS9aRjhHWUN6TStCM1hDeGt0dTR1Rk5D?=
 =?utf-8?B?cmI2a2xzbUVTTmdmVFRvaTJlYnhZTTdCSWNUVWFtL0tMVjFZbDdNdnRhL0No?=
 =?utf-8?B?SEZwN3F5YzRMZkxIQ2JPRHVtQU9ZWHFDSUJkTzNOK3IzazdURDhIdDRMdy96?=
 =?utf-8?B?eVhyZlZKRFFzYkttZDcrRXBVaHY0cUEzZXJFcDFmRWNwbDdpT2JMTnpyTWM4?=
 =?utf-8?B?VlV4cm9FZ3BTYW1kYlZwWHVqK3JNSk1kYTgzN0ZaNEhON1NOSmRNUDluOVdE?=
 =?utf-8?B?N1F0djRHd09nc29VS0dpRG9Sd2pVUWUzc2dXWkYrUGIrUFdtZ0c5d3VrYkhJ?=
 =?utf-8?B?MVNNWERTZnBaT2IxdTlWbFdlOUNkaCszYlZkdUY5dXgxS0Y1TVFvbnJpV25N?=
 =?utf-8?B?bUpMR3A2ODZMTUdGeGFFeHdqTzVWdkhoVkNEeXNoQVphS3JhRlR3Y0NTOWdC?=
 =?utf-8?B?VkE4V29zYi9KTjRvUG5DTnZLUVIxaTF0c3JHWFZPeFdIeUlxSmVrVkVVVHFo?=
 =?utf-8?B?VFZCV1JQRzNtN1NzZzRubnB3ekZDRHFrdURvZnFYVE9oeUpOOW1zQ1dSVHBL?=
 =?utf-8?B?U3ZVd3lDOVA3MnFsWWFtNVFlZWlQNHRzaTNMMmszelU2TFprdXQybHJaRUtU?=
 =?utf-8?B?c3JLTzZINzE4VURhM3FMOUUyZElSNEphUDQzOVVrN2N1SEhFUjVWOXM4VVBC?=
 =?utf-8?B?Tm51RkF0Wm8rVHdxUEE2c0IxSk9SSGNsU0k0bVFmNThnVEZsMVdoZ2FXT2l4?=
 =?utf-8?Q?JtDc=3D?=
X-Microsoft-Antispam-Message-Info: n5qqqc+OmB/08SenPZ0vUP6TX1HY3IyPymUdavTNdrJ6qDW1IR1PyluSbkhw2qvcpY+QcgyG5hHhyfrWBfEMi8SPFwhJp5yQJU7aiyYvX2BGKO8BSQZwpaH5GBZxsc1rSXlJHrrAmOo9sLmWYBHnu20D/szvISBqeGqpTt7dzTRvzRsJsd6YkJtKCEt39X8w
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;6:TuicPi0D1KRvvB6l/twGEBSAhKaU/+kVS95fCkX6XZ+Vdy+LIkSuukxAkW54a90Aiec7z+84tfzINrhXL6l/YhkhVVrnBa2Objx1ZP/78ssiOr12yXbpiYyIRLRHL/lX1vuVwpPoOrboQTRQjlk3lg20SFkiqIKTfZgtqRAV+Pbc6cOM9nbzALwRH/3TUnNRRmVqSRVwkGGhCZJ6Da6kG5CZqYNZkJInV31cmnrB9to+1qZq0lhvZ/Bkw63PtxjqOKxcf/hT0md6s4EaWFeRZoqwIoteBt4/d73JDC5qZ+t2MsOp4JOcWQ7dHTVSvpQb0lS41tIh3THwf5kakO5p59H80PJAlw1vSnHKkGV2F8PYIRWoa0hNVO9wikGZoNJeTcpP088QVxGVBnQ5Dn5tFxnFD8yGUXQ/8LD1u5bU/rT182mKg8SyAEgrRa/z7P4fXTlLOKhfmP5AmSDutFx8yg==;5:APwNoFDAyeCydAgtuAhTPt8s1KzuRtU4Q0H14hJvjoX2NEv2upTYhtKkJ0oPC6vBjdDQEYnmIXuOjFavGFzQvT/eZGMFrczLq64nWN8QrDU6nNbPUVuDIB/Uy5XRmDXNCUaMhRHN+WwA5WBI8OrJbMg8kVcp+U9U41r3I2oGuuY=;24:ZFRDRoRN6NdIaedhoR+TyhqdIGSVPMiTjDgoQcRWocouwyPfWRSSAbfg0/w0QkFGz9qf3aFKP5omvoGGt8eSlYP2gxRdl0vzuvJIXlb1CMo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;7:tWR9J5UecdoPjL76Wy74HcUmYatOLEO8zmckcfo3dkyIFcRuyCXubHsu25dCPM2kLrCRx/f03BGA515xQ4F95lgrOwldkX9vMOmaNHx0gc2RvcscXrtVG3AViumSax39WZy3Tp0h7m+86cq6mHcMSH1rk6PkcIqGcIfmSse8rEOU7FLhr5MxLViCCCZKwIDMo9V060fZ3BI2ABNpR5AHdp4mi4fYf4mYrPQuvQCWV7Fva4Q1gS4CjLCboZs6ouA5;20:FrUJHfVrrWrSjiC7wfdux4g9vb6nVcDiixA0lkEKYKPOJzycR/RRr0r91rOG2MsoWyIKvga25kev3S2gKhP9nlTLfk7IzO6CHojWULtJhxfAPO5oT0PGe12sAtjoIpH+BbDku2CgO9x0T3fLF5o0IhTZa8v/WLrphZ68bHHuDpLyyMXj5WAnd8U4pgxj6DBtTLdE6wF2+4+6cAFaA9OkjQif8bCbiwg/joCmAOZxp3WBSZSvAsRbY7snZ4K3YwHp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 20:49:02.9751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 506beaf9-02bd-4cd0-774e-08d59e5b5483
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0175
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/2018 2:50 PM, Dave Hansen wrote:
> On 04/09/2018 11:59 AM, Tom Lendacky wrote:
>> On 4/9/2018 1:17 PM, Dave Hansen wrote:
>>> On 04/09/2018 11:04 AM, Tom Lendacky wrote:
>>>> On 4/6/2018 3:55 PM, Dave Hansen wrote:
>>>>> Changes from v4
>>>>>  * Fix compile error reported by Tom Lendacky
>>>> This built with CONFIG_RANDOMIZE_BASE=y, but failed to boot successfully.
>>>> I think you're missing the initialization of __default_kernel_pte_mask in
>>>> kaslr.c.
>>>
>>> This should be simple to fix (just add a -1 instead of 0), but let me
>>> double-check and actually boot the fix.
>>
>> Yup, added an "= ~0" and everything is good.
> 
> I'm testing at this commit in the tip tree:
> 
> 0564258... x86/pti: Leave kernel text global for !PCID
> 
> It seems to boot OK with RANDOMIZE_BASE=y for both PCID and non-PCID
> configuration.  Could you send along your .config so I can try to reproduce?
> 

Sure, I'll send it to you directly as an attachment.

Thanks,
Tom
