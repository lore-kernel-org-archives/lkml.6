Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeCZXdw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 19:33:52 -0400
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:34449
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751115AbeCZXdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 19:33:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v3 0/5] Add debugfs info for the AMD IOMMU
To: Joerg Roedel <joro@8bytes.org>, Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
 <20180315135838.GB5259@8bytes.org>
From: Gary R Hook <ghook@amd.com>
Message-ID: <29b998bf-c942-39e3-0e78-f1505492ac4b@amd.com>
Date: Mon, 26 Mar 2018 18:33:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315135838.GB5259@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR1701CA0007.namprd17.prod.outlook.com
 (2603:10b6:301:14::17) To CY1PR12MB0698.namprd12.prod.outlook.com
 (2a01:111:e400:c43b::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ce765c2-6799-4b71-0d2d-08d5937205a7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0698;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;3:xPZGhJ7PN5biGgiw2+oJvYy72o+f9/fC6GPC2g0l6/F8HbDi7tGl094kIZ1B8OCd0nAMPxI6vwm5+XhPrOKkwO7PHJWP3dSKJwmxCezrqm3mlB3rvmuSrvVEcKo20SqUnrWXFI7ZYELx9CeBEIKwekbEa7bjMIdGchjW7onBw2iXOXL1ZA+Enq5Iv49i/CZCVn71St2qs44dCdnU3osPOZLF8COC8EUUtxDjrID+2uVldI3KQ8Pj5NtCXdPprnTl;25:0WaWGjLBZa06HtyqLJ4YMsUTqX4NRZ+nVxgNEy9gpnDpM/bhWpNr5XQG3hZSQjzpb6HjPC+468u2mzBGne8ifFgtcxAirES9gCCUb1PGy2wd7/lBpvncMHaaFkhEnJ6xBU0HnrPkG7JzR1fbaGtQHYHqGNdzAbbGN3pTO32bJ+1vef8/3q9Fb2S+7LD6SqLykDI9a6qQ+w7DZhb8e2nC9IW79ZRUC0Ab7/5wG9MnRYkMd5PK98tm64ag3X/kW6lCgaEzepA3rrsnEAGpwbkzxlMrOHx55XrjM2hsrYb3PxUrKownfk33udZv0RPkOYtnj2+hKlqPDpJsvVCRw5vI+Fkuw3Hpr9XYwSQfYvYFhjs=;31:yEvXq3E+m6geUlAo1LoVrBAW1b64UI1t+GlTRMuapagtD+uNZSgeSyDLgbJJ1x5CEPVCsaU7bo2wgUmsxf4vOCAgypfDwXGK6MIxPhANNJ73KhZjwNqObV1Tx4zDb9bZ9urqHfew+Yo+XTmbCM306Yqw5scjjiZM05wBsODF53QhqTjDhJEzmnJV9eVNL9Jef+UFCHk/us8dntKKdxTEZQrjJZPV8v2iihl+iFQbmDw=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0698:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;20:Z2qkGGw9oPS+BO7wc8swfnsdRSSCCaGPS6O/u/jon3v7TyZTNi9YPahwECRiqEUzOz15EhBqvfujWSIAJ8IA2Iktzv14wXSHDc7fpuB8lnl3CC/28fU0MiaF2pV1TnFdRivWPwCpoZGn5orFeX79U2g6o2GIEvxeVJeqbOasn/dK6tIymrg8AhPR1osjtmOMuLMFAP/aeBHGHlbBMMoHJ7Nvl1Gz5uUhIs9FHFxc6ps2GBSZAGBM0USbsvj6ian4+Q1PjSuTsGX0Pl8XR9/bMZNzS3GxIVRLblxSpY7I08xXK9c9nlW+57SqmSSjKMMgo4rMbp+Kb/KAlT2xXLU7atRjT8EXvRMSe0oBYaSIyQWWkoBVz4UkvqImIHGundNXqX50xHQw6Clu4akMBjAM8wUPrhHCKiqOSLUKzvk4TCk0HmTqOnqydk7R14GaglXnwI+2FBRf43ghdkpIjktxsk+JpEmmxSRYJZfUlr4XrlGA+Hjy3cnM4ekHioy0HPCQ;4:zFilhHEHkyCaLy4WnbEogIugINJsgiLnata/4Sx/O6Tz0VDWcBGUtZWFSsD7tY3Jr4T1sA7PmNhlbMnRZdf7WdjidtvGubOXRT2OSfqWDANC4Bd2Xe7HX/au5DEULMfk16VVJJRNqR9CPF2aj6fLe43A3AxdZrfCQ9kiJWkk/ltEb4CbbI8EBth08pW3eo5efogYUK8a2MYuHFZPYJbZAmB4SuX5gHdkNxz5m/oKKlBCpJixieEo2uhb62IKSbukIZBMXJqnrPiNgpqzdDmAYP70JVoQG9wsm5c31p4mz28ckVZQq6N1s5sRStjfQs0d
X-Microsoft-Antispam-PRVS: <CY1PR12MB0698DBBFF36D912CA44502CDFDAD0@CY1PR12MB0698.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY1PR12MB0698;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0698;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(346002)(39380400002)(376002)(366004)(199004)(189003)(229853002)(8676002)(8936002)(97736004)(106356001)(64126003)(16576012)(316002)(50466002)(81166006)(31696002)(486005)(486005)(58126008)(3846002)(110136005)(6116002)(2906002)(81156014)(31686004)(105586002)(47776003)(11346002)(25786009)(67846002)(2616005)(52146003)(446003)(23676004)(2486003)(68736007)(956004)(478600001)(52116002)(4326008)(76176011)(77096007)(72206003)(36756003)(6246003)(386003)(65956001)(66066001)(65806001)(53546011)(65826007)(59450400001)(6666003)(6636002)(186003)(7736002)(305945005)(53936002)(16526019)(5660300001)(230700001)(6486002)(26005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0698;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwNjk4OzIzOkwzWXNhekRXRUgvRlAzazZHbFdKdmVkVzJx?=
 =?utf-8?B?bnkyY0I3Vi9vUHJzT2gxVUo1QjBhZXhGcDVIM1NnY3RITmhtWUNNbzNEazZJ?=
 =?utf-8?B?MnlBNCtFeU1RWVlFWmFxcHhXRk5WQmpkOHdRRUwwT2dhN1dPZWpjY2ZBa0JQ?=
 =?utf-8?B?T21BVDNnOHBvM3JNNndSNVdEZlBnVzRsYmJzdmtLQTNTUStibk84V01qbWZ6?=
 =?utf-8?B?K0JJcis5Q29yUjNUdTVDeHhuV2ZReUhia0ZYZUJ4aXIxSTV6YUxlUDdZRGpT?=
 =?utf-8?B?RXJvcFFhOWFyWWRyMm5pR0NpT0gveDdBSCsxdVp5NGJoOWNKRGcyVmVrTExP?=
 =?utf-8?B?bTQ4Q0xhQm9JMEFmVlFuaGZXQVNTQ1Q1RVVyaVRHVHUybGpHYWdIVHlRS0Vh?=
 =?utf-8?B?YUJEdUtOWXRuM2RWNkVGd3p1aTNIS21IMGl5Y2NIK0NJN1NGK3JuczlqVk1k?=
 =?utf-8?B?T0lQSnpFckRXOGNpbVk3SytSOHJRbDNjeFBCQWRScnBZaUlveVNJUFNkSXRZ?=
 =?utf-8?B?bG1oQ0V1UWJNRHlpcHkraEh3dzcxODY3NjRNVXpQVTh1a3dUTnpJeXBjeFNq?=
 =?utf-8?B?R21KZ2JjMnNrM3ZzOG1GVlRPUzhiNXVYL3pDL3o5VGhjeGMzRFJLbFhGbVVS?=
 =?utf-8?B?ZGY3dWNWZitqUGpRZ0xwT2RyWThRcWNMK0hWbUxsRW95UkZ1Y285Q2RsZEJR?=
 =?utf-8?B?MVVFTENMRXJUVVMrV21zMzNDVHU2Wk5KMENQWUdzTzVVUHd6WUZFODRGa2Er?=
 =?utf-8?B?bDdUbnp3OGVVRTVIQU1XT2RDblhCZEdvaWtBeVh1cjJqdk1UVHRPNEJ3VGIy?=
 =?utf-8?B?WmhnRDFXQkwxenZYa21HQTcvckJ1TTRFaTljRFE2TGg2M1YzazlwSlR5MS9x?=
 =?utf-8?B?MG9URmxtS2FXUEc1bmZLNVFUUE96T3NSYjVWTkJaZTA0bUJyc2huYThiUXh5?=
 =?utf-8?B?M1orQkxIbVV5TC93bDlWcSsxWUZwZFRqN0IraHZhMzJlODVTa253Q2QvWmxs?=
 =?utf-8?B?OGs0RVJ4bUdYSithNEFOdDdZTHAyYzZqVXA5TDlzMDExeEtwV1ZianFLaW1p?=
 =?utf-8?B?Q3NOdmZrQW9KUVBqSUhLbmo1NytCdXRFYTZKVHVTc0V3MkhQWUh1bG1CTmNh?=
 =?utf-8?B?M2FhL3NQQ1VTYlArQUpiZHdXdWpLd0Vjem10eCs1Mm1QVnFld3pOVzJ6cDlI?=
 =?utf-8?B?emNjMzdlemJ0YVo3dzVMdU5TZDIwK0xTNHphR1c4MW1qQmp6SCs1c1VtSGdn?=
 =?utf-8?B?d1Qxa3ZRSkVBWEpUNmg3ZmF3L0x4ekxaV1hDTFBFb284cjBabU11Y1ZtWmFD?=
 =?utf-8?B?Q29pWEg0b09nUmhBeTRWYVJESXkyaFVtZm0vV0V6UjJzaXJobjZBWS9ycUNl?=
 =?utf-8?B?dnFHUk8wWmYzNitldlVubFBoL1Rpc01sbFYvVVhJeWIrcmVPblZmNjZCY2JQ?=
 =?utf-8?B?UjI1Ti9NeW0vN0d0VGt6Z0JMVnFuN200YXhab3N5M01FRitqcTVrSzczOVhk?=
 =?utf-8?B?VUZtZEMzaUFmWnowRUZFMHJiajg0Y3Znb0RlOHZWaUNqdWJFeVlnZWRyVzhn?=
 =?utf-8?B?YXpWOFRkQlNMZWtkR2NUeklqMEh0Skp0cEV6eDloSjk3eFE2cExERXZPSUhL?=
 =?utf-8?B?K0gzZTM5dU1uSVIzNHFka2gyd0FGQnR0NE5NT0tPbVhTVE1xdjBQS3BFbVVt?=
 =?utf-8?B?cGE1bFhWQnpXa201SmFoWlBPZWhseHltcThiQnJVZGFiOHdaYVFqcFc0c3Iv?=
 =?utf-8?B?WDNrOUxGallKY3J6UnpydDFkNitwRFo5NlVHUVZkVG12UXFlTTZLdXN1TjNj?=
 =?utf-8?B?R3JrRGtabkNaVk5DMURZWURjY0E1dDExUk15VVh1Y3kyN01CbFJ1STUzb012?=
 =?utf-8?B?RHRtb3NEQUdhRlQxeVdNWS93R2w2K21zRytMQjNLaFYyaHpxV0s2WWdGcUV3?=
 =?utf-8?B?K3I0K0F6V000MkdQMDBKQ2R1QzZOdk9mWmtVSDhLRzJ4WTZQdmFSby9kekZV?=
 =?utf-8?B?eld6blVVRmJYSVRwUFFVT0dyRDAyS2YwaUFuaHZ2Z3pOM3NjT0ZudmtwNkZL?=
 =?utf-8?Q?LU1I=3D?=
X-Microsoft-Antispam-Message-Info: yNxI6mZynm9fvqFwGC+n+QHY/ZM7YwRPtyYzG+qU1ZqdRgf2XVNZ2j+f7F/BQT5KdebS0QpCgucbtY08wa/oVhYHVyt/r5Dq5pVzi4u8LG59mjozBxRBrmoJk1W2oig0kRttp/RMLpk/dam0eLnLTX1o6Kl4TcfY97LulSIXO2vqudl9HR8W1/xJcOG92UXF
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;6:7KmsAXi4ovtLWCQOY8oLhh/8+XY19un0d2V/TpuN4cuwlyEO84eyufBfGTPpfNKe7MzKuXAOESP76F1y2HidWDn0WztIiWbjrpT0B/rkpDh53dU/WEKweDDm9zij+Ohb1QFg+vLQpI/wJEb/YMbsutmzvJTmodj5CFnXvqTFbKFCYGGa9ov0hLIJVIYOasIlp9Ynsk3jci7Ita1MV1+K3l0mNE22aRacbPme9CgVY3utRYKMYrzFVeVeShzM6Ojvqpx6THzWAoDWQxNeMkgzoqva/WiBcHF8HXFso9OM25Lexsb1Kd9nyc4JxnwQAwEPTSq4ezFfOngFaCVFdo5kHt1ZzoOzXL1Mc+G3nfipIqwmte0GKeaKr5DZpY4IXefIdfYGMVDk47WAdWjiOZ35EuE5ZdjisD1qcSsZgCfESbgVtLUvs0NxFjVPivSoBv1UOCUpYlYgkEIPMwACCkxmyw==;5:Vr4o86AZRrkYI9QwsNyHpGtWOe0DGLVtUcx8Hq8QzlAXMU9A1sUa7fsmWrdWpBPx2tqpzK3bpVxSLhu8VU3n1vv8rLhMAvkYkUlSzLtizrWdv9RMmqzWAfGnVI9Osy3AHDgICcN4e+aGT19JhUMiil5/EHoEFOVseQvr0ni3Gi4=;24:E0/01ZC1CWDlCFK6FH5MXEMdoMptAmf4KV0pyniISAi3r1h5MQjRsMqu6dILTq7O9UT8XhRF8de3JRhBp8Fsm8psU936YSb6z6MfKOvJKA8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;7:ToCVVI6AhyJIiOzSq8/vxJS2IFpBQ0L118QFguA7rpPOlFz2DIlMwQkYdL4yjqGMYn+yKjvSCD42mjHm6SPpFQnRpP6pOZMNAahnRnWiXVPi9+zzNAaSe0Yc5TllvSS2WaH26rE4+8jIHA+vF8ZZvjLbj1JOiKYWbjjZ9bb1A+qPTmvRPKK3LCVsdr4dosgbAtNZXjmWrpGHINoawL5eme2jHKSXghEMcEk69PWrRP2UmHx5wqbNe6gU+DnmYbCS;20:5Ulin6tDlzJWGNEhzTtjcNJguGhjM88gdpZ1o/8CFB3ODyhIMcWZI7YDH+ekPojDbkr/y4Uwqbwiybz+ty3NAK2KcEIQWM2+ru0RD1JufeJjmrFZvN1jWTx8xTCxqCg49uBePbreoguimAqQ64pPGohwXjOdKStrtHBc6FZZzf/fdTzsehydw7YnaWZtnYg/iW9mERdEJoYCLslyJb/YiSz78LMnz+6BKgajvoZx9fYOtNCaqCcijAPPKjfJpKzT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 23:33:46.7869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce765c2-6799-4b71-0d2d-08d5937205a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0698
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 08:58 AM, Joerg Roedel wrote:
> On Wed, Mar 14, 2018 at 06:04:44PM -0500, Gary R Hook wrote:
>> Gary R Hook (5):
>>        iommu/amd - Add debugfs support
>>        iommu/amd - Add a 'verbose' switch for IOMMU debugfs
>>        iommu/amd - Add a README variable for the IOMMU debugfs
>>        iommu/amd - Expose the active IOMMU device table entries
>>        iommu/amd - Add a debugfs entry to specify a IOMMU device table entry
> 
> Same problem here as with the Intel patches, I don't think it's a good
> idea to reveal internal iommu data structures to user-space in this way.

I'm afraid I'm not following the line of thought here. AFAIK, if we 
restrict access of any debugfs info to root, then only root can see any 
of that information. If root is compromised, the whole system is 
compromised. Which seems to me to make all of debugfs suspect from a 
security perspective. Therefore, I'm likely not understanding the 
security concerns as they relate specifically to the IOMMU.

As for stability, you mention on the Intel IOMMU thread issues 
surrounding kABI, which I appreciate. But I'm exposing well-documented 
device structures in my patches, not kernel structures. There's nothing 
there that is going to change underneath me without my knowledge, if 
ever (I vote for never). And I'm likely ignorant about policy nuances 
surrounding the kernel ABI.

> I've debugged iommu issues for around 10 years now and never had the
> need for an interface that reveals those internals. How exactly are you
> planning to use this information?

Well, I've already had to dig into the DTEs and page tables for a couple 
of reasons (both debug and development), and it made life easier (for 
me) to make the live data available this way. Then I thought that others 
might be interested as well. Admittedly, I could be wrong.

Finally, I'm no guru, and likely am unaware of other techniques in which 
I should develop skills. I'm always open to input.
