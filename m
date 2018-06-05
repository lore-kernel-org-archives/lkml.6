Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeFERBs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:01:48 -0400
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:34336
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751786AbeFERBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:01:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v8 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
To: Greg KH <greg@kroah.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
 <152761819480.2654.5371070582955429468.stgit@sosgrh1.amd.com>
 <20180529184101.GB10618@kroah.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <3249cc11-09d8-2078-28a6-efd3078ca0e9@amd.com>
Date: Tue, 5 Jun 2018 12:01:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529184101.GB10618@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0076.namprd05.prod.outlook.com
 (2603:10b6:803:22::14) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1449;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;3:2xnS+Jy5H39P+3nIMzQZZqa9R7TH83CyXfPysq0EcNVK6aiIb9vGqNzmTYiizs8tfOR336xEHI0YDVc4mGe1dpodCvFyjFll1DOlVyB1xSj3uxEAYAVzt1yYzButtPHEjfaXs3WUUq7m27OZ6n8l8MLhgyy+DkcIC2A0gXJlYM1BI00RNwQd5L1tatQ+dOe7AMdtSJ0jnSZPe6wlaRcm1mlx9lVS2E182Tu8O3xkIrvP0/bDijmQ7N8FoZtARhD0;25:BqdxMC1+LVDYBKPu5+tYmxnPPZAC7JOTiwqBR1IL/Aaq4dQIH9N/4dP6bUtxMOzoGeyjRlAr6yet6YD310j/udYoifEnS8rtbMcPKCBva6yvYcILFCXSjsPifyUO5bc0HJjnVxoiIpBLj/iYsfc5D88pm+xzFle8oYEYewMEwibLwkJnfBeJw+TguxlshkFrWumoKBJ5077Wpfco6mU9GmqqugUbFuK2WRZRB8Sw3A8G2J4Oi/1nYto6VbdmjWgSQlsjvf2YQ0loYAAyjPDlitk+Z5GINtzcZh9DTqU0ocnci9rbxbcI+q+TkzfSvpw2Oqr0nCG4wtOB+lt+UcoD/A==;31:ac8Yl0YtBenL3WSCtkEEdH543kfXkKy805xA+NuJlte7uzfPnVWv/RQ4Z6m2XY4LWA6Pn6Q3SuXRXFvm9UuW26aXI7SYBK92mSVMlhWKADduoGLVH7fvwMsmmEPYnWlIu5dlaSv08mDwJBgCU/Ln+yRUk0EpQjV0C4dI0ebeZvQoIs0fHuG/McTyigtlcibTPZtFpJ1qXCc4Y3hDVgOQKR5daTIF6C5ANMFwK1+BJUs=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;20:KT1ePE+8N3nOODyccOmcvDOPqpzU/wJ5eOTXjxbUpK0xE6w2FTnYal07z1ge8dyV3lKAEFkSw+cfIdJ4u7pSYQZKXhvLDgm8GQucNK5Xu2vdJ/7nkseWEkfzgiodLxzDTT62LrISWG752RAPXqAPauwgzE4YautKndM4Gc2q8b7cDs66F5gKVdJjqQAWdKH7r1gBk0/+4wnaFXuFbTlYw3sIK5kFElZQU0uT/f8k4z5ROjHr2Ln51Nz1mX3MyahoXU16bSkMR+n13KSUfjJRaj4s6/0JIilH4SO0FQJMZFHNkmJUMoBFcL9yQSgXHMNXdcphWx31iFa342mY9VZw9CPhSxklhCJq72ys5PJEzaP8S1yiTWvtf3AJ1iaTFeKWX7WjII26dTXOBSCY4UfJHtCSoTx7R/yCvTNMOzgmRR8KaeMYEHYaPZXN02KbcpFSvX1bdkV2FWoXE1IGtWc9d5B7ptF81I2yDLNorWU642wj6FHMqDhCZaGQhBsAEQho;4:HQ3tjnYtqy76UCUTTj4uJJRwXfR0i7380hp13cEwbzWiqn16OxtvD2JOdI5XrEctov/uBDK6VV/MRUzVyURPpAdmgdGwLQMtEFtp2fAPm0qIbxPbgDC786gz3Ke0FXqqrfps+0iUl/dKizf2Te8MCsCifC8lRGTGfHQWbE6hdO1KuSLLaOumXaHp1OeJx4aZ5y6+IBfaia14FcVNWzY6l3D+mG408hc/wPQyC4zEzcfKqS0V3wlO4naJkv0PAFhm7p0PJeBc6R5EfkwH/fLWoB6oPrOC3BLJXHhvhWC0Vi5ljbhbAV5+JtbUTZPNGaA+mDe+pI7oVK5udgFMJwMo0lIxfjMXMBmxtbViIgw8q04=
X-Microsoft-Antispam-PRVS: <DM5PR12MB14494F3D01A3471B3B2592BDFD660@DM5PR12MB1449.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1449;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1449;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(396003)(376002)(366004)(39380400002)(346002)(199004)(189003)(58126008)(65956001)(53936002)(11346002)(3846002)(66066001)(478600001)(25786009)(68736007)(50466002)(229853002)(305945005)(6916009)(65826007)(36756003)(64126003)(7736002)(8676002)(81166006)(81156014)(6116002)(31686004)(72206003)(65806001)(47776003)(230700001)(105586002)(8936002)(6666003)(5660300001)(6246003)(2616005)(486006)(956004)(26005)(476003)(67846002)(23676004)(59450400001)(97736004)(76176011)(575784001)(316002)(86362001)(77096007)(53546011)(31696002)(386003)(16526019)(16576012)(52146003)(2486003)(446003)(186003)(52116002)(4326008)(2906002)(6486002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1449;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDQ5OzIzOnNJNnZWdFNrbmpiNVNJc2VlTE5mcTNjWStv?=
 =?utf-8?B?bTlpWU4vQmh0OHM2VFRTV2M2WDNDeVB2YmhCV096TUlxTTRTZGFIZ29Vczhn?=
 =?utf-8?B?UHdvWmwvM0dmZFlZZ0FueU1PSWVYNGRyc0JKOFBPN1g2RmpLakhSd3h3YUhl?=
 =?utf-8?B?bzFuS21pK2pEQW5DczJtRUJDTTlBd0ZqU0RDQ24ydktLRFlRa0N2K3c3VktV?=
 =?utf-8?B?cjZHTTR5Nm50UktsSU8vdUd0OENrZDlSa09zUWU5Q09iL2R6YUpFa0tQNmNy?=
 =?utf-8?B?NnpDNXpXNFlUMHNTM2J1VEpPeE4wOFNPWEN1dVVjT0VOWWFHcGFjZ2tqcnR5?=
 =?utf-8?B?bVFiQ1R1a2g3VW5na0VMRUtFTG5FUHp5S1JiQUhUbEFkWllmd1UvNXZRcEov?=
 =?utf-8?B?R2xCMGFHSkNNd3ZRUkxxSTJ4YS9KaERaVjNFcXRla2hkekVzNXhla1dTMjVH?=
 =?utf-8?B?eDk0R09heGo3Skg4YWFwR1VVcGhkRHk3YkJiRFc2b3VaK1N6WlRRT0JMaERK?=
 =?utf-8?B?VFJ4dHo4WjYweUsydmRUNzFVU0Y3WUF4eVk4b3FkdEVPK2V6RjB2Zm4wZDlU?=
 =?utf-8?B?VXNDcG1qQlBLZExLaGtqek1YUEZjUmlEZEdUU0pQbXJPdnY4OXdnYXRLSjVX?=
 =?utf-8?B?eDVlR1dXMkFudnZhbURvb2c3ZHo2RjFyKzlMMG0wZXR0cWp1NWM5aERWSnNC?=
 =?utf-8?B?Tlk1TkxyMmozdEYxaFY0U05lalpEdm9UYnVKRXZ3T1BBcGxiTmlYbW8rOHZj?=
 =?utf-8?B?Z2VMbDNHTXQxcHhXTmpPK1pEaFJCSUhHMHBJVzU2dGRpTGVkMjR3SEFJakFJ?=
 =?utf-8?B?MDM4VGl4b0hZcnlpVDN5Skt4T0diSkxoaENGL1d0UUs3OXBCQkg2dUlDSFNj?=
 =?utf-8?B?SEdaUkdmNWdpR1JJc05RdjdqYWlXMExjUWdoVkhtaFByRGpqUDMvNmZLVDU0?=
 =?utf-8?B?SEdxNjVWZEFib2M2RFpWL2NxeXlzM3ppWFZnTGJHZ3ViVHpGL0g4VStkVjFL?=
 =?utf-8?B?dkk2RTd3UWxYUGcyZWtuMnk5SVVES3hZakErU3FjbmFHMlJjMjdCTncrVXp3?=
 =?utf-8?B?bjMvZGczZkJ4N1JmR2NvL1EwTm9SYVlmN3VwV0VYbkVnMjdqQWNxNHJESHFt?=
 =?utf-8?B?MTc4Y2RieW1pNUM1VnpOWTFLekljSEt1UVp2b04zWk9Odkl6dkI4eHl0RGFY?=
 =?utf-8?B?RW1PQi9KbE9ZQVlXL3JlNFBRcEc5WThDUU1WODdqOHE1QlBQdmlzWk1YaTRE?=
 =?utf-8?B?QUltS3lSZ0poMDIrZytOTzNrZTMvNFV1bUdRRUtWTXEySUYweUszWkIvS20w?=
 =?utf-8?B?WGtsUWxkM1hpWGhXOWpvK2ZuYXU1WlkxbFpaTDRISHRydDVhVk56WHdORUMx?=
 =?utf-8?B?dmxnU210NnNGVkhYcVR6MVVrbVdkenp0NU5lSWR1YlhVL2JjazRsaTRoOWZz?=
 =?utf-8?B?L2UrZHFrbXlOQzdDWitnUW9xWUl6L0JmcDRnTVRINUgvRWhHQklUNzIvN2Nx?=
 =?utf-8?B?K3VSRmpBbmVIdmd6cmg2UDRJQUthdmFWNy9QQnlYVElTUS8zcXRFRzdJbWdv?=
 =?utf-8?B?cFJDekxQeHpVUDZzM1h4Z3ZIM3FYTUJPMlhWc3Y3c1VZSFhEalBveXhsWlJK?=
 =?utf-8?B?UEVCT0E2TkpWUE1TNkY5eGxMeWdlWlFmZFY3OURiWGNwU0ErYlp0Y0l3UllS?=
 =?utf-8?B?a1NpZXFoMU91czlnNXEvT3RuNWlPUjhUblRvQ3RCNTMzbml6WDBxRVpRclg5?=
 =?utf-8?B?TnNWOFV4ZmRhcmhLZllrOFFucGF0aGR2amRGTC8xZG54dEthcWhkSXNLZHFo?=
 =?utf-8?B?VlpEOVpucXJpNFBxSXhoWVIyaTVhNzcwbHVBUE84QXRyaE9ZNElENDNuQ1A0?=
 =?utf-8?B?UTFuQU1xN1k2NjRxVG9qVitMUTdIOFVqQWdaTFNvMzBtT3czU2liMEZaMnU2?=
 =?utf-8?B?bExabWt6bExCSmxWQUJNcHJSSGE1bXErcnZSb2NPL2VUc2d2eFBpdFAwMTF1?=
 =?utf-8?B?YS9FUHAxbWV0Vmd5THpsZ01MV3J6ZndKaFVBZ2pERXFXZ0tlaXRpeEJWWjlN?=
 =?utf-8?Q?+9rI=3D?=
X-Microsoft-Antispam-Message-Info: W5fb9kU4HULthYgVnYO4KPGuLcdxCi7CER377oclSdlHOQtFyHYk3JGa7l7uRqX3FR9X2Qqe6AGv04P9vKgXz3CICidpvh1FL3UjljyXj0m/7c24L20KP5MsRHr5JQB49Ip9kfRwX87Nuopkflt8+OFvTFZcGippaUyq3UmIjU7jIg9vXw/eP4kOhgYbHNzT
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;6:g5n1gXRSbsn5liLHvQJk0a5S9zOzxH7SJSUtMsWf7JiBFM06nWazOmT12K6/zyJ+ZGS149ekYCIRYjXoKUJOxR4ZDzy5cODbOMoZ1QgyFV2Cdcn9dRBPABe+uz99fYR+ciJntStz9lnwTvaWxu9nAXiDxW/yKG9SV8IHH9FUxlJdJPlocSlU/9/hkOULMr6BtupBZzhlqitpbHY9laSgUWudNxqZMwP4vBuYggnOV66h+QrxpyIwZTfuzM/DbJ64G8AOZgrqi+n8nV7xrXYkvJlzH4hMmFMVI0ZgVcHC5dDFu1ogJ38OC3NRBCbAy3wmybOHoOh7q6hlAd4L3E5X9feJYJlvBGxJsrpj1Qt+Xk2jnl52nb5wP0Ue4O0eLLxQvrgX97gFglAUlQ8rcBYmw0R+2vFDZ1r3khrIEH9m06AVUcCoVtK286Yuv8UkMXFcL/E9hgiSFPLSn2xSITKeUQ==;5:tyRB/6JGXieCgRkC9/Mnii+t9x7Cp401cGHQs5uIipnLu7CjMXEqWVUDLyw8QnWsYZPn+wtJazZFxxs+GAQ2BzRsDHcTv9vmhVaCcZ/r93qarFFwuvce44ADOIRTZwac+3hkYifFDLRJRKxgxDej2wJVaAoKdf4bHIa7j9NmRHs=;24:XYS/tEDIFg0zRmNUHSQ+wtaxEkiN8isWji99Vvq41XUgsuqESsvZzzsRJmX24vQtnMI/9OxGRluxDGytUP0JGzr1x1n1xeVOVgFoPKN8aK8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;7:pGVluk7TRk9t2OfIEslZZLdS9BKfs6+khMicIt+P1BvhjMn6HFePpsTs9X/N4JQoERpFyGmyoa4VYLltyxvgCDvESUFJ+Wu1OvyOEgw2/G2f2pi1ZBnsy1q2nG6W+98ECDGBfxRddbUmS+nTrSGyacKlvoHZzpgiGho6Ct8sqnf+OjpvjhYu94lkbwAqRhaikXQdR9Lew8do8LG65vzPjil671c5U26jfSvGuc3n/S3sZ6jJS75ENSzIaisZVbty;20:PIvNCEf/Wk/zQBF/i8Y+eSb+vM4WbwV36QOGIcR8gGksPUSNn22n+meV6geQliCWh/sHZORKwXkm9ulTprBmcJBj7Ck7pE320qJYL6I2PzIk2wnD42M1hOW0GN+UA+AaYOUtxO30dJmRZ4EqMi1jvQGyLqj9FiB/4cxHCjiScqS10BCbPgtEuMKDmtt9eN8H6/V0ltKh5eG/ylMIsHy9OcDh4QXJLZ/zSXhzGcXLi44XFsJiOmbOAMWA9a9y5DEx
X-MS-Office365-Filtering-Correlation-Id: c560cf8a-7270-4eed-0cc2-08d5cb060467
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 17:01:44.4241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c560cf8a-7270-4eed-0cc2-08d5cb060467
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 01:41 PM, Greg KH wrote:
> On Tue, May 29, 2018 at 01:23:14PM -0500, Gary R Hook wrote:
>> Provide base enablement for using debugfs to expose internal data of an
>> IOMMU driver. When called, create the /sys/kernel/debug/iommu directory.
>>
>> Emit a strong warning at boot time to indicate that this feature is
>> enabled.
>>
>> This function is called from iommu_init, and creates the initial DebugFS
>> directory. Drivers may then call iommu_debugfs_new_driver_dir() to
>> instantiate a device-specific directory to expose internal data.
>> It will return a pointer to the new dentry structure created in
>> /sys/kernel/debug/iommu, or NULL in the event of a failure.
>>
>> Since the IOMMU driver can not be removed from the running system, there
>> is no need for an "off" function.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---
>>   drivers/iommu/Kconfig         |   10 ++++++
>>   drivers/iommu/Makefile        |    1 +
>>   drivers/iommu/iommu-debugfs.c |   72 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/iommu/iommu.c         |    2 +
>>   include/linux/iommu.h         |   11 ++++++
>>   5 files changed, 96 insertions(+)
>>   create mode 100644 drivers/iommu/iommu-debugfs.c
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index c76157e57f6b..f9af25ac409f 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -60,6 +60,16 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>>   
>>   endmenu
>>   
>> +config IOMMU_DEBUGFS
>> +	bool "Export IOMMU internals in DebugFS"
>> +	depends on DEBUG_FS
>> +	help
>> +	  Allows exposure of IOMMU device internals. This option enables
>> +	  the use of debugfs by IOMMU drivers as required. Devices can,
>> +	  at initialization time, cause the IOMMU code to create a top-level
>> +	  debug/iommu directory, and then populate a subdirectory with
>> +	  entries as required.
> 
> You didn't put a big enough warning here, like I asked last time :(

As I noted a few moments ago, I didn't see these until now. Very 
annoying, that.

> 
>> +
>>   config IOMMU_IOVA
>>   	tristate
>>   
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 1fb695854809..74cfbc392862 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -2,6 +2,7 @@
>>   obj-$(CONFIG_IOMMU_API) += iommu.o
>>   obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>>   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>> +obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
>>   obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>>   obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>>   obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>> diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
>> new file mode 100644
>> index 000000000000..bb1bf2d0ac51
>> --- /dev/null
>> +++ b/drivers/iommu/iommu-debugfs.c
>> @@ -0,0 +1,72 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * IOMMU debugfs core infrastructure
>> + *
>> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Gary R Hook <gary.hook@amd.com>
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/iommu.h>
>> +#include <linux/debugfs.h>
>> +
>> +static struct dentry *iommu_debugfs_dir;
>> +
>> +/**
>> + * iommu_debugfs_setup - create the top-level iommu directory in debugfs
>> + *
>> + * Provide base enablement for using debugfs to expose internal data of an
>> + * IOMMU driver. When called, this function creates the
>> + * /sys/kernel/debug/iommu directory.
>> + *
>> + * Emit a strong warning at boot time to indicate that this feature is
>> + * enabled.
>> + *
>> + * This function is called from iommu_init; drivers may then call
>> + * iommu_debugfs_new_driver_dir() to instantiate a vendor-specific
>> + * directory to be used to expose internal data.
>> + */
>> +void iommu_debugfs_setup(void)
>> +{
>> +	if (!iommu_debugfs_dir) {
>> +		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
>> +		if (iommu_debugfs_dir) {
> 
> Again, no, never test a return value from a debugfs call.  You do not
> care, you should do the same exact thing if it is enabled or disabled or
> somehow failing.  Just keep moving on.

Yes, noted.

> 
>> +			pr_warn("\n");
>> +			pr_warn("*************************************************************\n");
>> +			pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
>> +			pr_warn("**                                                         **\n");
>> +			pr_warn("**  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **\n");
>> +			pr_warn("**                                                         **\n");
>> +			pr_warn("** This means that this kernel is built to expose internal **\n");
>> +			pr_warn("** IOMMU data structures, which may compromise security on **\n");
>> +			pr_warn("** your system.                                            **\n");
>> +			pr_warn("**                                                         **\n");
>> +			pr_warn("** If you see this message and you are not debugging the   **\n");
>> +			pr_warn("** kernel, report this immediately to your vendor!         **\n");
>> +			pr_warn("**                                                         **\n");
>> +			pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
>> +			pr_warn("*************************************************************\n");
>> +		}
>> +	}
>> +}
>> +
>> +/**
>> + * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
>> + * @vendor: name of the vendor-specific subdirectory to create
>> + *
>> + * This function is called by an IOMMU driver to create the top-level debugfs
>> + * directory for that driver.
>> + *
>> + * Return: upon success, a pointer to the dentry for the new directory.
>> + *         NULL in case of failure.
>> + */
>> +struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
>> +{
>> +	struct dentry *d_new;
>> +
>> +	d_new = debugfs_create_dir(vendor, iommu_debugfs_dir);
>> +
>> +	return d_new;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
> 
> Why are you wrapping a debugfs call?  Why not just export
> iommu_debugfs_dir instead?

It was a choice, as I stated in my other post. It is not a requirement.
If you resolutely reject this approach, that's fine. I'll change it, no 
worries.
