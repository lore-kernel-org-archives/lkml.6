Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755915AbeEHUsu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 16:48:50 -0400
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:16818
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755892AbeEHUsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 16:48:47 -0400
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
 <239fdd0c-9497-7275-4e74-d6ccd028e823@amd.com>
 <eeb51d36cd50f892630e0424cded20ad6bc47501.camel@perches.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <58f88d92-ae97-6bdf-822a-625e47e4d0d0@amd.com>
Date: Tue, 8 May 2018 15:48:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <eeb51d36cd50f892630e0424cded20ad6bc47501.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR0601CA0089.namprd06.prod.outlook.com
 (2603:10b6:910:88::30) To DM5PR12MB1450.namprd12.prod.outlook.com
 (2603:10b6:4:d::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1450;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;3:NnyucAlO2qHun0F2ZLbCjdU2RHZSkVOPNHxTN1hWuIduHQglKlz8G2LWypnFZjgFaLeU/HYWpGWW9CQ/EESrMo3HvtXve93EjdMJGocN5YhES2P34BkphlPfaCXLiJdDEyRyiPUMvkImVz3THY35h0CqDKdOJst7IIITviLOTCH4SlMUuUFRgSSUJxUIW94BCqlDrsO8I9XX2QTJcppYpBbiRjrX6OqLPOknvyPchiJpmUCMsxBivL1RmDA5YOJZ;25:Mk+hxkTvx2Huu3yLGyJ6dBgWMxjhB7nANoHnx8bvbVS6iYa1LyCv4Z2oCHKzLq7KMvV2K/+WH7NPoqvBD1Flvp6gMDJR73Z+hqjPZc2ziyqb1nP85FDoDqHySyFmwJ74gGx8XhnpvCOBnS3KF/CtRAU7Hz+t+mcWIwJ/1cGmstyDE5wzKjkYZv/szfLJI35nNHZIH0LvZBuSED95NIxLMd+VfjPPlmISp/Aot3gWeZCvZ76+vDyxw5zyQhnML8Aios/mk7HF7O3V6DYI3bHKNMyzxTbPjV08bJMPgWaQl4V+b6uWFnOVfDjbaUoLOeZrLEBn9d8aigcBMupIFCiQJA==;31:hDRMhZZzZPrJrKyu3/4jLehcuwXNzCM58y7Rx/iqgIXoAZhXNVz6kpj+chtotqoHMi4lJHDE7QSniNK1QyxJ/Lhkg2qlWOus3BRZPl4GmYCFy86guTlUU7isBeuaoCC0jVzvFNNee2JDpR18wj2GlNLdYshyCQ0/xwRyyigVwZNkTIlhcRNsPHc8bP4r0jWEt1ISOoU81U2uj/fQwEwT4O2Xe8rTOG7HyVZLe6gqhPk=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1450:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;20:05Sngr9QTo9V+4afrAlOQVCP7NxBEl8ct2fanMN08cwYAYj1AuLPW0AwxKADs6FHCTfMzdi+U7n3aO2qLD9WM6tE2fTlRdrHciZ9qnyiUXLp6YDDxyrLu6fRiAPlFBrl4Tu3nVuGIYxuvN0rQMxb9tFQl02AF745/9gQOXQgD7iSnsT8M2lZnTdj1yJN9PzDly2lq7V0QWbZcTSIB7i0mIqVeSABs5JbKHWWUenSIm0Ro9wnm8bTbwi1ZZQxUtsoxVHFTPz8MgNl6bHFYnGJW8JmntTH6w5yWNHZK9SOxlImqyrx7E44F10GL1anJhXMsaxRUXeVcWBYMBYr97wx7Y3fYRezDG9gpp2L8IoABUmel1JGBjCRK2fSyRmpsptZa0yLkb5N07asEGzEoupNdlRyLJMp8j7wpG4hDNP0Pz+BCR2X0azb4N/t2guj8vNMg5HCUWlnUXZTXTnRMxj9CYF4SESd8OiLxBjzY0bU7xjDEzsRFK9/Ug6adrw5mcTI;4:t2inmPU6Ik+6LwXHtz6CDOGW3fVdGjNeZFX8SJlr+T1llDfKoUH5ObB/OL7Yu5KkAeDOp62uT7puM85gVzsiAYV9p9551iA7/o4miGBKKnEc9lgiXc2X+6TFJqWpFNi/nPBWqgclv2/e5QOIxI3IUAh8T169dajHeWakdjR9Tf/aWstTQUZCqOcZUnoTwlCX4xsgap3u6bVWihviAAjBLn+WFmcGYHdXtv6RcuWW9qybQvEndbAOHhwcly0ZBCykVy5/1lUWI+EBrE0To6L9aA==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1450588CF7A2863710C1F88AFD9A0@DM5PR12MB1450.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB1450;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1450;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(199004)(377424004)(189003)(50466002)(11346002)(446003)(72206003)(316002)(2906002)(110136005)(58126008)(64126003)(93886005)(2616005)(478600001)(476003)(31686004)(36756003)(16576012)(956004)(31696002)(25786009)(105586002)(486006)(65956001)(65806001)(66066001)(47776003)(106356001)(186003)(68736007)(53936002)(4326008)(6246003)(16526019)(6666003)(305945005)(230700001)(8936002)(7736002)(67846002)(81156014)(81166006)(386003)(53546011)(229853002)(8676002)(52146003)(6486002)(5660300001)(65826007)(2486003)(52116002)(76176011)(59450400001)(3846002)(6116002)(23676004)(77096007)(97736004)(86362001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1450;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDUwOzIzOndJRFpZY1NnYW5tMjVFaDk4cjNiMFJtUmZI?=
 =?utf-8?B?MHhGZFI1T0ZiQjllb0tWMzlzbTRtdk0vSmt2Y28wWW5VZk0xWWdGdUhIdG9D?=
 =?utf-8?B?dWxYcEJ0N2J6WUMxdDhtUWY5VEp6RUczZzV5bWZ6Qk1oUlg5U09NaUp3RG1M?=
 =?utf-8?B?VmZwV3loQWhWTUNhMFplLy9oUXU0Uy9hVDZhVzVnYzBFZmxkdkZPdzN3WVZR?=
 =?utf-8?B?djBUZU83aXFaY3RPbzVSLzVyaHVGMDRUYzl1cHV1SmNzTDkyQjdUc0JsdzBi?=
 =?utf-8?B?SlROK2ZhcG9ZbE1VSFdkWnBRUHQrdmI5V0RhS25BZm8ybzdnNXE3UUlrUG1x?=
 =?utf-8?B?QllvZVBLMWY1TVFkZE9NVDhhQnlFWXhQcG9VMVR5cTNxMUREUFo5TzQvMis1?=
 =?utf-8?B?S2JobVc1QVlUU0JJZy92cXZ6ZWFFM3JTU0xSRFZzZ3FZL1dQa2hwWjlyQjBx?=
 =?utf-8?B?Um1rdjV0S3RTWUtGdUc4THJOZFhxQnMrT3BmY01Mb055TnlYLzFLMkFXMFNu?=
 =?utf-8?B?ZXRMV0svdVh5TnJBQWViSXZ1SGc1ckYxT3pzcTA5cGJVVFVMbGFqV1A0MVBp?=
 =?utf-8?B?T3lIVjBBRWFlL0QwZlJuZTFqaG1CeWhmNlhHdjNibHdtc003QjNZRU5qNWJv?=
 =?utf-8?B?MGRUQTFoNGthZ2hrN3Jrd2o4THdPTUt5YnhuU2ZEclM4NXM2cEFLWTgrVjNB?=
 =?utf-8?B?Mmw3SEFyTHlBNk9KMC9YZlh4eFpzeU1hTTFqMHorTkhyZms1MUhKbUoyaTV2?=
 =?utf-8?B?dVEwcldrWUlidUp1aDNBdSttS2RBM3ROUGc4YUpKTC85cEdPYzZSWXdoamxR?=
 =?utf-8?B?TWM0RE1ZTUZYZHFZc29JeVZjVHVIZjRMQXpCUTFVWnhGUnVuZkFKUVp5QzNN?=
 =?utf-8?B?L2dEdkx3NzdHSStxZXpuUW9wUjcvWkJkN3hRQklEanVNdXhQTHVEREE2bzBC?=
 =?utf-8?B?MmRSdVk5T1hHVDEzTHpJdGNPdG0vdFczYkVpYmZlNGEyWFNaOEZidDFnakRu?=
 =?utf-8?B?elhRaFNlajNuSlY5dGdKNEIxdFpkektKV0ZIa0hlUStkcmkrbUY4M1NReTc3?=
 =?utf-8?B?ODdodDRMUGY0aGpJU2RWaU9meWR1U3VocVNJSnVpN3lRazNzYUF6eEFRZjFi?=
 =?utf-8?B?TnRzSWV3UmR2M0dkYUgzbkZRNGZLVkZ6TkxpVnN3SkZFYjBraVJFck5sUHhF?=
 =?utf-8?B?MXJESWVZT3pXMjAxdzh4eFpmMlY3VkkraHFyNk1mVFNvYjlkbWVmb05rZ2hG?=
 =?utf-8?B?SzYrck55NXVFejJlTXltUWVPeUo0ZDIrQnBENEZMOWluc2h2TFdvQlJwWC9C?=
 =?utf-8?B?ZnJkc2FmRGRQMWp3cDZTZTNBcDJGcjhGRmdZTUtwQnNVOUpHMUJ6OTIwM1B4?=
 =?utf-8?B?RHdheHJGNnI1anVUbFpheTlrM0xFQVRMVXBZZC9BUkEyRkZpbjBtQW0velVw?=
 =?utf-8?B?QWhUYzBnOHJOOHQ1VmVDMGVUZGtSSWtUTUM4K1JYMldqR21KTkcrR1lLVU4r?=
 =?utf-8?B?UnZHa2V3bXA0RDhaejB5cUxzZFpIb1JZU3dPaXlDQmp6emo3SnVjWUdsN0tN?=
 =?utf-8?B?ZlFWdk1CSkVBYmZxVEhFb1lOanBtbDA3OWxpVG9zRlZFb2lVTGp5VW5MOEYy?=
 =?utf-8?B?RGxDNE1MNWJSR3V4a2IrcHZlYStaR2NHMC90MDErdUhUWjFuT1R6VDYyMTlj?=
 =?utf-8?B?OHlCK25CZDUrRFdTRnRIRE5OR2w0RmxDR09ndmljRi9Ja0JBRks5VXA0WlJj?=
 =?utf-8?B?eVU0anN2cko0bnJqU25vL25ZMGY3cjd5Rkxhemx1eE1GQ0VHTWVQVkZjM29t?=
 =?utf-8?B?WkJaUWtZLy95TGl1U3VkKzg0YlpoWUJoMGpEOUY4UmdaaEh6R1EvOG5EL0ZL?=
 =?utf-8?B?WXkvY1pDWW56TVlTMFJDcjBhaXVkZ0tHNDhtWHA1Z1JhbWF0RWFOL3pIdVZo?=
 =?utf-8?B?SnRPU2xzTmVGTTlwSy9NZDJYbjNMTmFOMkU1Ukl5RDExdEFqZUdNV2hnZHlI?=
 =?utf-8?B?Y2d4cFhUZ1N4WmdaQk5LZmlrMzk1dkN2eFVvRGgxcGFBRnQ3dmo3SkNHNDB4?=
 =?utf-8?Q?pDU1MKNLF2w8TNyXcT1EbR1wE?=
X-Microsoft-Antispam-Message-Info: 5aqdIBC8Kq31xGjTlrfN1NFKtQKqLKEMvNgadPgjiRxMXmbFqkggGoGJtBYEO1UM8H5kQ7clSRa99xKnDdsjgIB1ozo/tRbKALkzP3upx8Qc9TOf9wkiUTv7t9EB/yWHw97kvjQnAHM+syfrZxUgQZvjTALMzPMa9E0iESjv0LKgwen7R4iwpZzp3q2S+5fA
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;6:vH2g3Vh577V4uJcfkk2lR1peAGeaM865o5JFiuEYeHaU1gfOXlIGcmTzALrO8hWzeDeWIf9nfTpTdQoNQEutQURw0w3HrSx1kgYgOvxzK87eiKtaOq3MwBUwWh5VwkVD1j0xZTOak5k6bUqniZSqrUSLznA3+6Oc/AUgME+PJSTHK4PRdKzvAMI4Zmq3U0r16Lw19bnxw7huuwcaRUHC9jiePnNiWO+irMPItMKbK9ZqHg246zeQNpVOOcM/rUgfiSg/GEon6Q+5YHiFuKBc7hP+zJR2H7ftXW+ONsPfEsxCO434Tno5vhTJcPvYXifee0piMHvp6UTYZXlDreWWeEhhXXsr0xTeagiN7xDhwZ8kgbftPqv+LS8ObAi0FkZ5Hkv4GrWclN99Ti99xFzyvdlRVoiMW5pE5+1PQPOMS6oeY4PbPeKxmMJGeDS4R1oidB6ewx0UTPxuGJssHITQjw==;5:z7f0ROmYRc52jmOFPVsEPRxWLaNupcqH03l8vFa72SqqznSadSQPr/2TenUs/YoA16wJk38UREK0XjLS9F99SB5apQAuYblewf/AWRceSs63II2tfRrpNR6QnXqbO0aPY1jYcTfVopiPLMs5d6AOL6z3Q3WETHKQqE8vJLfy8n4=;24:SBbetCXRuTchKPaDUrkfSJc0ubGl3LMwLEGfI6aDotWQqiTefVBa6d+J4jwXC0d0DyYZy+p37Wn7lBRUIiIp3sUrEwl6RYLwN3AnMsWpCjo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;7:meYQ8tHZ1htNIATfJ/YmE3aL18gXuiK4WWnu7JFh3aAH11IWGbNlQwL74JDMoHviNAohsw5qy9xkLRp4kFO2x/ivZO2bsxgngF+qaBf4WpsdFWlRO9v9MhMAN6TJ/nwdrqQVOnxaLEJYUySwPfISjXgGtCemYktH/6ojoDRE5vVe2xpuNKO01CmvSRuxNx1TWv5XjUxSREuiV5EgDY2AnGIT/Quji+9YliP4psmsQqsNgOolMJYHh5xroaWqv/Kf;20:bnkjLoqsUxR83fHxWsDQyG/TSKfKEzlVrdv4WPBcV2NFJKlJtLoMrxf/IURR40NGY+35Syl0vVcSNAOmk78AWPoEk6ouFFzO4tQ41+qBUFH85U6MTrpqHOk5vuuuDVzL4DCOxrevNalPe0I5wifqKtbukq1EjckJ+0aQO7S7d913TZFzljPKjBM6RffPjRss3R9oYFQj2C1jo+iGOsDC2AH79RdFToLCbjABhlFAhJHplzCzNyNTlFmjpZ1eZa6l
X-MS-Office365-Filtering-Correlation-Id: c55f9ea7-e191-4a95-5c89-08d5b52516ff
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 20:48:44.2200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c55f9ea7-e191-4a95-5c89-08d5b52516ff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1450
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 03:42 PM, Joe Perches wrote:
> On Tue, 2018-05-08 at 15:07 -0500, Gary R Hook wrote:
>> On 05/08/2018 01:48 PM, Joe Perches wrote:
>>> On Tue, 2018-05-08 at 12:08 -0500, Hook, Gary wrote:
>>>> On 5/7/2018 6:47 PM, kbuild test robot wrote:
>>>>>
>>>>> All error/warnings (new ones prefixed by >>):
>>>>>
>>>>>       In file included from include/linux/intel-iommu.h:32:0,
>>>>>                        from drivers/gpu/drm/i915/i915_drv.h:41,
>>>>>                        from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
>>>>>       include/linux/iommu.h: In function 'iommu_debugfs_new_driver_dir':
>>>>>>> include/linux/iommu.h:706:8: error: parameter name omitted
>>>>>
>>>>>        struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>>>>>               ^~~~~~
>>>>>       In file included from include/linux/intel-iommu.h:32:0,
>>>>>                        from drivers/gpu/drm/i915/i915_drv.h:41,
>>>>>                        from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
>>>>>>> include/linux/iommu.h:706:8: warning: control reaches end of non-void function [-Wreturn-type]
>>>>>
>>>>>        struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>>>>>               ^~~~~~
>>>>>
>>>>> vim +706 include/linux/iommu.h
>>>>>
>>>>>       700	
>>>>>       701	#ifdef CONFIG_IOMMU_DEBUGFS
>>>>>       702	void iommu_debugfs_setup(void);
>>>>>       703	struct dentry *iommu_debugfs_new_driver_dir(char *);
>>>>>       704	#else
>>>>>       705	static inline void iommu_debugfs_setup(void) {}
>>>>>     > 706	struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>>>>>       707	#endif
>>>>>       708	
>>>>
>>>> I have no problems with adding parameter names. But
>>>> scripts/checkpatch.pl doesn't seem to check for this, nor require it.
>>>> Should checkpatch be updated?
>>>
>>> I'm pretty sure that's not feasible.
>>
>> Ugh. This is a definition, not a declaration. My bad. Which is likely
>> why I decided to apologize up front.
>>
>>> And when the compiler tells you you've stuffed up some
>>> syntactical bit, why should checkpatch duplicate the
>>> output error message too?
>>
>> Well, that's the point: neither the 4.8 nor 5.4 compiler complained
>> about this.
> 
> Perhaps because CONFIG_IOMMU_DEBUGFS was set in the .config
> for all the compilation previously performed?

Well, you'd think maybe so, but I forced a recompilation of that one 
file (i915_oa_bxt.c) and no complaint with 5.4. Weird.

Ah, well. Onward to patch version 6.

Thanks again.
