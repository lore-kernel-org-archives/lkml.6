Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755452AbeEHUHS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 16:07:18 -0400
Received: from mail-sn1nam01on0071.outbound.protection.outlook.com ([104.47.32.71]:43391
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751464AbeEHUHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 16:07:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v5 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
To: Joe Perches <joe@perches.com>, "Hook, Gary" <ghook@amd.com>,
        kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
References: <152572332370.3235.16541462864315443906.stgit@sosxen2.amd.com>
 <201805080700.Jm8moLQz%fengguang.wu@intel.com>
 <a9600652-f087-5d8f-ff0b-80200d570591@amd.com>
 <e671945494d54cdcf65c6d2af9f9f69d65fb2583.camel@perches.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <239fdd0c-9497-7275-4e74-d6ccd028e823@amd.com>
Date: Tue, 8 May 2018 15:07:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e671945494d54cdcf65c6d2af9f9f69d65fb2583.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM6PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:5:80::40) To CY4PR12MB1445.namprd12.prod.outlook.com
 (2603:10b6:910:f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1445;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;3:3HtgQJx0PyKG1i/caZXYSlOrDlH9CiVgmOvURrcYnIuwR+39DrKL4X9BYxbRVK3tKFwL/EuKoJAhnYzqVL1z+dDeUHs59P/vTiXq9QOqViBa+TXrMzCKViXudn68iyvZ+8mOgvSh2FrHf1Xn3i9VeZK2I1KqzxHaFBJz2xomlEgpMOWqPK0KSC6lGmgMEvKwSfZZffItLCQ9lKZ2PpAhdpx1e2jSXBiZWCWvDuafcwKM9ayrQBMl4BM01RaGGhFO;25:PcV4Ysnjm9l5l2d8lcOY7YXguuAU/SSAH8nDpA/dvTVZPSIg8tjS9kQjnMPiWvk2bpnjuGk9feDucQJA2kJRg7gnHTowdvKtEEhKulzJc0KJJzPHRejkV39vCjaNFwQkloil4EzKUgF7P4HLELH/UN37pfBlkzwNcv08xc1C2dpF/dkdD72RIUQO2jNIp0R0ZDILNaNzMg/aYQa0YH8h2p8IIGWIH2bvb/lefkknQkI39brWiIabMH51NNoymOUzE7qTF2lNZmWlwQgtStbSwh3o5R7ZXRPFsULjR2JTroGuCpsMwtsoe9nTwV2KaQhBDB4Xp1uOVOQAy3wfifq5Zw==;31:fQuet9jFx5GcgI3i4gxukw9+jG7f0Ts6qQpsDyNpXSmqXsr/TEiEj0CcGt9bLkBHMtcWdUl4LbNXaSDmCdnLqu3+EvjGF35SiKXE6LsIpPPVvkDAV3apXCMWivZnorCrQWGLnXkOsf1sR+oxCDSBvt9iHzQFiH9eLaK9p8M+VsZ14ykuty9riwGAp9AFonInOTpLYN1ZSx1ru5VhD3vqqhRk+5/WCnATAtKhs3j1DJU=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1445:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;20:80WH45K7WCfOT5GlT7XYOIld4XFXAXqLyD+cnv+Hj5qk5+GzHpZnU0FdXeRJqoPriI30ueAT9orkvxNTyTpWI5ta1upftTEfSpnGqJ745+Zv/x4Qvva90p3ZINCr67YhKmOel+fqpV6J3bRwLtCSEImH5nYGmGitOV2ZBu3CDcUldlJKakVzuN/I6FHZD7jx8+eq/ARm/e35e9iGwrrAjaWH/D/78Ykw0h6vfMmP6YzE1gJByfDMsRIbxJEHUK4O6w3JgPex4wMP9+TH/4eQWvBvyRx5V7XGV7gzckI+wl84itZ0UmFyxBcBUr+zKPK8p7VP18Etg8UhcTJMNbjA3nCCjqEh/AR0Uv2HeaZz0c9BAKpxJQGDsX9+hxMW97x5GHbSm9uorzBHAV2CoJHSN299WtcKnjhYnnj0kMxtl0UJ2hkXSvyP243gS4wOarasaYSflNrEqFXsV+tYTpO+iY6u/lJQDQ0hqO4WrNmbFUFwNFtcWbZWFxyLhk+DQvI9;4:iZduZtWon5nrinMyLy5ESKXfT3A2Da16qQWSW4yS/djfHrpEqNBajgIYpwKy3bWD1o0yr8IarIa81L4GNyWEFjTBs7v8dVe7Eq+bs6bwHw1zw3Tdlzc1k2piuT7XfNLsdx9rXQ1lwmfi3PGVfC894c+0ejpSRIdWmKua51rZl4I5p4U5MCOkoZrEGrp4hitnZarYlMO1zMRWgIaLS9H6ELx1VlEAWlkUVelZn25hinrjdK8rM+9EwJe4YjBL0BFQKuR68jmMB/Ve2ZDRxiS2xQ==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1445F74135C5389C4ABBED39FD9A0@CY4PR12MB1445.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1445;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1445;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(346002)(396003)(376002)(39380400002)(189003)(199004)(377424004)(5660300001)(31686004)(58126008)(316002)(478600001)(16576012)(2906002)(106356001)(110136005)(25786009)(105586002)(68736007)(72206003)(97736004)(93886005)(230700001)(50466002)(486006)(36756003)(6666003)(11346002)(476003)(446003)(8676002)(53936002)(65826007)(305945005)(81166006)(59450400001)(65956001)(6486002)(66066001)(52146003)(52116002)(23676004)(6116002)(16526019)(65806001)(47776003)(186003)(31696002)(3846002)(26005)(2486003)(77096007)(76176011)(86362001)(229853002)(4326008)(7736002)(956004)(67846002)(53546011)(8936002)(386003)(6246003)(2616005)(64126003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1445;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNDQ1OzIzOm9zTDA3eVM2d3dQU2JDTVJpazhUZUg5eXlC?=
 =?utf-8?B?OWVwWEgrZjAyOS9NOVo5Z01OczBsUmZqWjFXZnhUU1c2R2pqVFZXby9hUHRE?=
 =?utf-8?B?SGdJU3Nid09HZ28wTGppbS9CTjlRNEJDL1VpWUtKUmhmTDN6M1F1UzVqRk1D?=
 =?utf-8?B?YWIvOTNzTnFGYmVVZU9USEdUTjhTTXF4TFdSNXZMM0Z6ODc2bEx6dXQvbXJJ?=
 =?utf-8?B?Wm1yQkY3NStranY1WFROUWtKUmppRmM4VURSL2VTb1VicGtHWVNJRjhNTlFN?=
 =?utf-8?B?ZkRMd1h4aFVIWHRrT0ZZd0VUTUpjek1vcDJNRkZRT1hrUEJFV1RTRlQvN3d6?=
 =?utf-8?B?U3NtWEFxd2V3UGM2MlhPQUlSRXVtYjFIUFp2Tyszb0VyYk5QcWlOQ3dCSElU?=
 =?utf-8?B?V2w1MDhFV2lHMUpUR0pTOXVYV0pFYXlLWTJwcllZd2FUTnRMNjUvL2FJYUxz?=
 =?utf-8?B?VjF5RnVVcS9jUHl4M1M4Nm1Hc0JQeDNRajNxTlViZkYveVdEc3JjMXI0SkJ5?=
 =?utf-8?B?cjZOOGhnNmF1ZFA4RFBpOFlHZ1c5Q0JNRlNMbHc2TUd5M3UzelJQWDdSVWRq?=
 =?utf-8?B?RFEzRHVWZGp6UDdxL2FRV2JKSkZSYnN5M2FNWm9OS1VGeDZEOGY0ZlV4bHVp?=
 =?utf-8?B?QnhVdExJN09XbGhCbC9DSjYrNVFEOHI1VTFpa3Nlbkg5Q1ZyTXhiWm4yaDJk?=
 =?utf-8?B?UHBVR2VHRnROTTJLVDRiRjFubU9LVS9hYkx2MWljcXNmcTkyV2hZcUQ3K1Fw?=
 =?utf-8?B?MEw4M2pFb2syM1IvZWlWNzJQWVQ3OXU2blZUb01tNG4xQVRERkwyMmFuR3Zr?=
 =?utf-8?B?dmRqd0FrZkxtNU0raDNrK1RkMkNNT2x4TmNtS0E2R2UvQ3lKYW8venhNS1k2?=
 =?utf-8?B?M24rdjJpcWc1eDZudG1Qd2VHQUN6MXlCT3dqNTE0QWh4ajBsYXJxSVUyOGp0?=
 =?utf-8?B?eGNnN0U5RGVJTWZsaVZoU0tFNnpWZmZNMEZOY1NFVDdKYjRLaUEwSnh4TnBU?=
 =?utf-8?B?NlJCbTBLSEhvOHk3NytVaVBha2h2eHF0WWxPdkVvbjYyREx0YVpkYkgvT1NE?=
 =?utf-8?B?Y2prVnEzR2hLVzR3UTBVRWJCYjhDbEpnb0FBUVZmOW12TGE3RE5jeXg2V3dJ?=
 =?utf-8?B?NGlCd0JheVlHZW1sNVFXeWFISTAyOElISW9GZ3Z5VGk4YWtycW90bk54MmRR?=
 =?utf-8?B?b3dhOXhFVU5zOW43L3orRm1vSHdQRld4ZlROQUNjdHI0Q1d1dEFUN2lacXlO?=
 =?utf-8?B?WkEyRVBoR2VwNnVxbERUVkdCN3BtbVpWbGJId0JZejMyM3NYSU56SlJHSy92?=
 =?utf-8?B?UW9zWWx0TFlJZEowci9BN2dkRVpXdlFqMmVmZDRDQmx5S1owMU1yaXdVM2lw?=
 =?utf-8?B?UWhlWjBHU1MyanFvZjM5TVBFdHFKbnJCMVpSd3Rrd0NUZzR5bUh1blhCcUxP?=
 =?utf-8?B?aVZXNU5DTGlEZ1RmR1E4ZnZEYzJxdC9aaEw5NHlxSHliSlNCRUV0aWUrYmYz?=
 =?utf-8?B?RW90N3AxbUozWVgzRXpmd295aHRyWmYwdjVtMXNVMEJ6NHhMcTF1ZjBveHNK?=
 =?utf-8?B?a3htOXBzZ1VLMGdCd3FmdVcrRHI2V08vNDhmUWRtcHNGdDIzMklsb2Z0eGc5?=
 =?utf-8?B?Vk5pZGI3dDU2R1VKbUw0TGNRNGFqWFdsbG5ZV0ZidERYRGtuQThmcmlZSGtP?=
 =?utf-8?B?Tk4zbTJkbzVwNlQrYUh1YTVnS1RraENNN3ZWVFZCdkp4UHl6bUVZOTVQSzlo?=
 =?utf-8?B?SkY4MWo1RXY5Z2c4dTV2OTh6WjdSTW10ditybEYwTHBMR1JlSVMyQUVMM2pJ?=
 =?utf-8?B?TG91dG13YTNLZ2JJSS9LZlpwZEw2S3ZDZkJxYnVkaXBraHI3Mnl2SFhWeC8v?=
 =?utf-8?B?cVMxYkM4NFdCVHZhMU5aUlhrN2hrb0RVVjF1ektxbTlpbW8yb3AvVVA4eE10?=
 =?utf-8?B?TzN6VG52UnI4N0FYTXR1bzZ0c1Y5RCtrNGRCSjd0MCtOUEgvQVZGWEo0RXBv?=
 =?utf-8?B?ODQ0MnNHQ2VBdi84K0ZUZFpFbS8rZ21kdCtCNnRMV1FTMGJaeElmdnFTNnNY?=
 =?utf-8?Q?8pVFFNafFL5gxAaDQWZc9/1ve?=
X-Microsoft-Antispam-Message-Info: irvOYrgiB1IkgFjZI1JyXncUGlgO5hOb07OZIPedkgY3XSL75t10uAGgzxwPn4CIt9pGtCXdsFn1uzxRd77zpSS8+sOvQdZSrny+jVh7vzVuJ6Iz+q0s3sEl3tFIft7NaELNEt9J8LgamXOfb6KdICvYhPSgyodVHl/temZYDI/waRBPc6q33X8FwYn7+12Z
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;6:MrGgYoEERVGhf/KZeLdvpMLGLQk/LEvhPnsIHGh3ddza39ZbhckYG69JC6zNGFJaBamfGVIutHmFnEJolyBBEWqAjnmdLO5ydrYBoOAxrUI2j2A5t6ru9UrhCVp9ai2DbaQLipBup1FTQkkjnSxxCRh0PsWIAuJky8BzaVRcMrbMpCdX6tpF3cJb+E3WSlKfNrIER0WAgNkjxpEhwyZ2u5PKG+qmWUX0MFm44Dx93g/x7JUmnY1GH5cQRqWdraLZU9fwT4bQ0r5EuhJrpQ+MaVEVWct8/I1AXnA03/jJEYBzEUhskUQX6uR7jtidGyPRTLMwy4e4jwEjCvJV63nOMfUPavWSHBP8nXcys0z9iaLBVnYsNSwn3jV3YDjkcUMGa6RpbuQPEGufWfv9aEmGGPqtxi4dzRTDmwXnmtWLfoJuL1hOX+vmnkju0M9ktuMGd2mwRleM/qGdG/JJBFbo7A==;5:CL1oOXNnuB0Ly6Tt4FY8nr12b7DFcs1ltvdJ3Zj5P2hFeiy1b2Bwpmo1GTK/HJ+metLy+fnx1nWjcKHMZiYHxElaHNWp3syo+SOom++inRnAN38MdKwH8cjmeNJWo27ElgJNuPKfO0b2CxgwvMcSke9WEBQe7jg4waiQG8fkAOQ=;24:B1APNLbeqebkfEYwpBSSpGSclUiWAs6Es/04wkNnr/plESGGfOfHPzmovwMbKwsLiU6IBCt+F5bE4pdiWd2Rcl9+6oB7lzEoCMMsNdlBbZE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;7:+vhy/lz+2tqViLh38aOzkO0WQ/9cQ2CRGiRn6txV246pC24riHW1HoUS7IGyufgd9icgKLAYZbhL7QF8hUP8kb6yyNEd/Y+Zw5rruJRIL17hfGZpaDWZdpii764hGXuheywl3h+OWwue5qZtKcorQ3pd5cH6uolN64vpFE5WekK8ToVc9lYpaHYj3d7m/ibPHgzPf1UvP4HQNf2hieWmw6wnHXGhMZMb7gdI+uwn9t/kr1f5lWxb9DVqHWraYbWt;20:imQ+3py0NBOzcXbvYG2XMVFNwtRZbUs77/K7WnZF/plJoLDLuWMnXA671byIwBZ8BpdFNU63yEYhf2dGbejMYzHwcoLxPpgbUftRFwhcMC3ocAKix01YhKOi1LEpwPXDUv/c0wvfv3RiAJBEk4DET6qYzvFMJylO+BMEgA/qT4FvTDRL3ZZf6yJh3ixL+9Khv3tQlVafxW+8WL5Som9WwAjrpHgAqH3nOKzZ3yd5Tx90clHPjyYvuqFOnBdX8vYM
X-MS-Office365-Filtering-Correlation-Id: 46ddb714-d5f2-4636-bf8d-08d5b51f4a3c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 20:07:13.0339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ddb714-d5f2-4636-bf8d-08d5b51f4a3c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1445
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 01:48 PM, Joe Perches wrote:
> On Tue, 2018-05-08 at 12:08 -0500, Hook, Gary wrote:
>> On 5/7/2018 6:47 PM, kbuild test robot wrote:
>>>
>>> All error/warnings (new ones prefixed by >>):
>>>
>>>      In file included from include/linux/intel-iommu.h:32:0,
>>>                       from drivers/gpu/drm/i915/i915_drv.h:41,
>>>                       from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
>>>      include/linux/iommu.h: In function 'iommu_debugfs_new_driver_dir':
>>>>> include/linux/iommu.h:706:8: error: parameter name omitted
>>>
>>>       struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>>>              ^~~~~~
>>>      In file included from include/linux/intel-iommu.h:32:0,
>>>                       from drivers/gpu/drm/i915/i915_drv.h:41,
>>>                       from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
>>>>> include/linux/iommu.h:706:8: warning: control reaches end of non-void function [-Wreturn-type]
>>>
>>>       struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>>>              ^~~~~~
>>>
>>> vim +706 include/linux/iommu.h
>>>
>>>      700	
>>>      701	#ifdef CONFIG_IOMMU_DEBUGFS
>>>      702	void iommu_debugfs_setup(void);
>>>      703	struct dentry *iommu_debugfs_new_driver_dir(char *);
>>>      704	#else
>>>      705	static inline void iommu_debugfs_setup(void) {}
>>>    > 706	struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>>>      707	#endif
>>>      708	
>>
>> I have no problems with adding parameter names. But
>> scripts/checkpatch.pl doesn't seem to check for this, nor require it.
>> Should checkpatch be updated?
> 
> I'm pretty sure that's not feasible.

Ugh. This is a definition, not a declaration. My bad. Which is likely 
why I decided to apologize up front.

> And when the compiler tells you you've stuffed up some
> syntactical bit, why should checkpatch duplicate the
> output error message too?

Well, that's the point: neither the 4.8 nor 5.4 compiler complained 
about this. Not as an error, despite the fact that (now that I read what 
is actually here, as opposed to what I think is there) this is wrong. 
Had an error message been emitted, and the make stopped, I would have 
figure this out before embarrassing myself in front of the entire interwebs.

> btw:  That's an unnecessary ; at the end of that non-void
> function and it should probably be something like:

You are correct, sir. I've made a change on this.

> 
> static inline struct dentry *iommu_debugfs_new_driver_dir(char *dir)
> {
> 	return NULL;
> }

Thanks for taking a few moments to comment. Much appreciated.
