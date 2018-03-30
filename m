Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeC3D5V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 23:57:21 -0400
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com ([104.47.32.47]:28928
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751976AbeC3D5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 23:57:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 1/2] iommu - Enable debugfs exposure of the IOMMU
To: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, jacob.jun.pan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <152236384612.3266.1451709369164076985.stgit@taos>
 <152236408441.3266.6015804200548808265.stgit@taos>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <e6aec192-030c-5942-16fb-02553467c8a3@amd.com>
Date: Thu, 29 Mar 2018 22:57:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152236408441.3266.6015804200548808265.stgit@taos>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR11CA0033.namprd11.prod.outlook.com
 (2603:10b6:404:4b::19) To CY1PR12MB0166.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea787696-8bca-4f58-545c-08d595f253fa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0166;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;3:EBER7uADaQGSLu4BdC/mNE9TdTeR2/2YgjCzXXHXSaKd+qWSOqMoiU5vnviOVP/2sdptG4X7ujpS2IhKAuDSqztfq7ZuhGHT7mRuLKnr3aCmRa2Q7r8KXouBKHI1LiQix+tUfHWpdCHHOexCxJITEzNRku9yiEywoYtERjnJBp06CYjXSl+r0xz+ONgsq8abrbwpdmjgMSOs5EGxGffXkCwZuLumPXmZcNiJhKW3QvIlMyEvU/pLXiHVs2B5ehSa;25:Cyf/N9t4QRs3VcyR3zjOV+MG00a5nrMR1wh0GSPSO6DtuG+lKfmC8UrhuPQ89zZWTopnXyy/rNk12tHTjBNSD6UEhJ9qASaJeHfupAVIusULY2133kyBaFY0kMvK0uqw7XsGCmrlWeZj2IycNhaM3H8y8khpfI21ngi0AJhxnLSr74JFs2nfywIx0KN3JeuYdzvN1TCRpmU7Hx2E7NTrYGTNE5malOdHy59jSo3gvJCsTegA3ktxVhj5WXfs77dkPgfjU59x2vwM/jQH0os2cPXhY8PVM8f6IvnWS5CgFYyWC3KHiOMWCSa1PJXeNQ+2uck3MCGfx33Y2hniBbA1XA==;31:x4suwi0aWA3z56irR6TM6BCqgkMhUbhav7nfd2t0RF2J8hQAclJnoYY//XRJVw6gUcpL1cNInvohCotie2NUnKUQOojlgVFv1KXTn+YqtLBNvzG8lT0R7eZoLlpRIVpyaVBmHnem724nNTqFiL0jkZRDI3SE77SdyEZbMO1oGGkMH3IFnGxF459zMyRQ6dfsWdYqi/S8mskGYTZkrb6ikG2sSlWlzZEd7+XfnlJBqgk=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0166:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;20:Vl2POuljU/KpVWhWeRs/tGL1YFcyGlLP534ITyipGEY9tPEfh1TnXAJqhKGSl0QHXy6MLQCznu7MwGEZ7xalk3A2JjKq01niTtINiRmCQqVVV5ep0sRBxl94iV7wyjjOOlSIjUiN1DO1gHLXas/h6TcYsAEiXHGWMwCcpfhLE31it4Q0X0N1OaI9UAEaDek0Q5Eu/b0VQJ1tTsorJgze3kQrkHCaz8uH0y0J/6aDBOq63ULemLZFR60U/mfTxO0tf/004WjjVYm1eOf98Ej4qwEgIKoNW7h+kI2I3LeaeGAYjS/X8X54ikngjTJiFIYbfNmN9og+bm58wpQKhgP4QKp7QMtMEXyWlwgAf1738p0uyR48UfTQLB7yyM/u8ThqtMwme8r+PZss22hpI5MDXQea1ZHLG26jj7ZyNbnhqdSFcB8n5UTqRayEnOpZ7e9jXZv0/RSedJ2K0k+sJbSEvJSIEgPLsmM51nmB+TKxucdGXSkjwSym4ORHZjQLlRLo;4:bJ8TsVv1AfI2qAGnqaCXqf34DaGXpDLg0uD61q/2Ut4ACgE25P2wiNNOIgJRlRkVHQ2etk+g4OYfb45f0QLeagO5KTbPf6giD1zDsUcdtnb1udCbtAXbD08VewdkDwIWVOVyXZV79PJhUPeuYleqTYj37ZtejNCOng3UCBc9iI8WKJFr8r8d4gSRe/OQiWx6VEf29w5Vga/IpUDe5CuPylsaiFpZkaeojowkoljR3UZppO5VLCtdRBm+9ZirLWyHyfyZ7C0xUar6bhVy+ujM/BN/33SfLAJW2kK7tHXRrouOogU/vl+F0XA5vGab74YF
X-Microsoft-Antispam-PRVS: <CY1PR12MB0166007341109C2112B0E0DDECA10@CY1PR12MB0166.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR12MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0166;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(316002)(6486002)(86362001)(186003)(26005)(16526019)(97736004)(77096007)(6116002)(7736002)(305945005)(3846002)(476003)(52116002)(2616005)(386003)(59450400001)(229853002)(76176011)(31696002)(52146003)(956004)(2486003)(478600001)(486005)(50466002)(53546011)(58126008)(106356001)(23676004)(230700001)(11346002)(446003)(64126003)(16576012)(486005)(6666003)(65806001)(8676002)(8936002)(72206003)(47776003)(68736007)(66066001)(81166006)(81156014)(105586002)(65956001)(2906002)(5660300001)(65826007)(53936002)(36756003)(3260700006)(25786009)(4326008)(31686004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0166;H:[10.236.65.235];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY2OzIzOkZMMGRUYmx0a3djblZOSmoxS0R2Y2ZGaVdh?=
 =?utf-8?B?SEFnT1NkNnpnMEIrTlhhOUs0M0hQUkNCdUE0d1locUQ5QmpxY2Z2MnRSS3dK?=
 =?utf-8?B?RjN3cHFiNmIxRnRValZMRkhxSUN2UFlGK3JMNkwrTnBjUUovUjAwR2duem85?=
 =?utf-8?B?SDd4bk1xL0RUMXg3MmNocWJOUHp3VGYxeE1UL1o0aEpadU1hNzdseXFGWW9W?=
 =?utf-8?B?MlZTUW83c0VzYndZSjRPNmc3aWMvRlFYcUZzcmdNTys4UnpYTW8xLzNYR1VL?=
 =?utf-8?B?SzZtUy9zQXJxaDFPUTQyemlscHRMTGc3dVpsOFFPeXZaWUQxaDFWSm84Z3R6?=
 =?utf-8?B?bjRQQ2ZzR0ZHWEpkUGRCUjJ2NGJqUXQ0MUduU3VrVWp1NkVGa3gvSHd3MWtn?=
 =?utf-8?B?NVVNV0ZHWDBQRmR2ektZTXIydnVLaFVWeVMxWWVZNmt3SlBEM2lvOTNpSUxV?=
 =?utf-8?B?ZnlJUDFydzVGK25CMG9MRWRvaUptaFRKcXVIaTlqcG8zNXhtUVNFUEs0clBI?=
 =?utf-8?B?T2w0M244c2YzWVIzZENjbXViS2hPWlFUdStWcjRIbnFhZGJneEZDQkYrZngv?=
 =?utf-8?B?UkE0c2g1TVRLaDZKREFCVHJYcUdiL2Vob2R1eG9xYkhXSHNqNWJmK3ZYay9y?=
 =?utf-8?B?K2NlQU5VMHpUeCtURTMzcmVsWFNxVGxIRkxOdm9vT3ZEaG02ZkVpSHg5QkFn?=
 =?utf-8?B?UmFzamxGY1JnL3I0UDBKazVKNWFTa1Q2Mmk2RkRrbnN6cnpIVzhBNXJTWktH?=
 =?utf-8?B?bENOQVVDa0Eyay9uaEhHNnN5UjlvQTVBYWIwUWpndGd2cU9wVFZIYy9yUjRR?=
 =?utf-8?B?WVFLYTVUMUViVHBkMkd6YlQ4ckxYQkZINHFPRjA3dmFZWmVJTUlMUDZnTi9y?=
 =?utf-8?B?cmZLSCtWQlp1KzVwTWpUOEVaWVQ1ZFAxZ3RtSDdvTXZYaG81S1F0anc2alpi?=
 =?utf-8?B?dHZpRWd4R1p0V0dQOGgrY2R1c3E1ZHR4RE93V1N2VjBxeFBNSi9JaG9OS2FR?=
 =?utf-8?B?MDh2eGJkTk9WcUx5R1NIclZhT3NoYXJzSjNEdHUyRXl4QzduKzRXU0t3WEVF?=
 =?utf-8?B?ZWpmK1ZOT1cvTTlRUjJjdWNDVC9MUzBCNEE3elpmN0RaUU5wb1JCSTdQd1dH?=
 =?utf-8?B?NTdEZStQNDNCQlJHV2g5NjVwcWVOTWpaR3BIQUZPZnl6MmRXelRMeGIyS3pw?=
 =?utf-8?B?SHAwTUhSNTU0YmFWUTN1ZXlTcjZMUms1Nm1FWEd1eUMzWHN0UHFDUDBRRk9i?=
 =?utf-8?B?L3poOHJQL1J6S1c1OXgwb092SzduQUtXTGxKd0JSMTM1ekxocnYxWjJzOFlt?=
 =?utf-8?B?UFFod28vcDRZOFlQRjRDUDNXUk1Ickc2S3BxYi9JVzdNN3RoaDJIRjdVWFdK?=
 =?utf-8?B?YmVMOUVIbXRkRW9RNGRQcFcxK2REaE9QOHJsd2ZkU1VGdld0ODc4anVsUVZJ?=
 =?utf-8?B?VE9RMXVqci9FZjY4cDQwVC8wWWpmSHAzcjdSVW55cnoyaC8wTythaFVOMDY4?=
 =?utf-8?B?QUhjcnlNUmZjRVVXU2w3K2tLbnBHWEt6NHhhVWFIM291cWJRU2hDck1PaFZu?=
 =?utf-8?B?QkNmS25XeERORlVFVkV6djQ5dTNabmcxN25NZU9TREx6WDNJM01LOUthUysx?=
 =?utf-8?B?d2ZwaU9UalJwa2VPQlBMaklSSkRpNjdqaFIvVjNYRmkrSkNMU2U3UEpKQkZC?=
 =?utf-8?B?Rm5ib05raEJEemErVVJKcW81MEJaTWdHUWpZbVUvaXgvSWIyd2FJSjJrdDNl?=
 =?utf-8?B?U1FHcUErSHpLUkxnZHc4VU43ejcyQWQ2NGRHblpHd3Z3cXIxVXRjdHIvWDhX?=
 =?utf-8?B?R1dZZkZ4dDlMZXFrcXFvQWczS244Rm9KZjV0RG9iamp1SmRGZHMxVEk1V21x?=
 =?utf-8?B?RldkY3R4M0laNjBFR0Vqa3JBTDV5NFc3Rjg5ejVSdHhyTEFqV3A5U1FoMmJL?=
 =?utf-8?B?dk4wSFh1NzdELzBsaWNYdng4SXU2SDE2dFliaXd0RE1DcE4vUytqTmZLWlcx?=
 =?utf-8?B?MTJma2FBaXZQcEtaZHgrWDFpZGpOd2JZS29xZz09?=
X-Microsoft-Antispam-Message-Info: O7IvHEf8Q3vMxtAGUhrtX/Xk8lM0hzdbhAlJUDS7KxoNwSfv6R5M8s5h/vNLhRGKNaEZXmQdoMGS9gsEvE5uqoQKCkzi7V/DLTyZ4FJg5MntOyx8Jqcn6AhK+4sX0hfL6l/XkHToREcn1R+95ZP669jLBeLab7x7df88QHz7jfuw4PXVbQARbWJXOgY3rEUE
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;6:gE58eOuxY663fOWgrjGgjANko9bg+oVPU8ZcTFF1USxgbsYWnQQvHfgq/Mpy7/l5hjGxXssKPlH7AjMUioAsIsblwJTNPeKOch10QECDFKDXUkaunNRfH+wq9yVHEkCSBZ1Y1Ua6vtQO42k78ienWW2HiakWpV18XjLkkB366yjccgZ4Mc/5+Yoyi5D1J0u452KsKP0ZyZqiGg64VA6REQgG08XHZgksDIRm6ABhT9opxJP72vkeVaEZASVNSz81mcC43eqCViC8/0E4tsAmhxRgeIhtkxLjwNKNcNyXLOjqrNQp9hxVWKKgNSQpdwVsY2/20CCggsiposmUgIUU4uXDQAhVDUNQWQGKsaJl5+qIawxllauxm8iO5TWOAK4Ae6kjD/A7TgNOILafuSo5ur6s3zr1zKIo3CSQwRYrQR6R9fT+nAATIljybRjswtni8dTih+MUB9abbKdpR2Jykw==;5:DRcaMKeM04kFNUjkdD33If8YvdqpWGWynRnK1B61WYOBJansJnNtIGv/LqvUqShtP6L5jxCRknAhUj2F3TCkEIBlWW9Lsv8o8nQ7sjbo3STfgV7r7fts9WXE8R99NXDVLHQFKNsoiQapG7KHhGiU7RsuiNU2LEemE1w8h8YD+N4=;24:dI3E6tzqYUQJOxVnlcrz2A273pKtpGVYzqbw//fGUHJtUy3asO8IyYb9pO5g1oFdim+DYjvlBgq5otEH3prss+rcp5KFp/JRIfNsZXJ9Gns=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;7:elwM2wusrte1mvSkP2sipCxS9bYbh9LF18uSSLmQBlFPylg0T7lEGcte5x/1MlWINowVXmNqpUejaaIKwu4nqxE20GwEx2rx1RuSp5g8v5VvROIHWMsaHBzZmaso54D/BTZQcOWt10ZpzCWvhew/A3L6NjfQx6MmUCyVzhNffGbx9cbNgYJ41eyC/UfXSzUJHZBJWtRNHk56fE4Mzb7s2X91+shDi6as3+UWbysfzd9Xyc/FCW2dzCIWT8p3AyQp;20:9O6D+bi1nQUAgrMCM/AiFSnf1q4nALP+XZSnJ3+wqcA14jCNmJoGherrznVMGxCdjdRJdirIQmCwjm1oYRoVvr9nRzsijaG6a1ibptD1BMoxKByNjESQmlIerPS5/KD+93Wco8b+xvBJXd3IhwNzOCOlzExlkT7LZK6KGQvcPQYjA2ESDAY+X6ORiOYgBVGGVqO+h/0xu6SUIXyxQwa2163e+xAl0HigDY3RZ8UBUPA3Ol0qPfeKrr53juyIyDNS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 03:57:15.9613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea787696-8bca-4f58-545c-08d595f253fa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0166
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2018 5:54 PM, Gary R Hook wrote:
> Provide base enablement for using debugfs to expose internal data of
> an IOMMU driver. When enabled, create the /sys/kernel/debug/iommu

So this can't actually create anything yet since nothing invokes the
function.  Maybe describe how it should be used by other drivers (and
probably include that description as a commment for the function) to
create the directory.

> directory.  Emit a strong warning at boot time to indicate that this
> feature is enabled.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>  drivers/iommu/Kconfig          |   11 +++++++++++
>  drivers/iommu/Makefile         |    2 ++
>  drivers/iommu/amd_iommu_init.c |    2 ++
>  drivers/iommu/iommu-debugfs.c  |   32 ++++++++++++++++++++++++++++++++
>  include/linux/iommu.h          |    4 ++++
>  5 files changed, 51 insertions(+)
>  create mode 100644 drivers/iommu/iommu-debugfs.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f3a21343e636..c1e39dabfec2 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>  
>  endmenu
>  
> +config IOMMU_DEBUG
> +	bool "Enable IOMMU internals in DebugFS"
> +	depends on DEBUG_FS
> +	default n
> +	help
> +	  Allows exposure of IOMMU device internals. This option enables
> +	  the use of debugfs by IOMMU drivers as required. Devices can,
> +	  at initialization time, cause the IOMMU code to create a top-level
> +	  debug/iommu directory, and then populate a subdirectory with
> +	  entries as required.
> +
>  config IOMMU_IOVA
>  	tristate
>  
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 1fb695854809..5e5c3339681d 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> +obj-$(CONFIG_IOMMU_DEBUG) += iommu-debugfs.o
>  obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
> @@ -10,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
> +obj-$(CONFIG_AMD_IOMMU_DEBUG) += amd_iommu_debugfs.o

Where is this CONFIG defined?

>  obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>  obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 6fe2d0346073..99d48c42a12f 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2783,6 +2783,8 @@ int __init amd_iommu_detect(void)
>  	iommu_detected = 1;
>  	x86_init.iommu.iommu_init = amd_iommu_init;
>  
> +dump_stack();
> +

This definitely shouldn't be here.

>  	return 1;
>  }
>  
> diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
> new file mode 100644
> index 000000000000..94c9acc63b65
> --- /dev/null
> +++ b/drivers/iommu/iommu-debugfs.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD IOMMU driver

This isn't the AMD IOMMU driver.

> + *
> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
> + *
> + * Author: Gary R Hook <gary.hook@amd.com>
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/iommu.h>
> +#include <linux/debugfs.h>
> +
> +static struct dentry *iommu_debugfs_dir;
> +
> +#define	MAX_NAME_LEN	20

This isn't used anywhere.

> +
> +/* Return a zero on failure; 1 on successful setup */

Return NULL on failure, pointer to IOMMU debugfs dentry on success.

> +struct dentry *iommu_debugfs_setup(void)
> +{
> +	if (!debugfs_initialized())
> +		return NULL;
> +
> +	if (!iommu_debugfs_dir)
> +		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
> +
> +	if (iommu_debugfs_dir)
> +		pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL\n");
> +
> +	return iommu_debugfs_dir;
> +}
> +EXPORT_SYMBOL_GPL(iommu_debugfs_setup);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 41b8c5757859..cb2957dac43b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -696,6 +696,10 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>  	return NULL;
>  }
>  
> +#ifdef	CONFIG_IOMMU_DEBUG

Should be a space between the #ifdef and the CONFIG_..., not a tab.

Thanks,
Tom

> +struct dentry *iommu_debugfs_setup(void);
> +#endif
> +
>  #endif /* CONFIG_IOMMU_API */
>  
>  #endif /* __LINUX_IOMMU_H */
> 
