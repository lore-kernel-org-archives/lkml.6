Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeBLRCE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:02:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10589 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751318AbeBLRCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:02:01 -0500
Subject: Re: [kmemleak] unreferenced object 0xcd9c1a80 (size 192):
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC: Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CA+7wUsyxpHnq_POujjwEVXhJjE5GRLN9GypV+63g1OFmfq=_ZA@mail.gmail.com>
 <CAADnVQJnobUCg4ZEkHUgAAMXiw5w1K1DLqo09005mPPgOuLD+g@mail.gmail.com>
 <CA+7wUswo-XwiMEcSTnB3HQE6qo2YUJxeSNije3KtFoy6CqzQoQ@mail.gmail.com>
 <3fa5958d-c14e-56bd-de49-84fc43db4b32@fb.com>
 <609d04c4-f947-ede5-3c4f-28eaf0b14745@iogearbox.net>
 <20180212155556.5glgl6qorvuwvubs@ast-mbp.dhcp.thefacebook.com>
From: Yonghong Song <yhs@fb.com>
Message-ID: <60461de5-e0d4-9186-4345-2e03b6501c26@fb.com>
Date: Mon, 12 Feb 2018 09:00:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180212155556.5glgl6qorvuwvubs@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:200::7:3305]
X-ClientProxiedBy: MWHPR1201CA0013.namprd12.prod.outlook.com (10.174.253.23)
 To DM5PR15MB1833.namprd15.prod.outlook.com (10.174.247.10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5554bc5e-652c-451c-8c6b-08d5723a22a0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1833;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1833;3:KokDqj1JFTlba2/OB0Su3029GfgzgXY1lMFPKDtDxA49wdfvJFuA7BAI8SBWqbmEvJAe8dxAM2uNoPrFrRhdkop7SEFRgvcfZ2EIn+kXCXjr1HNFB3Acdpf8NMOzQ937IduuymzNcR+LUT/n8KXFnHNCANPv84wT636vXJPIPESTNVUeyphhf/MFra8M0Nd3aM0NMkUXzZ5YA3TyobcKvTnr20/bCrD44JnMP2kIdn5NTsFpq5en/iGHnY75byQl;25:XdlQY0PKB1NgM4/VVdHmE8UOd/a/4PIAWl582ZvC9aBdQCKklhXRYSKNqDzjjj9Km1olWKU3pGGY/qmUGF7A+DNMOHOhdOx6qWaxqz3QVeHFXZK8rlYgFf6hJhQlexfJ1aP1fdG+mTVbVHU4wSprLzDIDK2+e+XvYoLVz/MNdcpUkojYYyUmfwyOZ5MUCsO0uC2xQtwPyac/SbGgIDnmRkcsbbZ2jlkMR4sQIhkzmkoMRak5ZuSyrCNtDLT2UFXFvK+9XV1THTqoPFPo0+KLI6Ca6ZFONyhcgzXolxrlSUZxTuc4HwFNphNkLHL9SOqy+ERzLwXD4plh9XYP5j3ENQ==;31:FqG/dSNO2EG6rHPmmivfWgBc3qUsQiqHLv07jRr6vn3EbqmBUJ6kLdxbiyVFon6FNFCJjPBtmjgKBXYaNUuV4p+/lq2MIHblXWLTuFmDdIxMoQGiUrefbfv0uXLegv7QKPlVixFwxMO/RObzWuCX3KX7DAKdOJbC1TdFlNx5sOBwYbbddKiUr2uumh01LwpPKw14IKTnpRb+Nm2WHlNp/VF/ldgI7CLMChm/KbIrGEc=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1833:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1833;20:w/FzJsAzS8/2H0xU/M+fVOmmIrc5SLUlCTb6bAY2tlr7O0pN32Js+QIQWc5JJ/zisNM++JEvOH1uUxCpS5YDG3UJFMqi0p8X+N2jefmzPfdUEEeBNvUSDFsn3ibUMT90ywphcDxex/0VhOf7cfGCQzAG+HpWUHWgoG2bsPc2qoyu1lhZvFzjDXP4uyWrCxf3SFQSn9QzK0a44cUUg8XxRml7ry7Afz/6moIkYbpOLehSs1PNAyzFCFfGq9ZZcGmAwDGA+F0o/mOekinqLsC3INM7k+SW5L/sN2guIwV0dROVFi48KV5BANfkKbURoXuteJIPngJEk3CFyg+FdhBJ2q7+3IbRuC99CgQsEjNXwTA3AmLdByfMgbe//iC/NZ4erv8BnNRpExejudtJhqH1rjfND+BmYqkYLNhGljzRyBcoK1SmLXGexsGh+K4j+BVB+WX8ptIy9PXw/ea7cEzJ9quQycjSeT2DNcDqfkL5rUiWvgN93swNe3r0x0nVJYvC;4:KZOGf/gVsjHiE0SUaLZ0mLn4EbYJ6tXdXvR9OYqXfAeuUOO8PIfP1Nhl7VgdV0ePo0xZhQ4oOnZ9V67MrdJ4HX0afnZmRumhp3X9m3pTQBJTQJzJioBvJSq/GXJxkuT93U1MGV5vySF41Ue51qrgMHGZ68gUubvihPTdJ8JR5DdPuP7lrwrdjRXi1D4ecyU39JNm1XrmWmzYYFrqIQ6kGdnvpImBz+jpCkOUMDnSf2sweesBjyp7gH2T3f8O1/DqoLd/LP5IksiYLGaPW92iF253Kok1OE7P6tcQpVrH4RpTAg2YKNIyNY+yTjYL9hgUHqQxrFxPC2MZppyo9xZqD7Psiv+xlIA+u2s4pi9jTQ0=
X-Microsoft-Antispam-PRVS: <DM5PR15MB18330720CDCD88B55B2714E8D3F70@DM5PR15MB1833.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(11241501184)(944501161)(3002001)(10201501046)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR15MB1833;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1833;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(346002)(376002)(39380400002)(199004)(189003)(81166006)(23676004)(36756003)(86362001)(106356001)(6116002)(47776003)(31696002)(97736004)(105586002)(64126003)(8676002)(68736007)(50466002)(65806001)(8936002)(52146003)(65956001)(6246003)(31686004)(52116002)(81156014)(2486003)(478600001)(76176011)(52396003)(2950100002)(386003)(65826007)(6506007)(186003)(5660300001)(58126008)(16526019)(59450400001)(54906003)(7736002)(305945005)(53546011)(4326008)(53936002)(83506002)(229853002)(6486002)(39060400002)(6512007)(67846002)(2870700001)(2906002)(6666003)(93886005)(316002)(110136005)(25786009)(42262002)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1833;H:MacBook-Pro-52.local;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjE1TUIxODMzOzIzOmdCNlFoOHBuakRncm9zdjBSZ0FoSXRHQjg5?=
 =?utf-8?B?ZHc0YjJDRDFxOFpMM2dMTGJid0pmUHRNZE5GWjByQXRGU09QQ2d3M1VuVjhV?=
 =?utf-8?B?UGQ3c2pzNFR2MFYwandoSkVrck5TNTNSSUpmQjhrS2FvVVhvRjFqM1pmRSs0?=
 =?utf-8?B?UUtjTDg0bVExZUpVQ0E2NEIvSEtqUE14SFdIWVVVeHhiTUMrR3poQVlLcWpV?=
 =?utf-8?B?WmhBVkpnU3JSblJVVFhZUnovNmJpbVBha0ZTYS9rajQvZ09UcmVqdVNYTFFQ?=
 =?utf-8?B?TWhVdVdhT2QzaDZNWCtMY29PaUtiYmRTYWMwOVNDSzNEeVZXa0VBeWt6K3lS?=
 =?utf-8?B?eVhneEdvTDFsak9JNGxwd010U0t2TkVBL2MwOHgvMVgyOWVWWmJoWmphMHht?=
 =?utf-8?B?R0QvdEtLZTg2MWJCWU9RYWxpaUxGby91MzdVak5oTXBOSkhpbVVrWjRBRW9R?=
 =?utf-8?B?b09SNkhJQUF5aEJUZG1Fd0h3aTEvSXk4TFNqbDRlZzFxUnpPc3hPdkdHZUVo?=
 =?utf-8?B?SUx2L1B4T2E2RjFCL2ZPOW9zSzR0dlI4VmRqdXBnVHBqaUhRcEhjK2gxSzVC?=
 =?utf-8?B?U2dEN0NieVlZOC95RFpQOG8vVEszQmNSVG80ZUIwK096NElpVm04VXNKM2cy?=
 =?utf-8?B?ZGpXOXlVMC81M3htcVV0aWFudWIwMUh2MWM2RTVoRlQ3K3dDY2FOaTRTNGI0?=
 =?utf-8?B?eTdGcTNpQlZrQm96QmRZS2w5WHpRTFQ3WHczSjd3MGJPMnNHL0tLckFwYjl2?=
 =?utf-8?B?MjhGWSthKzJLdkJ0N2NwcG1IMnNqb0RwNEtoQWpoY092UU5hWnNVczVGVGVm?=
 =?utf-8?B?bHVWUUZGTDN3UkljVkd0akY4NnNpZGZLRTE0WnFNVkJsdDJNTjdjVlhOblE2?=
 =?utf-8?B?dENJai90aGJqU0x1c002L3kzWVVEdnVjUVhPS3NFTDZBY01YT1dkdW01aEw2?=
 =?utf-8?B?NzVFMFB5VFluK3F0elJjQy9WaVlNUTQzNHo3bU9jbEpnUlBUMURZOGhoRFV1?=
 =?utf-8?B?ZE15V1F6NUZhMHNBYVEvRU01TklZU1pvOTVQMHJQQWlDdXlFZk10Rnc4RVBD?=
 =?utf-8?B?OFc4NUZpS2VrQkpmNkxQeFY0cnRRWlg2V3dzY1dSK3hOUWczNUJ2Um1EckhR?=
 =?utf-8?B?ZzFPYUpJZ01CRkkrNlJsL1VoL09aVEJwNm9nZXhRbWpmOFE4djRZVjY1UHRw?=
 =?utf-8?B?OEVaOEFxTmN5MS9HZUY3eFRTMUV5blhoRmFUTGo0R3lqaXJZTkRDNFlqdGFu?=
 =?utf-8?B?TWdQYmdCakpRVUZJZVBudDFkMm83d0djeXk3ZDErQTkzNkJzdEJ4UkpIQjVv?=
 =?utf-8?B?NDVCbThBWUsrd21iSFdlaVRVVjA2b2c3TzBlSVVuY2xBUVZvdzFZWVQxa1cw?=
 =?utf-8?B?NmdLUDExSmVhbkNYc0tUUnE1WFVjbUwzclR6d2U5U3lQSHJIdTN2Z3RHYjky?=
 =?utf-8?B?UGRlRjl6NzNGWm9RTDhlT2NPZ3dvRDl6ZmhLYU1sM1drQmNOVkN4Nyt1WGtl?=
 =?utf-8?B?UmFCaFdPUzk0TkxWYWN0VFpRQWZhanRIeEl3TzdpaGg1UnpzM2hPZDFRRGtL?=
 =?utf-8?B?cnIwelJ0d1c4UXhuV21zbGZuTlZmblRMMTVQU1lFdWdBRjU5WVY4bDJMeVJB?=
 =?utf-8?B?VHNuMmxYaEV1cGRJbytZb2JUT01DKzhlM1dyQUlyL0wwRFl0QXZ3TGYyblJJ?=
 =?utf-8?B?eUNOVW9xZjlyRnpMZ1lJM05rL29OaWxWaHFpaUxTOUFzQ0dIV04vM0xwY1JK?=
 =?utf-8?B?NkN1QWtzQmFOS3ZheWpwNzBxSnNYMDQ0RHBKOWdYY2NPZFhkK2RaNSt0M1Nm?=
 =?utf-8?B?Tk00WFBDZktyOWhTRnlCbllEZGF2SjB2T2N3eHZsbHBFVkE4djVhak8zeHRR?=
 =?utf-8?B?ekwxb2cxVEh4SEZDVHhWckhjOGJpTFo3N2U2RVNReXhDUnlRajF6U09VU1pQ?=
 =?utf-8?B?enRGVUZtb2tyYjB6VUFXSmpBcTF4Um5aSENRS0E1L040VkM2YjZuemZ2dnk2?=
 =?utf-8?Q?egpKDx?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1833;6:RmwyEsb6bvfqFgeEIiMptxpmo2vrl/G7tM27bGZZ4UEKdWCk7R2yRLNQTs/T2cmrSECfL2yE/8IAOknb2ISFIAMu3RPXvmJs34MajJ6xjoobD4fM5WJT+UQRMb8shd76eAeOKytahQKk6yHW/f/h/EU7B5CRuZYavvli6VlljD3Uf82R/HONVkKS8VwiM2Jttdskac7azRmpJjOOYXrfvw0E68Kw9Kdj3jQCUH9RlUw52oUpFvTXpLC4FOJQQe0THXKq6IkLgSt4r66UU2YqV1EIMzlTMnpGgHDEU6y/NvnoME0A9+/XbcxRq8cpKf4Jkdm3VvPLjKkE+ykC77yzndGz1q6k8aqcEUXCKV0de80=;5:Vdg3X9LWfjdD15squ2RtGpFuYQXYmIOHIyxUtVulADQEiZvp6wAhOlGi5V8Bk3G4cJB82p6ptx3/REcw2c9nrfA34neRNM8/AM2GuLP1c2sEhcGelH0KcGOr/Nqfu+OSoH0qN1dZjQyTaMkUd+1bB353fqYz8TTi2rklELeaO1I=;24:m1fykMEYYWt58S7U1poBVuaCoD2dLSRWsH93fCtfW2hL6Zp2JGJr5lqG0MK/0lOymleHX5vLpUj2y64b9fHGiAtUGGL73GTotIuKqnrJ1yQ=;7:bUM/4dazMDe038VcQiavUhcBCf2C0D0MJJa9ap6xINeg/HmYTZZeMoMjQc+7jUWEBc5l2RE75CZsTU0WCfOhZTnJQeCj/eEQt49oaJXEqb+uyjpoOj8cbJEWoBxLIbSOHOnROiG6PLR2fRLo1QtWL+sW2unyTu4iqpxkz5BAIAcR4nKcnBYQP8ASQwrWTr4yR3f8R0rPceyXCNJVMQIY02Ky7Z6OLXbRsJ3XozkmQg/aEwEOpH6w/k/lhJaadj7e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1833;20:2qptxXoNhyi19Odl5bpgRQSm7O13yuH8VFD/7jsyy/S1LOqzGMLq6FoDWD2pQcty0co1ddAVdkjNaQe7nRUhNcBO5f18081O63GNCnoVdJHwaKIXXtz21E9MI0+E3dY/aBc+k+7lwGZBbgYFCJo4cqLFVxFrJO43vu1WzE06DqQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 17:00:35.1628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5554bc5e-652c-451c-8c6b-08d5723a22a0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1833
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/18 7:55 AM, Alexei Starovoitov wrote:
> On Mon, Feb 12, 2018 at 09:28:33AM +0100, Daniel Borkmann wrote:
>> On 02/12/2018 06:47 AM, Yonghong Song wrote:
>>> On 2/11/18 11:18 AM, Mathieu Malaterre wrote:
>>>> On Sun, Feb 11, 2018 at 5:54 PM, Alexei Starovoitov
>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>> On Sun, Feb 11, 2018 at 7:24 AM, Mathieu Malaterre <malat@debian.org> wrote:
>>>>>> Alexei,
>>>>>>
>>>>>> Could you please comment on why I am seeing those memleaks being
>>>>>> reported on my ppc32 system ? Should they be marked as false positive
>>>>>> ?
>>>>>>
>>>>>> System is Mac Mini G4, git/master (4.15.0+), ppc.
>>>>>>
>>>>>> Thanks for your time
>>>>>>
>>>>>> $ dmesg
>>>>>> ...
>>>>>> [ 1281.504173] kmemleak: 36 new suspected memory leaks (see
>>>>>> /sys/kernel/debug/kmemleak)
>>>>>>
>>>>>> Where:
>>>>>>
>>>>>> # cat /sys/kernel/debug/kmemleak
>>>>>> unreferenced object 0xdee25000 (size 192):
>>>>>>     comm "systemd", pid 1, jiffies 4294894348 (age 1438.580s)
>>>>>>     hex dump (first 32 bytes):
>>>>>>       c0 56 2f 88 00 00 00 00 00 00 00 0b 00 00 00 0c  .V/.............
>>>>>>       00 00 00 08 00 00 00 01 00 00 00 01 00 00 00 01  ................
>>>>>>     backtrace:
>>>>>>       [<6c69baf5>] trie_alloc+0xb0/0x150
>>>>>>       [<fa093284>] SyS_bpf+0x288/0x1458
>>>>>>       [<82182f53>] ret_from_syscall+0x0/0x38
>>>>>> unreferenced object 0xdee25900 (size 192):
>>>>>>     comm "systemd", pid 1, jiffies 4294894540 (age 1437.812s)
>>>>>>     hex dump (first 32 bytes):
>>>>>>       c0 56 2f 88 00 00 00 00 00 00 00 0b 00 00 00 08  .V/.............
>>>>>>       00 00 00 08 00 00 00 01 00 00 00 01 00 00 00 01  ................
>>>>>>     backtrace:
>>>>>>       [<6c69baf5>] trie_alloc+0xb0/0x150
>>>>>>       [<fa093284>] SyS_bpf+0x288/0x1458
>>>>>>       [<82182f53>] ret_from_syscall+0x0/0x38
>>>>>
>>>>> hmm. looks real. Is there a reproducer?
>>>>> Yonghong, lpm map not cleaning after itself?
>>>>
>>>> Not really. I simply boot up my machine and wait for the first kmemleak scan.
>>>
>>> I am not able to reproduce the issue. Tried with latest net-next on FC26 with kmemleak on. I only got this one after bootup,
>>> 'cat /sys/kernel/debug/kmemleak' or
>>> 'echo scan > /sys/kernel/debug/kmemleak
>>>   cat /sys/kernel/debug/kmemleak':
>>>
>>> unreferenced object 0xffff99701a7386e0 (size 32):
>>>    comm "mount", pid 1856, jiffies 4294669263 (age 98.440s)
>>>    hex dump (first 32 bytes):
>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>    backtrace:
>>>      [<000000004668ec00>] security_sb_parse_opts_str+0x36/0x50
>>>      [<00000000a9807d2b>] parse_security_options+0x3d/0x60
>>>      [<00000000cc1e1d58>] btrfs_mount_root+0x139/0x720
>>>      [<00000000bdc4f1a3>] mount_fs+0x30/0x150
>>>      [<00000000f189f1bd>] vfs_kern_mount.part.26+0x54/0x100
>>>      [<0000000093ae5db7>] btrfs_mount+0x184/0x914
>>>      [<00000000bdc4f1a3>] mount_fs+0x30/0x150
>>>      [<00000000f189f1bd>] vfs_kern_mount.part.26+0x54/0x100
>>>      [<000000003b67b9fc>] do_mount+0x5b9/0xc70
>>>      [<00000000de4073a0>] SyS_mount+0x80/0xd0
>>>      [<00000000fc5a968a>] do_syscall_64+0x5d/0x110
>>>      [<000000003d61f5fc>] entry_SYSCALL_64_after_hwframe+0x21/0x86
>>>      [<00000000458a6ffa>] 0xffffffffffffffff
>>>
>>> Not sure whether the above is a true issue or not.
>>>
>>> However, by inspecting the code, I do find the trie_free in lpm_trie.c
>>> may have missed freeing the trie memory.
>>>
>>> The change likes below should work:
>>> -bash-4.2$ git diff
>>> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
>>> index 7b469d1..cecb259 100644
>>> --- a/kernel/bpf/lpm_trie.c
>>> +++ b/kernel/bpf/lpm_trie.c
>>> @@ -589,6 +589,7 @@ static void trie_free(struct bpf_map *map)
>>>
>>>   unlock:
>>>          raw_spin_unlock(&trie->lock);
>>> +       kfree(trie);
> 
> also looks like trie_free() is missing
> synchronize_rcu() + rcu_barrier()
> it doesn't wait for parallel lookup/update/delete to complete
> before freeing the elements.

Thanks, Alexei. I will address this in the patch as well.
