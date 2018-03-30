Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbeC3Slx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 14:41:53 -0400
Received: from mail-bl2nam02on0089.outbound.protection.outlook.com ([104.47.38.89]:45216
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751322AbeC3Slv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 14:41:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH 1/2] iommu - Enable debugfs exposure of the IOMMU
To: Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, jacob.jun.pan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <152236384612.3266.1451709369164076985.stgit@taos>
 <152236408441.3266.6015804200548808265.stgit@taos>
 <e6aec192-030c-5942-16fb-02553467c8a3@amd.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <f372c5da-97c0-8029-b402-72072472d9a5@amd.com>
Date: Fri, 30 Mar 2018 13:41:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e6aec192-030c-5942-16fb-02553467c8a3@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:404:121::14) To BLUPR12MB0689.namprd12.prod.outlook.com
 (2a01:111:e400:5950::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 923be820-3744-4df4-1534-08d5966de53f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0689;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;3:A8OD6kakKAmFlieA4HLB/rTVPbsK3Z++ddWkLZI4QN5llLgZuqX0hmCbJsdDfnkpuTRohymn4eVIi62HXgCA4At9d/tPzZ3o/kNaKQZj7JVDABExHISxpX2zB+7ICpPE8J/KM6Ys5bl1T246imryk/vg29LxFzQWLFwMkHE6VQfV/d8ISsiCAIvLUqKNCK++OSTD0/Lzb89QkBAlYJKcyUz3lvCKLMVtmDv+yotz0quXelz4a/uXBB45THr7SKMh;25:+Y6IoRbW361IUmV4Cu0+Kj4/XsnSIpHDVDezqoc/eYbPaeu4Z3vjKoeeSsBW8NJR0EbWj0dNrRGu8xDqlVfiK3gQ2J2fIibCj06p8BYKm2dN6NebsjxXqN3ZZNC40uywwxmH9TQf7iNq7gjD+iL4TcO2A2doOimuyEzIFUhO9HfqtIEBN4MMkh7TbvwsL5gJ4aF5/f65Vs8wshEm4tWP4R4OLHS/zx8bDXGiVj+27N5sMEtwFW0upZH9qLqUmG8XuXKVtTO+9DEd/sNd8/bxUllYIBGEUDg4pafbyAwIp2CZSjr2nTj0YbA3Lj7pmQOnjzp60Gi/XuQU/95xgjVI8g==;31:0U5LMlK2muEwVtFfGtgvJ3Jskf6yTBYMwpQXL++QCOZotXrTfAYGvFelqDaXze3d5Pgaeh0AQ9K7Nz87XmUZRgGiTU2TsJAH75m5UMBQsF2CKv+RLfEUFVcq7VTEthWe5w0kVO/IEurQex9pLn1Qqy1EBoW+s3/QI3nFbb1xVhq7jIgRijGU1WEDatPr8lQ1OVmGk1es/pYWMXMkgFF5EVAawSyYnLAM7/RSh74XX7s=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0689:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;20:z5Gpho39T7dKzpfg4aSkqRyB0PnVRXkygPNEXUeTciJz33TlqekbqUlxj2/36lABn/cI+59luOKEkiBdpSnoOxYwGG2fhGTbVoI31cZRSUmhoqAFP5yIT0negxyPURbESh2/V7NlbTVafh8ZQXf+prYBVCRLh3Fz3SIv0FtBYZpedH0XD1rr9S4LdmGUp70sqTSZZn3vLWnRhEpsQAh9E5gM2Ui9/NAqxX2ORYRB2cVHEl05XEmX8bQ2826H9aE9l+5KdDbDCO0MxjZ+0tqrHvfoA6rtN16RzBsMwBdDkQBLcfoTr5ZZ8zLUNx7Lu+hoWz/pwZC2+YgoHQh9+brnVKoSPaKyiSnhmXxd24uQ1zi0P2uOZYulL2ryAoGZ+uYrx161ZAtWuEcSnyuhCab2pEdXIRI99SkJAKoKd3k49TdoWysdhcbw7fk+LuvbQtKC6tr3R3k/tufbWv/dpKyVpNVsyMcA/0QIxVFD13xNxDuu+Aa62o4OgNOV13veOZhu;4:ca5SAcQBJRSt5XMl+ocdme68utTv1HXEiUXPibHVytguR6BdBVK59jDYmdr/JYCNpYz5Z4kRYeC6HCLYeuEhxpYJyp9we4DXdPDeMelxlJwl9k3/80Nh9xH806l5b89xmsmKxSUChVl/LZ0iHBecmmtuDJuggWfahALiGlxNMstzMTAroM9fZ2Dz/E5dUl64Y8RcXIQBUGaPeGiMBV7eTyrEaHEVnVALfedDcuuUpnWdrEvV89bOY3iutiduBFyC6e5eyPfSUt21BjkrRWfWfgZ/DP01B659DwbYOfxMAKK18k9bW3xgnu/yGNUrIXy2
X-Microsoft-Antispam-PRVS: <BLUPR12MB0689F42AE5BE2C79A1557D8BFDA10@BLUPR12MB0689.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BLUPR12MB0689;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0689;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(366004)(39860400002)(39380400002)(376002)(189003)(199004)(11346002)(86362001)(26005)(446003)(77096007)(65826007)(5660300001)(52116002)(25786009)(67846002)(6246003)(186003)(16526019)(6116002)(2616005)(956004)(476003)(4326008)(64126003)(486005)(50466002)(53936002)(6486002)(486005)(3846002)(2906002)(2486003)(72206003)(31696002)(229853002)(8936002)(478600001)(66066001)(47776003)(81166006)(8676002)(81156014)(23676004)(52146003)(106356001)(7736002)(65806001)(65956001)(305945005)(36756003)(59450400001)(230700001)(97736004)(386003)(53546011)(105586002)(58126008)(6666003)(68736007)(76176011)(31686004)(16576012)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0689;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjg5OzIzOkJ3Zk1zVE1IZG9HSmNJcXMxSTNkVjlsb1U0?=
 =?utf-8?B?ODlxeC90NTk5UDN6NzRuS3BOWFFHbUkrNDFUbUdhY0ZpS2Q5VzQzNmpNeVZT?=
 =?utf-8?B?Y1ZQa2YvV1BXZnAycUl1VE14bUkrcVFadGdSM1hRY0NlWTdXNlh3OC9tTU93?=
 =?utf-8?B?R3RhSjBYWWlKcytTOWVTQTZtcFVvZDIyay9UQ3VZWjBjTE4rOGIzUXphVi9B?=
 =?utf-8?B?ZFMrNFdIMkZoZXlHaVh0eEk2SE5ML2w2RjNQUGZ3Z1hsZS9MeGR4ODU0cEYz?=
 =?utf-8?B?SVM4OEFMcUc3QkdwcVRpV2wydEFXTnFWenBjam9RSFFadERTMWlQZDlFdFYz?=
 =?utf-8?B?MFM1aEtDNi9WWmpQcHJpd3dPS2xNUExPK3NsUkRZWjdNeUh0aURVaEMrL21W?=
 =?utf-8?B?Ri95V0xUVVp2ck9EVXZCV3VyM2JXTVNKbktDT2ZxcStDZjEzTzUwSjVMZHdq?=
 =?utf-8?B?czVDQ3F3NEJjWm9BZmVjYjZhdDdQZlFtbzYrODByNWNkOHc5NTdwTVFvTXJN?=
 =?utf-8?B?Tnc2bzdwR29GSDA1bzBkZTBoZm15a3RpWlJUdWM3UHJVMHcwK1NGaTd6aC96?=
 =?utf-8?B?ZGVVRGZkdUxyY0dCeTMwUWFCRURvbitEbzNhR1JOOXJiM05UbU5zekZ0SzlL?=
 =?utf-8?B?M2h0c0xkcTJSWVNTSkJPeFlnS0FRMlp0aWtCeXZDanhWSm9EaytDOEIzVStN?=
 =?utf-8?B?OHI1OEVRVW43d0IwWWo3ZjIyeE5acUJsK3Q0MkQ3R2RnYlVxNlkyTk9uSFJD?=
 =?utf-8?B?emJxOUlzd2ZzdUt6T3JLT2ltblVPOXQzZ3ZCV2hBVmQ3eDZTdllEQzlCWEpp?=
 =?utf-8?B?UzA4cExVODd0MFVBMUNoeDU0cmkybXZqNDM1dEd6TmRkSGc3VVN1WG1GZzgz?=
 =?utf-8?B?ZURseDQ3UXdjb0Ivc2QwbTB5YTA3Z2ZTYWJ0ZENOWEkzRUdtVng2Nlg3V0RS?=
 =?utf-8?B?K3hUNkVmWlYySjdIM29CZncwL1hxc2ZxWEZDTGVoMisvaVZCeEdQMElDQUZM?=
 =?utf-8?B?cjM5NmRBYzAwMSsrNzdJY3dNVkNyWGZRQTM2RkhpOTV0MFoyOEpFazlRaGtR?=
 =?utf-8?B?UGV1ZlhDTitNZ3hiQjVCZU1EQkh3R2E0akJxVTJNYXhrTDhvZjFhTWgxeGRT?=
 =?utf-8?B?UWNDekdsRTM1U3dVU01zalhYbEFHamtCVVNrTWxDdmtRQW5kQ0FNRjdrZXdT?=
 =?utf-8?B?Y2NMa2F5dzFXeFB3dVNWQXBUQ0hISFlqZlpHMDY2S1o3aWpobCtNb25JL2RU?=
 =?utf-8?B?ckltRjdFNzdUNm4vS0ZDVkFIWDFuNTAvcStOTFd4N2Y5eFk5S0VZMjluMkVK?=
 =?utf-8?B?ZWJzTVEvYmkzRVlib2hSS04vWDBlWithZCs3SlBHaEdRUUcwUWZ4cjlYQ3VV?=
 =?utf-8?B?am1EdWRuQUNsa003RXpIemsyQXN4MUZQTW1lbExpWEpIKzh5YzJrZzVEV2Nx?=
 =?utf-8?B?YmVYUVJFV0kremVVdVJISTJGZGR4cVFhU2ZhNDVuK2o2ZHhmT0g3czlqU3gz?=
 =?utf-8?B?aHFYMUh4VW9sS1hjUXJ0bk5FZFZXTWhLMDJwZTJlZHdhelZZajc5OXQxaWlv?=
 =?utf-8?B?WXpjTG80eWRGM3krZUpiL2YrV09nM3FERGNVZlkxd1Zwa3FqdkljKzBYQlBz?=
 =?utf-8?B?NnU2NGdrcUpsWlRPMEQ3ZmRyeklwN0R1WjBFZGVkdXNRczVDZHB1UHdtQ2tK?=
 =?utf-8?B?OE5EOVFjV1kwTzFHRm5GRThpVkZiVi9iL3l5WmNtYmNLZ0ZvUGVtV1dPbWdU?=
 =?utf-8?B?UlU0L0tSbXY2Q2d3dlYyZTFWcW0xS3BscmdQVEswQW5MSHpDcUw4dmduQWlm?=
 =?utf-8?B?ZVFKWUIyT3JQRUZwNGxDSzZOM1hUeFlLaGU3ODROdTBFRkNhTHFRN1lZU1ll?=
 =?utf-8?B?YmlOb0tOOGN6ZjRrc0hvMHd6MVBpUVUxL2xLZUJtR3VXdlpMT0hRNEZlZ0xt?=
 =?utf-8?B?WDV4aU14Vmtkbkp0S0ZyaHBZZXNUaDFTWjAyUFJtdGJGQWVLUWJQeTZnL3Vw?=
 =?utf-8?B?MzJha1lxcUpNcWFJajN0eWt1VzA5ck5PZ0xBZz09?=
X-Microsoft-Antispam-Message-Info: uTU6bhgpeT9NQPmYo2eJ8mSBfVL0hIHRu9Cms/NCHOuAOP3gqtl3nQCkLbAIAb2CxNftZYw+Qw9ebgFUwnrKKUjXG8nbdSNYwtXTjvx/hELxgGBj/jsMGSnLYpIReGjUrmw3+Xk2zRJiFUwSg8y1cw3ZkwXTp0MM+l+k/409fGpks5SZqqMInPlVLpgvnPh+
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;6:g9n6j3xkxuv3wyJoW/cJrnHfF/MsmBjop2x9OXwMRecm2amFcynt/UQ6tvJSgpDIC/wMRZSkQ2s34RLAiIw8GtoZbmHreUuqEO8W2SdXCYL3PXj/8UcYdB/T0h0Unl6SBkH+NNK8bErCb3FC+gVEul+e7uSPaN1dPyTb4J8Y8EGOCXwBhKRWsnED0IXaR0tgkL6DwY3pOCSJAg+ed4OGhDDz6g8oNlZGWOmW27DxVgFgtF8ZMuIOchPiKL37dKcpwZYYZd9cHRUnfK+thuhdLWZ7NDdLNmNz8ltXqSBEf1Ijvt+2EEz4OJ/vviAWo0sJ7TNCORFctX0bmA4GKldHYM19JBjJ7j6c/eBOU1XTj3y6zre0siEgt4KVtD/LRgzsvDcKL01Vstxbo9DC2BoEGdkiZoJ6v+ii7MUhvkuF9NL7iLBpCu91x1XVf5Lknu+j/lZUkpo9KdzXoQUn3oir0w==;5:9XfzvDc3Mj+qyl6mZpP4Gbuf073ka6iZX8j5Y4HN6ijXvibxBPrfckE56nj+FIQTG3LceJ7fF7wb5H2lqdnS1SzlBkrFrGY16yrZV7s7/wp9ZnYUwc7yE16CeofGlNC/XPBge6FGPDxIsp22MmLXr99inYyRkskYJFVfU67p2Bg=;24:mfKnuEV67UUquNp4ji5HnA/jQMfQSWUILNCvQoJ8nt8F33e4X6RO8TBv4PSKxr24Agm9M8e5Iz4BkWUMU3tUIK6yKztR5kKvfe9bZv6NttA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;7:7TZdRWJSQggEa0nh8xVVKldDH8j1O8gXxRIaelbh4/ycBwEtRcQ4J9IhfXmcMRzikBjPrhIYCMTl9cUVgXgUZLQ9f09eM+VsfuPKibBNZlciwgCrjiFzpFcTyC9/8/W6jxIMNIeP0Yi4xM7t8VZzWHBFucBYo11V1bJLcEQ3r5+Ko0CNR9pRf4DY8ILNMx4PXXYglqCDmqqGy2nyhf4SdCV4s79TjwXMtNE8oDuxMBAC/q31iCAk9N4l2EVwAGxP;20:02krVcmH7U7pbYTl6d159W7DLB8J3GUcjBI0T76tcbKJU1Rmr7ikx67O2bbpC+35egOBSnZ9ZbEm8eLbYhTt533gDVfgLNhGtpA7LIaQD3B0X6V5MmtmdqzWBHNHUb3lQKGoXcke7rx4SWdANoT2LG1qaAy92VHs06VVdwL/kK/Wj5wB8QPQKJdGfJw5vaEye9/D6IzJL/95nVXRC9HnX7Fo2duvvqFHNhBEbPL6EDBCeAWoDE+fvv9wqkLaE0/P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 18:41:48.0988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 923be820-3744-4df4-1534-08d5966de53f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0689
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/2018 10:57 PM, Tom Lendacky wrote:
> On 3/29/2018 5:54 PM, Gary R Hook wrote:
>> Provide base enablement for using debugfs to expose internal data of
>> an IOMMU driver. When enabled, create the /sys/kernel/debug/iommu
> 
> So this can't actually create anything yet since nothing invokes the
> function.  Maybe describe how it should be used by other drivers (and
> probably include that description as a commment for the function) to
> create the directory.

Exactly. Given the approach I took, it takes another patch to take 
advantage of this. I can certainly elaborate on usage if we agree that 
this framework is acceptable.

> 
>> directory.  Emit a strong warning at boot time to indicate that this
>> feature is enabled.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---
>>   drivers/iommu/Kconfig          |   11 +++++++++++
>>   drivers/iommu/Makefile         |    2 ++
>>   drivers/iommu/amd_iommu_init.c |    2 ++
>>   drivers/iommu/iommu-debugfs.c  |   32 ++++++++++++++++++++++++++++++++
>>   include/linux/iommu.h          |    4 ++++
>>   5 files changed, 51 insertions(+)
>>   create mode 100644 drivers/iommu/iommu-debugfs.c
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index f3a21343e636..c1e39dabfec2 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>>   
>>   endmenu
>>   
>> +config IOMMU_DEBUG
>> +	bool "Enable IOMMU internals in DebugFS"
>> +	depends on DEBUG_FS
>> +	default n
>> +	help
>> +	  Allows exposure of IOMMU device internals. This option enables
>> +	  the use of debugfs by IOMMU drivers as required. Devices can,
>> +	  at initialization time, cause the IOMMU code to create a top-level
>> +	  debug/iommu directory, and then populate a subdirectory with
>> +	  entries as required.
>> +
>>   config IOMMU_IOVA
>>   	tristate
>>   
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 1fb695854809..5e5c3339681d 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -2,6 +2,7 @@
>>   obj-$(CONFIG_IOMMU_API) += iommu.o
>>   obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>>   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>> +obj-$(CONFIG_IOMMU_DEBUG) += iommu-debugfs.o
>>   obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>>   obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>>   obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>> @@ -10,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>>   obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>>   obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>>   obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>> +obj-$(CONFIG_AMD_IOMMU_DEBUG) += amd_iommu_debugfs.o
> 
> Where is this CONFIG defined?

That, my friend is left-over cruft. Please ignore. Apologies, and thanks.

>>   obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>>   obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
>> index 6fe2d0346073..99d48c42a12f 100644
>> --- a/drivers/iommu/amd_iommu_init.c
>> +++ b/drivers/iommu/amd_iommu_init.c
>> @@ -2783,6 +2783,8 @@ int __init amd_iommu_detect(void)
>>   	iommu_detected = 1;
>>   	x86_init.iommu.iommu_init = amd_iommu_init;
>>   
>> +dump_stack();
>> +
> 
> This definitely shouldn't be here.

Dang it!

> 
>>   	return 1;
>>   }
>>   
>> diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
>> new file mode 100644
>> index 000000000000..94c9acc63b65
>> --- /dev/null
>> +++ b/drivers/iommu/iommu-debugfs.c
>> @@ -0,0 +1,32 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD IOMMU driver
> 
> This isn't the AMD IOMMU driver.

Again: dang it!

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
>> +#define	MAX_NAME_LEN	20
> 
> This isn't used anywhere.

Thanks.

> 
>> +
>> +/* Return a zero on failure; 1 on successful setup */
> 
> Return NULL on failure, pointer to IOMMU debugfs dentry on success.

Roger.

> 
>> +struct dentry *iommu_debugfs_setup(void)
>> +{
>> +	if (!debugfs_initialized())
>> +		return NULL;
>> +
>> +	if (!iommu_debugfs_dir)
>> +		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
>> +
>> +	if (iommu_debugfs_dir)
>> +		pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL\n");
>> +
>> +	return iommu_debugfs_dir;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_debugfs_setup);
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 41b8c5757859..cb2957dac43b 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -696,6 +696,10 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>>   	return NULL;
>>   }
>>   
>> +#ifdef	CONFIG_IOMMU_DEBUG
> 
> Should be a space between the #ifdef and the CONFIG_..., not a tab.

Roger that.

> 
> Thanks,
> Tom
> 
>> +struct dentry *iommu_debugfs_setup(void);
>> +#endif
>> +
>>   #endif /* CONFIG_IOMMU_API */
>>   
>>   #endif /* __LINUX_IOMMU_H */
>>
