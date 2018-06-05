Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeFEQsv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:48:51 -0400
Received: from mail-sn1nam01on0086.outbound.protection.outlook.com ([104.47.32.86]:33920
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751744AbeFEQss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:48:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v7 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
To: Greg KH <greg@kroah.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
 <152631842046.18929.1205439632866632871.stgit@sosxen2.amd.com>
 <20180524091807.GA18148@kroah.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <68d7f040-fc7a-5eb3-342f-687fc6e591f2@amd.com>
Date: Tue, 5 Jun 2018 11:48:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524091807.GA18148@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN1PR12CA0087.namprd12.prod.outlook.com
 (2603:10b6:802:21::22) To BN6PR12MB1442.namprd12.prod.outlook.com
 (2603:10b6:405:10::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1442;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1442;3:MSWnda9sq7olcUEVWAv6aMdA/iH9NbfeDgh0YeIKnx1HLKVydbSRo9Ux+fkR96vqx5jctJQW2hVWAlCMJDxlBt+CSs6KAWBjXgCqHKn4CZXF2IsVtKRBI4jfGoiyrNpv9nL/H2EXms7S8YLMIqbcQTcGVfkVgjdynvsyHal1jK4hezGzvGQqFRPnxF8sTHxyDzMGnDdHu9mC/bLvqDOU6U7aN5HxFUzsuC/kqCxA09kIKa0JItJlnJFKoWZ7O9m0;25:RaHNHz0kxGkwDdYcv9EsfocdIPbffa+8JSVpTLVBrmPoiDtaI6wUKQ6qdRT9IFpLXBRH2J+UEPDyKS0wjHn9EinsHSH8udNYSSmcydBiN4y1AH3JDGwUugqhg1jSmLwwK6fXY58MsyXX/kbCWEN0FyCIs550UGq1IcrIIVQefo4NYBePtUQryDvtrSvkf4b4wImyEYzgHGYECs28xOxCALqjk5/Nsa1tABwoL6RqmU+SdmTVVQfgtPmCh/0oqxevH+qtp/UaQntWNd/0nDLob12A9uH3dpg0Qqkd6OFD7CuT5BlTLS9WDT9G8V7q4jWC4JjbswsyrkyK7ArCVVZ2WA==;31:5YvPCpI5GAN6c+ypMR2N4o2JwUFEmkiFQll8YdD+oT2xxND9O8g8nX13hK9V14hktkFnLfAFK8OY3LXkETCGyKgCtwL9L30j0ACqcn7SWsugbeNuUeMPqY0hE6jaju+gpHcqDWRpSXToi4lGcltTeuEpIdA/uva6wDSJo92TcZ8wxfNcs3p3t/FaXcI6PvpJ2tkKy78xGIuNxEFOGEW48UL045tquFjhtp4q69VfhKY=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1442:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1442;20:MPhHFh6fx+vB4kHaf+Vsj5V1+FC5f7Cu/eh54WCM/W1qsFbxx3ImaQQj9+apVPPHsTr/Q6udUgCIurj5+E1JHutiu+gKMYNW4b8+m08znzk5A6hPKV2Xy+dfEyeHLkz8z8VO5NMLROJTbuFLtVbAKcsMtN1odQDSZniZRhn0vaWVLqs7UZPntzHRfdl7JgSrIaLDEVbAm+8uNd4kRx1jNBoE5JsqMyLz3cqMaMy/ZwJhbWGnHGwY3vdLOZnsLsm9Ma6RLHsm5+AfIqwAdpNnv9/SgvPMfL2qiWdQTiVk7FqX4byYi1SEZEHU32Tzl2v8RNmwCQdUWZphUhhaJBVDVZZj7lPD9Rnm/LWb4it8XGrnZTVJP6SjUtu79AIPUybBitXA6M5KIjAWtivcjzb6Jf8Flbn0CgQcRaJJUz2lrOyMC0u9M+UAuLGqD84wd+GxSoK3ioEc4Gg9lsDx3zGRq+BB1BdHV3UoSq6EEBDX+b9w5EJTFmqhMeHSb8CPW5qF;4:hhxnhmFCtSDi0y6ObhqAbV/xgMrPZnUpI8mb+OgBiNkwiZFIhUQMDzMM4QPFjzuT37bCAcuUlqlLWnYhUKCj0XAErPnAXIeouDC7W1V+IVOt6qiwEkF2mZS+/l+dC80LC/IOdKBhwdEztHWgmDFAlxQKC/gmsBVcHRM1vMQARRfsf8r6Ia9AGkkSkK0pzj0aBruJAtR/sbrH/0j1PC9bmNf+6v79l768dvcHOVTIzIyGxiZXgRuLICTjX+wsqwni0r5E4lLwvScdC0256n5h5FXQZEHlCzCJr6ebJvPkV9lcUUAJDYPY7BXIf3VVZcUE4y6b69rwQ7RxbWTxLVOgyXZhfB1ibIVk/8Rfjxkl5L0=
X-Microsoft-Antispam-PRVS: <BN6PR12MB1442FE97A0C9A7338F6A1F61FD660@BN6PR12MB1442.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1442;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1442;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(39860400002)(366004)(39380400002)(396003)(189003)(199004)(2906002)(36756003)(16576012)(2616005)(476003)(58126008)(316002)(7736002)(53936002)(67846002)(956004)(6486002)(11346002)(446003)(486006)(52146003)(4326008)(52116002)(81156014)(8676002)(23676004)(2486003)(5660300001)(65826007)(76176011)(6916009)(53546011)(25786009)(6666003)(59450400001)(386003)(186003)(26005)(16526019)(6246003)(77096007)(305945005)(81166006)(8936002)(97736004)(50466002)(31686004)(575784001)(47776003)(31696002)(64126003)(68736007)(6116002)(3846002)(72206003)(478600001)(229853002)(65806001)(230700001)(86362001)(66066001)(65956001)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1442;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNDQyOzIzOm14MGtrUlIzakNjSnd0ellUOTlENjAycmFQ?=
 =?utf-8?B?NjlPb1luNDNKaW9jcURGaGh6akdVUEppMVdCZGNpT2VTeEtTS2hQMk1nK05Q?=
 =?utf-8?B?T0lXQVpqSGtYUndxSkV6a0pka2dkdW5xeUwrcnI3ZE9YUDVJUlg4VmVMMDJZ?=
 =?utf-8?B?bWlyazloM3NVaUMyODhvNTVrV3pLRWxHN1J1UUh5VWdPSnhOQnAyUkh1bTVn?=
 =?utf-8?B?RGtEM1EvWGwxM1BlT1B1eVVHZ1dhcC9LWVZjU1BEL1IyKzRLRmR5TUtzZ1Zw?=
 =?utf-8?B?aTNrNTBqNzZJaXNLVkEyTzd5Y2t4UmNkMHdVS1dKZFNXM2lGLzZkSkp6MTY1?=
 =?utf-8?B?a0ZkMXBtcnpNTUFnSXVIWFcrN0hFcXRINm5BRnNyUS9OM0J0RjhRNldjb3RH?=
 =?utf-8?B?WjYwQzdTOVNqMzVkZlhVTm1oMDAvNTZSbGJURzk3bmpLTXJBQk44TzBIRUIw?=
 =?utf-8?B?RlB5ZEJyTUg0L2VtYU55MUNESUd1cU1iZHQvL3dIby9ZZ1A1eDdXUkhIa2pW?=
 =?utf-8?B?S1E3TTFLM2xkL1FxeE5vOE1sR1MwaFRXUWwyaUUydU5ySWZpT25RSlMvMUg3?=
 =?utf-8?B?UVRldDc3V3Q4Z29JUUpPWWRZa243MHZIRnE4S05lczQvMSt0RHdjbnA2UnNv?=
 =?utf-8?B?a0krSEU1bDBvWHhJS3U3YUs4Rnh0ck5ZZG04NEZFbjZDL245NDVZZUhweWV0?=
 =?utf-8?B?NUlrdEFsVXFxRml4VVIwZnovNXI5NTVZem5UbXZTNTFhRzFxbkwvMFRjQ3dN?=
 =?utf-8?B?cG05cDljVUlpd3FOdWFNMWZ5eEpLQWhxVm93azRoTlpKandjaWgzYXRVdkoy?=
 =?utf-8?B?Q0d3QmwvMGJhUE9UbExOSEtob2FRbVNwclhtMXhsQm43VWFaRytpSGl2bUVZ?=
 =?utf-8?B?WlFEN2VyUkZQRkxMVG9Lc1FFRUtRZnBIdkVDSVJEeWZOQWlURC8rdTVlTlcr?=
 =?utf-8?B?QTdBVXRJUkNxWE5TRnFHcEpaVjZRMzg1US96UFVPMm9KNlArSTR5ZmRGZjJu?=
 =?utf-8?B?THlyaVFmdFY4YmNRQS9ncDZCaFF1VnZxK3hPRHpJU216dVB5TldIbzlUTmNt?=
 =?utf-8?B?Z0dzMXdFemJqTDhMNmFMNGFpbC9qdFQ5dTNuR21sQkdkaXFFeTdXUDYxS083?=
 =?utf-8?B?NVRMN2VucW9tVXRZTVk5RE05Q0J3cFVaNzk0MW4zdEpRaFNiVjh0c3UwNTRE?=
 =?utf-8?B?R0g4Wk1lN3o5TnhEVUdnZE9BKyt2cWpsOUtIU0R3UHFRRWlaZFpoRzhCRERl?=
 =?utf-8?B?cFJsY3lQdVZONlgrSFF0Z0VqanR5RFM0bVlIVE1PY2E0RkQyNkhqOVBva29E?=
 =?utf-8?B?Y1FrOVlNSUp2d1RDTEZBU01VS0xCRnE4L2p5UlIvL1djdFhZejZodldsMWNY?=
 =?utf-8?B?VWU1ekVHMVE2NjR2dURldWhVVFNBUGxsWEdJemJnZXprSnJaeFBNZDlPSjBa?=
 =?utf-8?B?RUJwUkNlanNTaGF6bE8zV1hYbndsSXVwSHhib2UyMEFwdU9Hd1RxYW1WNkVm?=
 =?utf-8?B?WnUybjhBNXduTGZVemR2MDJ4ZE80ODN4dzhZTjQxbGtoZWhwMHNHY3djWDVk?=
 =?utf-8?B?ZzlpOFY4MTQ4L0hOSWRCV0VIanVjdmc0UmNmeWd1QjNiVmVkbWt2dURyOVNS?=
 =?utf-8?B?MHlBM0E3S0V5QTg2NzN3MmRXeS9lM2pGQWxtNG5kSEJtVDNPckZVY3RHaWx6?=
 =?utf-8?B?Vk9aL1lXL1MyczFvOEthd1V1Z3RKd2MvY3lHQ1Z3dy92dzNGcm9TVlJTdHVi?=
 =?utf-8?B?RHV5a3VtQ0pteW85a29nRXhRVGlvSjRJKzAwWnIxTWk3YlQwdFZ1dVZKNnNQ?=
 =?utf-8?B?SUZiRjR1d3gzWklZWFhFZk52RDA0YitXNTRTZXZWOTMzQlJXU3IzL3BBbEsz?=
 =?utf-8?B?NkN6MWNJbVZCYXl5YUhOOE5pamJMOG41emJoUXJmZWpTS3ZNOHYxdEpVMkwz?=
 =?utf-8?B?Y3VLMjNhbHRqTkxVQkVFY3ZRdHNEM2RvR3BWajFtdytGNHFJSGx1b05GbEN3?=
 =?utf-8?B?OGJBRVlHcTFtbE04TTgzTGs4bjJpTnJCanBUN3gyTERBVXA0dk9tcUd5SS9H?=
 =?utf-8?Q?2xVg=3D?=
X-Microsoft-Antispam-Message-Info: +2VBvByjFrd9qdXLbcRoJiQAx01di4t56PHluDb/ZYT6hGU2PTgHAOcL3EZsmO5PJB+CdE+6gkHqrbIyND1GPKZ4EYzz8fsPgr1bjrt/csQ7njRpxLbljVkCmNxNtH9Z7P19v9fuxDIweYiYl3yPS22IqoLgOXudfmkSU7XgmXvDkB9NWcYkuXEiJ2W6GsjY
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1442;6:PSgtq4k79QbXqoE20Ho0gzpe2AyxQMvnC2cPi9rxk+HgXuW6CcSe8ufQopHOt4NUb7oUcLIcQctcFFCXneJI+pdiWraWt/qPZFyDYOBqJednvwn79NEOf3NcdAgQ37dbqH/Q+zA6Iq3eJhy9hL4lNWhoODVRiXRyuIvaVC+5my2LgpyFRwbM2r/2CQ9whdEVitamXUnNnKFg2uo/dJQinF55tiMjVqLwgxqi30llv2jLzGrpgAcXoG6Hc8KMSVkRjdSkSq+Ero9RsPIn6/1hbwo0bHdj0Y9Tn/pHEMh1b29SytSpiEwJARhcqlXzGZKmrkpQtMVZUqrXMi5TXBfg9CxuzYFD/KhMFFJ0GTG2AZCZzK5cwi1kJRj6GzRIkiZzdF9V7383HgURRESFh5n+q9rhAiDb3BRUbDmN3IruqoatSjlqq5x3Nd/D2O1dDZNS/yy031Nj9tl67/VkG2btcg==;5:I2wnwY3rAr1yyZ8Z2Q0g+D8ZDbtN9gQ1n7K+k6/j2CyvDdt1Q0bV+RhkQCR7FXn//f4pAteylRQL9PhmyG9/RgWm9S50oa1Lz6Pfsm/pxbGFDCQuLo1vsolYJWsooQSJX22jIM55zJR2MqHbIEHnAVT0SQyn+l49S5SaS04OO2I=;24:OFxkBjjacgupGywkuDYxgRy8/n032D0PwPezEjh2QKFt+DxAFttEF0z2cO6rLlLgCRYZ1X9EjMktUTPmQlfLeujYvsORMKY5NUjBvgY5CP0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1442;7:sWMAyMmWVaZxwPJAEMnwflz0J40yxolnEJZjDltj2jj8KpwLfuRCQdXNAYYgGHFb+hVz68UApYby2zhjaAuSbu0YPSVqidDd1Ai8R+fyMLFMInoYcw3/4JNHsYCbhFNKfuB2BZrKnxy/4mU3q22FaBczxLrrqn2QS5HkqqOJ2yTAgHWRsyfx3N/eInqW94bd+Fd7ZWW0WvZcbKQlDSNvhBZQUuFB3sTvSv0q8hvIoTaphjV0IeWquCenNWwHAgI/;20:6uoaWxk879aEsfH9EwRAY3xlKg3aRyBheLyYeY7hBSFKkbq85MKNxB1dWZHkWiOLVTxn+pxWiVLgXs3LKoNtikJyOX4HCVV7FRzhMyxI1Ej5P0N9hnUFVHWPxd6wC0PPsCWQNpSBxXTkaJBvaSX71c3S5J0eLNhApaxZAl1hnrnC9devR/A8iFLJ+oJSveQHLkDb6DfTJpBOYKR6+lHI1BfDdcyGIUe7jLVMH2GT0JLsRR0/JGWNWYmvK+lAAlua
X-MS-Office365-Filtering-Correlation-Id: 00d3e9d4-ff1d-4baf-4cce-08d5cb043515
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 16:48:47.0866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d3e9d4-ff1d-4baf-4cce-08d5cb043515
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1442
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 04:18 AM, Greg KH wrote:
> On Mon, May 14, 2018 at 12:20:20PM -0500, Gary R Hook wrote:
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
>> index f3a21343e636..2eab6a849a0a 100644
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
> You need a big "DO NOT ENABLE THIS OPTION UNLESS YOU REALLY REALLY KNOW
> WHAT YOU ARE DOING!!!" line here.  To match up with your crazy kernel
> log warning.
> 
> Otherwise distros will turn this on, I guarantee it.

Apologies for not seeing this. Notes from Greg have been going to junk 
mail >:-(

I will add this text to the Kconfig item.

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
> No need to care about the return value, just keep going.  Nothing you
> should, or should not, do depending on the return value of a debugfs
> call.

Sorry. Some habits are hard to break. It just seemed that if there's no 
iommu debugfs directory, nothing else needed to be done. But plowing 
ahead works for me. Thank you.

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
> 
> This function can be reduced to 1 line.  But really, why do you need it
> at all?

My intention was to not expose the base dentry. Which means that drivers 
need to call in to this file to create a vendor-specific subdirectory. 
At least, that was my take-away from the discussion. But you dislike 
this approach to the code, so I'm open to suggestions. At the very 
least, it's now a one liner.
