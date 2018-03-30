Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbeC3EQq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 00:16:46 -0400
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:19914
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750738AbeC3EQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 00:16:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
To: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, jacob.jun.pan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <152236384612.3266.1451709369164076985.stgit@taos>
 <152236409481.3266.6464716993249076762.stgit@taos>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <cac20ad6-4de7-b722-6ae7-769dd7655c74@amd.com>
Date: Thu, 29 Mar 2018 23:16:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152236409481.3266.6464716993249076762.stgit@taos>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR22CA0053.namprd22.prod.outlook.com
 (2603:10b6:300:12a::15) To CY1PR12MB0168.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a717159-40da-4893-c012-08d595f50a18
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0168;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;3:kRAiHxIzct+p/zBuqDB+zBbHjena8h1N7Roje9OGmMIUeWlIfOQQRTSyH+oDgACxtMqs8GAsgOjny5KzZsGoCdegRLhdHpDifFRU+cAPKb89N7yLdtPzrWdkM9AP5j8yAr+4riajRUKZfBYS84fC+kN2UocKLejvzHfcxzSlr5i1GsEtTSoXQQufQkxzYwKhKlVekgWB2e4vuRIQrcSXmkJCTj5LUVgndE8leSv+iIhRzPLCE824k24krXhge5X1;25:lMXgfP07WrDbgGdyEBvEY/KcWp9ARcmlcr9zy+TaODhufWdVNmFQumtuC2pYwuyNaEBv/DAkU/Gn8bO5WgZzLBlOljq2TE2rHW8hO9TvP/34KE8MryYP4W5f+zXuEnlTxmxZYdCfZ03fGU3k6fBApd6fYF+dzAuJ7xo3G3k7+ji5yG5heYzHYjYMlx6Sn3dJHxwOXegbd7I+pncZya9F+p1XiqML9YMC7cj10rragt32o2sXdLtHE6bqUMkd0U4oSMir0sl1HWhUynqz9zHEZcLctFPQgVb22TTlG0ERgCmKVjC3GEX4xID+uqrNPXJdswi3nyq1Y01PA+W4rYKG7Q==;31:gSOzaAP8hM3uFUpGWrx/EuobA8j+7mRWaoQ9McblPIldehbc93UCVzwFsjP09bHTHXVlA1nRWGCqHpZvEEg6FMCCsvXjzRU0LPQdiv0T90TzvQRterqLGHGJH1XuXQtYxlJV8tOmLktS8Eert/pvuS0Us7+o3Ldryh0ax0OosCuYn0pVQ6X/OvE9dFOqaRBG7vWyFfnKakeO4bQdcKlTM4kHlE5FGqjZ+o44dXdn6jU=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0168:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;20:AcWMgw2PS5kBCJPna4W58XVyYFpWToKGopK7ULN96JqV0mqD8DGHIDJpkjkb1l43M7w1KC/HFX/FQP0pxFD1rSt3aanIGea02zTMz0s2C1lQNoRWxEzx9ZN/cOt7CyFYULY3/DojDL9kw6urigRBEjrALGf8Djj/5aQBbbNlpddTc2Wke26KgtYszfnhc1gkWNv17NXPxvD5zNtoziHp3AogFqNRloNL/GbYxMk3IMjT8/eAk2hNUaCoqKriM6JeJ6w33nBNT3rkk6P3AQ36UUpfQ+muIJfS26UwqXG/MAvewVF8c/rFyT93TtGW/+5IHyPLWD/xXDbjqnDtvTxeXb69ieyzEJ52TzulVS0CrOVebxCDYf4X8vrMjFuple1qT7qjHr4DZzbR1BTpv+ucStPQJhA1zw06+QKRXaFPwn0v3L3p72eiGSy+x+7ngV7oK/6df8BoH5/4yZp1rkvxGLUenxAgjWOMcpBkipD/aBicHUZ/Zf83cqmOOkr9Bmpt;4:ryTIXd0aIAeXCg99fS0ncVUQ2OvrLPVyE6qUdqiz5c+vWoYogU9wBEsaQvoOyFZ5u2jhTwIY3q314yTU1nbt4EUz0ziRSBAIkeGUUmYlFLKwIlQIAemoR9aXDQyTqgG1TmTUV0FLSlzxXYVo1h65sU9XQbfg4EFmSqXKxnLFadQ+yTNU/wDhhRW6MqcQU1uEC+OlrlzTDwGbW+kOEHKMgxlfdxwRBCEQWVNxqzAoiKWFxUgefpp4EArkU//+Y/zFTD45nG/pdtxz+vPqXEgSNsI+v8dTyzuzMIKGxcW2OJyM8kmEAf4+klxhMFh9LCFS
X-Microsoft-Antispam-PRVS: <CY1PR12MB0168FCACDE410FF346C38AEEECA10@CY1PR12MB0168.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(20161123555045)(201703061421075)(6072148)(201708071742011);SRVR:CY1PR12MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0168;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(39380400002)(366004)(189003)(199004)(5660300001)(16526019)(186003)(77096007)(26005)(105586002)(575784001)(3846002)(4326008)(86362001)(6486002)(53936002)(8936002)(58126008)(446003)(6116002)(3260700006)(7736002)(81156014)(25786009)(8676002)(305945005)(81166006)(65826007)(31696002)(2906002)(68736007)(64126003)(65806001)(66066001)(50466002)(47776003)(2486003)(76176011)(97736004)(31686004)(16576012)(36756003)(106356001)(6246003)(486005)(59450400001)(486005)(476003)(2616005)(956004)(11346002)(52116002)(23676004)(229853002)(230700001)(386003)(72206003)(6666003)(53546011)(508600001)(52146003)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0168;H:[10.236.65.235];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY4OzIzOkM0NW1TRHdWZFVOU1N2dHdjNnNCYmxOaXJY?=
 =?utf-8?B?K3lWbzlnbFhyYU81Rlo2RWk3eDB2NnkzRDhiQWpNMWJUNW5HbkVUV0ZiYTNy?=
 =?utf-8?B?eWxIMk1EeEFTYkpLVGpYVzQ1dTBtUGk4MDBwdUNLNE9kVHVkbTNsRnl6Umxp?=
 =?utf-8?B?QU5tOVZvMk5VWlU3Mmlpb2R0SjNIZm1qSW9pbmFSb2FwYlovb3laK2dyd0VZ?=
 =?utf-8?B?UDQ5MzhHa0U0N21FNzRQUDcxZGMzQXJhQ2NtZldNTjViZk5iQWxPRkpMNkZR?=
 =?utf-8?B?Q1phWWE2a3pYYUs4MmkySlo5TG9TNjlIb24rUlYwa0xkdUFsZ21KbUtOUmY1?=
 =?utf-8?B?QzJLVGx4QjBUQklkUXAvdXZGakpiMmRXTTVZQmlKV2NXR3RhOHFPT2drbStu?=
 =?utf-8?B?VzFvZlJGNG9Lcm50MWMwNXdia09pMHBrM3R2OEd5WWUrVTVjWVNaUld4M3g4?=
 =?utf-8?B?RUMvRngvR0xQWXRGZCt5RlpaUXcwYi8zYnBPMW5yN0FaaWxJVkN4c29PYTZs?=
 =?utf-8?B?cnRaaHpxVFlDd1ljbml6Tm9VSFp5ZW9qemFVNFhLSmRkS2hXOVlSek5zNnMx?=
 =?utf-8?B?VVNCaWw4c2RReWRuZHVwYU12dU1DNHcvVE5hZ1c2SGZKK1NhYkhLcnNtUEY2?=
 =?utf-8?B?M1hIQkpIQ2VIY2NBc2JialNOS3BydU9RblBlbVNLNTRrREU0clpnQUxzMnds?=
 =?utf-8?B?djdDR2tMTkkzK2plTjVrZjVWb2hXQTQrbGVMTTVUWFpkdGRtczJUdzM2TFZW?=
 =?utf-8?B?eENYVTNTWERRSlZpd3hGMDdrQ2tlek83dEc2cmc2VXVBUWszOWlpWXN3K3Y3?=
 =?utf-8?B?M05lS2dJaUVyQkpqVEJsSGwveGpTd0tkb1pGNFJXOTJQOURRdUw5dFJaZG93?=
 =?utf-8?B?WXdKOVc1TnZYeWRIWkFVcXdKaHpVdnR6RFgrWWxwM0p3NS81ZWtDeUwxVS81?=
 =?utf-8?B?UXlFa0czWHNsb2t0dERRbjN3dmpmVXJuZHdQa3RoNWE5bzZGZitmYm56YW13?=
 =?utf-8?B?R3I0SXhHNyt5QkdUdnhUWmtEK0dVTUQvbThkKzRZU2p2K3pQMElUbW10QjVR?=
 =?utf-8?B?NVJVUVFOd0lvVGIwRGhEbFN2VlRidW80MWFxREJKTmlDYkR1NGxnd1F2elJT?=
 =?utf-8?B?d0M5RlRCZDVUdm94M0JFM3E2MVh1bEtOSkJ3L3pQdG1PV0NHbll3czAxc1Zs?=
 =?utf-8?B?SWV1K3U2MnRmQ1dqckMwUlo5NlJwYXlWWW5nZnRpUnRndEdTUVozR1luLzNw?=
 =?utf-8?B?andKSW5XYXY3emVib2c3bTRES0Yyekg2L1IwejhBNGYwVjNINVIwUWNFTFJF?=
 =?utf-8?B?ZlZtcVQ1UTVhdlljS0oyM1lXeUh5MThaSXBRRkk5YWxNREZaTlN3OGJLVXpa?=
 =?utf-8?B?aVh2Ry8yczRpVS94SUtCR1RKRmhCd0I3emJCSE0zTlkrd053eDVRcFdpd0F0?=
 =?utf-8?B?djlHMUxmbGpjMXV0SXRWT216MC9LM1BXVDFaQmN1VlN4NFMrUkh1QmNBdTNW?=
 =?utf-8?B?Tko3T3A3WEhQWDFlcFZpcEdMWEtZNGtWcXFzZEg2ZDJBTXIzQnIxZGM1RVJx?=
 =?utf-8?B?SklQL2JjL0NDR044aDJQaGI3ekNTaU5jeGluZFZoOGRZU3R1dmtuNkdHb3Ay?=
 =?utf-8?B?R0lDM2c1ZWpuSXZxOU5XV09UWnc1a1ZCV28xTk9GQ2tlSGZkUzhEZXVPZktn?=
 =?utf-8?B?T0hLUVR3MmdSL3NhREV3V2t3UmRndTIvVEdBNlRMa2FaaW9yRHc4aTNKYU1P?=
 =?utf-8?B?TlRsSFBiWG1CbmhLT2pSMG9IVUNlaGlUK1ZCb3FnSWVvQkFhU1VDMnRDODNV?=
 =?utf-8?B?VlYrWVg2M1NBZUJSQXZ6Nng1MkMvTGMvcWZ6bjZqbWtNNWJyMndoT3RISk9s?=
 =?utf-8?B?d1pONW5CUmJLUndrRmtyeFJ2OFJtUDU4eGFZU202aEZ6b1lueDN2VHo4RnRv?=
 =?utf-8?Q?U6+sLTfslgt+WHFq4zOiH+ImUdzxvY=3D?=
X-Microsoft-Antispam-Message-Info: BdJIwt1ccXbb+Ryg4tJL/XJFDDspQkH6TpmISHujyPdedeZslF8Q6NOYEPnWDGukBANOPZ3swNxe7jk15byiCRLKhaqq+G6hUvo9VOvEd9cwjt5ynRvVYyfAfBBXnDxCVrNG06eOctucJ44VTf9CqSHFtYOARrdIuyKwb99nTPflWVvl56HWR/IZf9CWD9r9
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;6:HEssgDD/UtN6pYI5m9qy4QFg4awgy3kNGhEM1UY3qpRR372H/f9F2c3LWpA3EG131AD8c9bMrmrHsoaFljYGr7fo+mqaJrsVlBgB8dDTpdiEJUShdPsTRNzWd7/jUnTIAZfY5Df+8Vhs9LVBi0++7T/Be7CV1LRR5xUexDpygemh7Dj2J+KTMpE8xWY43LR4Xxny/0tHCE6bGNG8pnNyI1/FsYc/d1ATjKTIMfmxtF2Oj6sBnj5EMAs41m4BKsTwV60mUeZCf45174UuiM7zgfxKyhk7AzoeHHEqDVsn/OZ/BO3+HOrre2DEsarOBaN8+x7da0F2Pv+07eRcoosdtEHI7Yhv3FOFL6m/P7hak9R0GqDVRfrOFcpSdCx5uWcbAXOQ+R3sF67zjQatbhtWCUDmUqGdeh4YleMuelR3ZgxkrGel6RnYVIFc75fnsV27vm6/7X6pZ5lrwC1VsHmdDQ==;5:CGZcnT+2ihQ0Z2otuDtm79VUOa96W52l/OXnVSRiHxcdvGfB9/RP/d8vuinL1q7bWv5FJqIHALWa2PdL4J202J9N96gly95HqsjsbEU90iW189uI2b8gFZOP2N6coqImibaki3HZnlSZ007KUT6/pGHkNejOEHe27IZit53dxto=;24:BDc46kntcoJZ+sAYJLCIcmEi5EEKAoNA7ihROmYkflqqI/GTqKJotny9TPRjFBl9MkUVRsPzs8c1r/b4dPjlQlbelw4cwZ480w1gFMHs8A8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;7:XNs98weSqUFSKQrP+0yaJM1cHqvuS7lwlQF+1gz2Mml10D+Pxp2K6CLn3JQFVNOvKHy7EtQ++7dH4FuVt7/F05m0nqP2RVRyKndErq5U+Msa5j9uqDfvXacPaFvWqAuQ9T5xplaxutnkDBNj9P7Nm0GorPentfnTGGfAcGfq0N/5j+OAL5UlAGmVLYlLeWkhRlSm1mquF5o/70iZnU3Dh82SiTKjmoK/XvzuHZPefHZFVZwghoOZGFi81PnaSoDW;20:pYHkLS504XI4Kit7GMZAMoYzQ0c0fEuRqCAJoPK77TCUmpztVF5Qzme9GmtQarvYxd1YWVszVvw76fekryaFmxze2SlUaHuPqY33zoP3wOqKoXdIaa1aIEn+WG0DIhqaqvTLx4wNMzySMK8k8BHaOJCKfXN23XQk6BXgJV4o4XrsW6voYVy9kb29VaPvj0D2dsozkt89lBfgGW18wxlneE7tKaKUl5nA/LwAA30j8BnVQpKwzGkQ2YCsCyd+ZDgv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 04:16:40.4994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a717159-40da-4893-c012-08d595f50a18
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2018 5:54 PM, Gary R Hook wrote:
> Implement a skeleton framework for debugfs support in the
> AMD IOMMU.
> 
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>  drivers/iommu/Kconfig             |    6 ++---
>  drivers/iommu/Makefile            |    2 +-
>  drivers/iommu/amd_iommu_debugfs.c |   47 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd_iommu_init.c    |    9 ++++---
>  drivers/iommu/amd_iommu_proto.h   |    6 +++++
>  drivers/iommu/amd_iommu_types.h   |    3 ++
>  include/linux/iommu.h             |    8 +++---
>  7 files changed, 69 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/iommu/amd_iommu_debugfs.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index d40248446214..8d50151d5bf4 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -65,9 +65,9 @@ config IOMMU_DEBUG
>  	depends on DEBUG_FS
>  	default n
>  	help
> -	  Base enablement for access to any IOMMU device. Allows individual
> -	  drivers to populate debugfs for access to IOMMU registers and
> -	  data structures.
> +	  Enable exposure of IOMMU device internals. Allow devices to
> +	  populate debugfs for access to IOMMU registers and data
> +	  structures.

This help text shouldn't change just because a driver is making use of
the interface that was created in the previous patch.

>  
>  config IOMMU_IOVA
>  	tristate
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 5e5c3339681d..0ca250f626d9 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
> -obj-$(CONFIG_AMD_IOMMU_DEBUG) += amd_iommu_debugfs.o
> +obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o
>  obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>  obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
> new file mode 100644
> index 000000000000..3547ad3339c1
> --- /dev/null
> +++ b/drivers/iommu/amd_iommu_debugfs.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD IOMMU driver
> + *
> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
> + *
> + * Author: Gary R Hook <gary.hook@amd.com>
> + */
> +
> +#ifdef	CONFIG_IOMMU_DEBUG

Since the module won't be built unless this is defined, you don't
need this.

> +
> +#include <linux/debugfs.h>
> +#include <linux/iommu.h>
> +#include <linux/pci.h>
> +#include "amd_iommu_proto.h"
> +#include "amd_iommu_types.h"
> +
> +static struct dentry *iommu_debugfs_dir;
> +static DEFINE_RWLOCK(iommu_debugfs_lock);

Use amd_iommu_...

Also, didn't you run into an issue with the CCP and debugfs creation
during probe using a RWLOCK?  Should probably make this a mutex.

> +
> +#define	MAX_NAME_LEN	20
> +
> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
> +{
> +	char name[MAX_NAME_LEN + 1];
> +	struct dentry *d_top;
> +	unsigned long flags;
> +
> +	if (!debugfs_initialized())
> +		return;
> +
> +	write_lock_irqsave(&iommu_debugfs_lock, flags);
> +	if (!iommu_debugfs_dir && (d_top = iommu_debugfs_setup()))
> +		iommu_debugfs_dir = debugfs_create_dir("amd", d_top);
> +	write_unlock_irqrestore(&iommu_debugfs_lock, flags);
> +	if (iommu_debugfs_dir) {
> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
> +		iommu->debugfs_instance = debugfs_create_dir(name,
> +							     iommu_debugfs_dir);
> +		if (!iommu->debugfs_instance)
> +			debugfs_remove_recursive(iommu_debugfs_dir);

So this might cause an error.  You remove it, but don't set the variable
to NULL, so the next IOMMU that is probed could try to use it.  But why
are you deleting it anyway?

> +	}
> +
> +	return;
> +}
> +
> +#endif
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 99d48c42a12f..43856c7f4ea1 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -89,6 +89,7 @@
>  #define ACPI_DEVFLAG_ATSDIS             0x10000000
>  
>  #define LOOP_TIMEOUT	100000
> +

Spurious newline.

>  /*
>   * ACPI table definitions
>   *
> @@ -2720,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
>   */
>  static int __init amd_iommu_init(void)
>  {
> +	struct amd_iommu *iommu;
>  	int ret;
>  
>  	ret = iommu_go_to_state(IOMMU_INITIALIZED);
> @@ -2729,14 +2731,15 @@ static int __init amd_iommu_init(void)
>  			disable_iommus();
>  			free_iommu_resources();
>  		} else {
> -			struct amd_iommu *iommu;
> -
>  			uninit_device_table_dma();
>  			for_each_iommu(iommu)
>  				iommu_flush_all_caches(iommu);
>  		}
>  	}
>  
> +	for_each_iommu(iommu)
> +		amd_iommu_debugfs_setup(iommu);
> +
>  	return ret;
>  }
>  
> @@ -2783,8 +2786,6 @@ int __init amd_iommu_detect(void)
>  	iommu_detected = 1;
>  	x86_init.iommu.iommu_init = amd_iommu_init;
>  
> -dump_stack();
> -
>  	return 1;
>  }
>  
> diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
> index 640c286a0ab9..e19cebc5c740 100644
> --- a/drivers/iommu/amd_iommu_proto.h
> +++ b/drivers/iommu/amd_iommu_proto.h
> @@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
>  extern void amd_iommu_init_notifier(void);
>  extern int amd_iommu_init_api(void);
>  
> +#ifdef	CONFIG_IOMMU_DEBUG

Use space instead of tab.

> +extern void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
> +#else
> +static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
> +#endif
> +
>  /* Needed for interrupt remapping */
>  extern int amd_iommu_prepare(void);
>  extern int amd_iommu_enable(void);
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index f6b24c7d8b70..6dca9fe38518 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -591,6 +591,9 @@ struct amd_iommu {
>  
>  	u32 flags;
>  	volatile u64 __aligned(8) cmd_sem;
> +
> +	/* DebugFS Info */
> +	struct dentry *debugfs_instance;
>  };
>  
>  static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 98527f9b473b..dbfff811aa25 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -412,6 +412,10 @@ void iommu_fwspec_free(struct device *dev);
>  int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
>  const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
>  
> +#ifdef	CONFIG_IOMMU_DEBUG
> +extern struct dentry *iommu_debugfs_setup(void);
> +#endif
> +

Any reason why this moved?  If it was not in the right place in the first
patch, that's where it should be fixed.

Thanks,
Tom

>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -696,10 +700,6 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>  	return NULL;
>  }
>  
> -#ifdef	CONFIG_IOMMU_DEBUG
> -extern struct dentry *iommu_debugfs_setup(void);
> -#endif
> -
>  #endif /* CONFIG_IOMMU_API */
>  
>  #endif /* __LINUX_IOMMU_H */
> 
