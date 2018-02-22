Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeBVI1u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:27:50 -0500
Received: from mail-co1nam03on0059.outbound.protection.outlook.com ([104.47.40.59]:35910
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752666AbeBVI1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:27:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 1/2] drm/amd: remove inclusion of non-existing scheduler
 directory
To: Corentin Labbe <clabbe@baylibre.com>, David1.Zhou@amd.com,
        airlied@linux.ie, alexander.deucher@amd.com, Dieter@nuetzel-hh.de,
        l.stach@pengutronix.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1519287709-28638-1-git-send-email-clabbe@baylibre.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <83f990cf-92ce-31e7-1734-d57c1b7242b7@amd.com>
Date: Thu, 22 Feb 2018 09:27:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519287709-28638-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: HE1PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::20) To CY4PR12MB1303.namprd12.prod.outlook.com
 (2603:10b6:903:40::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4ee704d-1e71-4b89-706d-08d579ce2703
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1303;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1303;3:2NkAiyJtDtcbWK/tapPAWqLtLCl94Q62z+7yKSAm1ZtICq6ajqm3ieB9la1LZiglukEQpIzalbtT+aLY4pcZesSrSwAarBHnNniqKi8JoJqHH+DuQ5JtqrH1lXyWzc0x9zc3CZ63lu/S5PAByK0/fSXhKkc2Zu8fXOuSV48zwAMhtxp7jVBkD7esRGZ2A4jyEz+rLedvduVqHGo0TZe3PcZTJDddv1wZzaCOgksxn4XKQHia9lMguarJIfGYa2v/;25:/1rsAco+E+d/FbVefQZ1csruJFIF1TlFCQRWyVASoxb8tEoNlBc3tEOUgpKLl90FehNPtfe0R16Q5aOjuWXN1NXZMN92SwOlEIbM8a6H60xvPIMAQ8Yq7NlOsr9PxdgFN2XgLG6GyIXTvv63UGFutmKuejl6hIh5Y2/IYyHbB/8W9Ll7ztZcBO7X99P9P19ZkMeQgsCI2/Og2gkY5g/pYhiSEkHeCFCJYl5zyVd9iJyFsyilhIj5GWI5wHt2Zqx34FFMoTdFfQlylQ8hvUsBieDVizfMASVRvWYs8/98pqOV5YQyoNo9/xINxuCmQfGWhjG4QnX32Vue2zGhYed+xg==;31:ldD3jRrT0yoXhcNzTrxObPcI7gnshLuRKx216RhoulJlh6FL5Z7963mInx5vGR8mBkncNiQLwpyYQellYGEQqYlpqGLdLeYgx2bGqanJTklvh47T0xHu6ZGXUqJ401ZUmfz4SxKU/va50l8wTjQkFcoZ9jW0kFX8317/gjfIDtDYocbhfakueNXuH1TS+K/0cRZSmtIJJDnbMogOGeoEew/TWkGC8B0Bu3dTvfIY9CU=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1303:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1303;20:I4Avy+cvRcQ5EkEzBZZLLXFy4VmKLdoV4rfqNCxdOxwnQmnG/L011gYTeNy3vqPMHms5waJg/9CF4m3zI6wLKCmcxl/W9VVAkLg742upXPH+PWGj05nx3Yr8EMQtX4vzG54SRjDp+uJBDHkFmgZy9eHe0GeDRuIGDvxk1eKYA9M6P80OKVH+xoBYxr2b0dNLGaJJe1rBqeaAKLbAlDmF1ZNRRY/oMIF53ooB6wjt5wGeHvpP6deS4Yr6qo0FUCFJhweBJ4ZHqb5LrVPf35l7s4cB61fC62T31ssTGbtqSCDbVKngElzLdrXZglXzEXoI9i7wdWaY57u/fW8y7d6CuHsiQzqfFQkz+7oNkh7BGnCP04Nv7eo/7PTXx69SatImhojXmSF73Wqgb0qNhIobSLHWD47gZP8vjVzBqPjbyhrjlXRe5R8bRJcDW1r0MhT7mcDbOuGsJO7jkCHZWYaf3IsWcDkUZTY8UzfulFwHCjcBHHzviyfc5d3qE9g792X8;4:j3L2MNQOMeL2b+Ky1JPSWxrz9NO/XRFMDUsWDIXm+S46WHNvI+exwl01KeYxPYiP+t+gLPCci2t1GTC6jv0suo0pmop0E8VZToiIIek9G8Tj5/dIa93N1ZDSvKJm64Z9lOBPfSfQbyvtldFiS6bvA9JOx7G1Aqy6T1SfhXoBXTUvZzaPiPf8eZe9pD1PbQv66rQ/2eFvnAih9jTaqUG8VKOCNoXMjGRmkGdc0elJWJjXntClYcD9qhwbccjiO46qoaNGHd0Y7tFO9rd3ar5Qmb7m4xVeggg9+EeC8SzACsWfBMwN4IO2JZSK+7rHcdgg
X-Microsoft-Antispam-PRVS: <CY4PR12MB130330D51797FEA2C1E5A27F83CD0@CY4PR12MB1303.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001077)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1303;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1303;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(396003)(366004)(376002)(189003)(199004)(305945005)(2906002)(2870700001)(316002)(97736004)(67846002)(7736002)(25786009)(478600001)(65956001)(36756003)(53936002)(64126003)(68736007)(5660300001)(86362001)(2486003)(76176011)(52146003)(52116002)(23676004)(52396003)(8936002)(6116002)(1706002)(6246003)(58126008)(50466002)(65826007)(8676002)(81166006)(81156014)(105586002)(31686004)(106356001)(47776003)(31696002)(6666003)(2950100002)(65806001)(72206003)(4326008)(16526019)(186003)(386003)(229853002)(6486002)(59450400001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1303;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMzAzOzIzOjJzNEwrdkVJdGt6SkdxU1lGOWxkNG1LMU1C?=
 =?utf-8?B?dXFIeWR1UGxnMGRVZjA3WWlTK0k4cFVLQUduOXlDUGo2M1lhMFZaK3FNQWJC?=
 =?utf-8?B?bXhrb0FYRm5hYkFtNHRZTmltQ2pKUDY5ekVRSFVOeU01aTByVjBVQzRGemxz?=
 =?utf-8?B?anc0dTZtV2V5bWNtNnp2ak0wZG4wdG1sUmpQamxWVytUbVUzUkw5cVQ4b2sr?=
 =?utf-8?B?ZnE3MGdQaTZoeXFKUmZTc3cvV3AvR0RBZ2R2NTV2c2p6UmE1dkxlenFkdmxW?=
 =?utf-8?B?RXhOenJUVTNuZ3pkMEl3N1Bzb04wYzBnMlk1MDZVYzdhVlplOFZRdDEzTCs4?=
 =?utf-8?B?ZVlJbUlKdjFpcWE0eXQ5Tnc4c2ZnN0pPeWFWdGZWNHNoeTdnNlZPU1hTWUw4?=
 =?utf-8?B?a2hDeWx6bGxZNmdzc0NuY3NNTTNDSDhhWFhxOVNLUTBncmdLTlpXQkxEdGdZ?=
 =?utf-8?B?Uy92empBYkVmTFVoT21Wa3BUcENFT1c2d1JsNWtPbklCNXhoWkoyWnh4VzZw?=
 =?utf-8?B?ZndiYjJ2T1ZJUmZ0ZFZleWdRY2NhYXhucisrR3FXWndlUjMwUTBWZ1YvSVY5?=
 =?utf-8?B?Y1NWWlBQdTBLNFBsUmpxMytic0lWb3VQVlc2YnIrM2dmY3VwK01va2VUTlFN?=
 =?utf-8?B?NGJSdk9wUVpnWkttVW9wYjBvc1JLMmJoTWJJTzIyQWY3WGxiTFJ6V0pNNDFM?=
 =?utf-8?B?UmpQb2VicUFuTjVpdERmL3FWazF2aHJGQ21rUGovV24wQys2RTdOR0hNM0Rv?=
 =?utf-8?B?ckF5ZGdON2FFU0g4K1pYMENiaHVoTFIyRHFIZWgrOHo0Y2VKT2Ztek00V0M2?=
 =?utf-8?B?RnhvSXpPcEhUczA4Q3gzMnhPM1NENkkwK2JkbEpsbGxzM203RGF4aGM2Q1FT?=
 =?utf-8?B?dGc3TCtla1JERFdlUFh4aTgvcTNLMWFYUmVHamN2Wk1LMExxTURudGNKcXBj?=
 =?utf-8?B?bWRtNklnMTNFSHduaTJES2dmdE9xdGdNYVgyZWYyYXdkU1E1eXA4emFremlr?=
 =?utf-8?B?amVsdFlyOXVGejNheGV6OXRHcVczREVLM29DNm53U3VWbEtRZjYySjVSbmQw?=
 =?utf-8?B?d1VVN3h1bzIzUzlGdzE2aFAzU1ZrNkJ0cGRBSlU0U2ZpdXIyc3ptOERLOTRr?=
 =?utf-8?B?aFg0MC82OEk5U2F2Q1d6RElpWXV4cDIxTnhrTnhkL1BKbkMzU3JvMzRMMURU?=
 =?utf-8?B?dXhzNlhIVWZRUWdqOG1tS29KSit3VFZHcDhjVldtZHd3WVpYcWdab0ZXVkVm?=
 =?utf-8?B?L1VwSjhwOCt2Yk5nSitWbXhjRzFQZTc4dFlJZnAwaXc4RWE1bjdKS2J3QVJF?=
 =?utf-8?B?Y3RCZFZlRXhCOEp2Uk9OcUFMamp3aHBZSEpHWVRVbnk2bkRWVUNPR3h2blhY?=
 =?utf-8?B?eVlLcjlhL2dKbEJlM283aGdJWHNKWWt4V3dBdXdYOUl4M2lCYkU5RTdCQXpq?=
 =?utf-8?B?VENvbjdLbzRYNHVNYnc0Y1Bab3JsYTNxTTl2US80eG1mYzQrWWYvcnFUK3dk?=
 =?utf-8?B?cERYZGYvSkt4VjZsSjRqc1pybnNrRUZEWFVJNEg4bTE3REgwOFA2cWI5NGJj?=
 =?utf-8?B?TUNTeExPVDdURVNxTisrSjNQZldZVXUzUTNZb0NvZW5VWWt2WDVRVDZrd0dv?=
 =?utf-8?B?WTI1M3ZxT2VlN1B4NXpvSkhvcXcxajNwRU1NVk9jNmhZNXRMYWxabHZiNEZK?=
 =?utf-8?B?YzNDYTU4dzUzZmRKeVJXWCtrczIzS2pxblNjUlZXYVBMYjdGa3VUZDVNSDFL?=
 =?utf-8?B?NWN1R2Y4Y3d3bDg4LzNodz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1303;6:QkUueI67t1fFdNhO+MTxUv9jiRn0ZzGU4Mfg9wu7EYsgz1wA5Xv1AIkyidOkU2OzFrUv9nEDZFYZOVVOFMJYNAoDh0jv2BoudVW7py/iidw4PMZT17C5TOom6suoW3vgPdksiVpUq0V7SI9OX0yFuYy3x6CbhcpZCtukdGaluLI1eE7fkwB6QTxULNd/fXEdfxFlswLY3ZFSYmfx9ibwU6qk8kEXZHkMfDmFufwMBoSJK1yYlPuN+vYwftKvlfquNrgenOO7VjQ3dpFNGee1/RhU9DdObiInqMJAsbXbJA6XjgIFB3+GvL2CgoheiZ2+T4tNj9wUYQRnVXuoEFoS/1FbfN9sshJ0rUNEszIS8AE=;5:kc7bJy09vTDqKfkySPLz8ZGOLF7JQi4gJNc7JkgOusGprKh1GzqrmWJAi6UJBDsn25c/7NzltrV2l6X//8JpN2DjSEuCol7C9t0GHcW/Q75VNbhdyNlOS8lj/RbcqFTCaabgUM/wKU39RCJTMIAunTZqwz2+OFeI31DZmoOZK3s=;24:OC+r2OeciahfjSOStRfy195B98Kewe0XZHqGU8v+NX9rPi9IecnsPFfUKoNX1BHHMUeDpkinBcI+mN6EL8wAIiLBVX30AqWdeFWOFsjnGKg=;7:5BD9Hsiajl49eD8TjGymNMH3NQHqygQsyEGDikzN4DBudNP7su632rp7KN2XKwWnZoCY+fQBSOAjLCzIHFek2v0Wn7DqmVJMI1f/C3BSldoxgCHxJ6PQ8wMKh3yCngqTb/rGbhJbMTFZLU0iErjXdfOpPvGYg/eq7fB7vzGJTK7knErKdfBvp1I1FL8+lXxB1IC10iUTAwY/Jz/KwPi4vbVGi/RoZFsivnLesoiHAqTSAFdyU5osM07CSFyUvdov
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1303;20:jHxiw2tRpSoEEhQuEln5n6aJNVmLx9oz/X7E4E0fmKMMMMw31weUODMmCUdBFtCdczwZ8PIb9WR8wSs4y0X7RQN/KGGwU5YuDxUkyQ56ir0Jxdkc+s39N/ABp0Ix4jlzFyD/vEPIqlq7gz627cUHi41FBsTbm8qV9Tutt56cqQu7bQR1qKQDC+cgEDg3FQm9qpdjBiVyv0iRG1CbiCnwEpfcBGtch/R6gVAd3XbV/PVBDYI9gT94DmXPgtR4V7MR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 08:27:43.5990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ee704d-1e71-4b89-706d-08d579ce2703
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1303
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.02.2018 um 09:21 schrieb Corentin Labbe:
> The scheduler directory was removed via commit 1b1f42d8fde4 ("drm: move amd_gpu_scheduler into common location")
> Remove it from include path.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index d6e5b7273853..8408aeeaf6c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -30,7 +30,6 @@ FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
>   ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>   	-I$(FULL_AMD_PATH)/include \
>   	-I$(FULL_AMD_PATH)/amdgpu \
> -	-I$(FULL_AMD_PATH)/scheduler \
>   	-I$(FULL_AMD_PATH)/powerplay/inc \
>   	-I$(FULL_AMD_PATH)/acp/include \
>   	-I$(FULL_AMD_DISPLAY_PATH) \
