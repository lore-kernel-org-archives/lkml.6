Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757320AbeD0CvR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 22:51:17 -0400
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:16672
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757128AbeD0CvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 22:51:15 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Subject: Re: [PATCH 1/2] drm/ttm: Add TTM_PAGE_FLAG_TRANSHUGE
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20180426150618.13470-1-michel@daenzer.net>
From: zhoucm1 <zhoucm1@amd.com>
Message-ID: <a77d7229-e8f7-83bf-2098-8db07cebb117@amd.com>
Date: Fri, 27 Apr 2018 10:51:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180426150618.13470-1-michel@daenzer.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(39380400002)(396003)(2980300002)(428003)(189003)(199004)(106466001)(16576012)(229853002)(50466002)(36756003)(104016004)(105586002)(6636002)(65956001)(6666003)(65826007)(305945005)(7736002)(5660300001)(65806001)(64126003)(446003)(8936002)(356003)(68736007)(2906002)(316002)(2870700001)(47776003)(8676002)(81156014)(11346002)(81166006)(336012)(2616005)(426003)(486006)(476003)(186003)(77096007)(23676004)(54906003)(16526019)(67846002)(6246003)(76176011)(26005)(126002)(58126008)(2486003)(478600001)(53936002)(4326008)(72206003)(86152003)(6116002)(3846002)(110136005)(575784001)(97736004)(31696002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0757;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT039;1:q9BxKnVHsYAU24WRT1IlquIym66VrVckKVmfGtFNEjNxfT4r2f+92KkdyuB7ea/ZoU9wH44xif60CZa2V0QeVsCD+RJNHO0ZBbAwrC2VoFPnDgKLCT9fD9op1Luhw3NQ
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0757;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0757;3:Eg2WDb7TQR3NzjmZZSOG6J+RyHYK+L5BkUEGPWQn/l01iLY+5uXX+en+ZcWBx7mdh4zpCgZhFTZ3Qa6VyJcJz4q1KoiC8hIucoQe6uMc6badIeHJoL8AklL4PbVpFu4pkl/FD28BbJA3W4QV6y7mDAJ2CGDv5vmD2wBwsbA0nwz1RS3c/edOFT+tCnCz5yNxzUdMIfCqlDzmMY3NzoBG1PasejeOGTjoO5tS3hmRBNHVAsBeSNk8oUVFR5KhSCtJgkR903f7nE94K/OPpW9+tpE9yHkbcSNODGNzioHtKfAwtcMVxQ0yJsH6h0cviCtDOvzTle0ldKweYV9lah6ivGWFHp6wPWXR9+ewEaldeKQ=;25:sE3sVcfJGRMA6V5mO3Uxov4scagDjn93TFgVgzuolklm6Gf8Yh/eYM8G2jyYygSbxV8/uPX5E7mz0nmh0cldwPfD308SE897fc5c3oDyws46u7OZxrDqSOorzDyGqKwsxv4EeILkreKW1xoqkCAPYE3ec3B7fBMwi3UQKLiyAVzKS76MWY0c11dsgUZFmNyKglqGxXrwaW3Ny3o9dXMFe2hePsDc57jo5wdkyDWtiNAmwKi6/ESHv9EVE5z3YydTo7Mr/s96tK5XDK/PrHdOZnjvXCL7CxbShPAh8jOKmuF2nzUH5EnHJO/7nigkc1tz9ocZl4DTwnnW0pcjGxkE5w==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0757:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0757;31:rv42goaB65yCbHfiZx7OYpGV+PxvpRxedC7J/mR6Srbs9hFP3PS7MT+v93bFrXVkfTvoEz13cW9KNvia1o+dCDkfuxKM9blswHLatHZCPNHT1YymSohFYsQPyLIQI178O5odJSUnDtZT6d17BJ/gQDMuzmWn2rVGQf1rcHeeCsDLtX8ilKVAI2aLxAmgp0k36WOjd5XKQBk4hH7mxlMy5QGg5bDWOSmT0EzgF8pabbM=;20:5QchhqtVFbjrAm11lSLKgQmUWUCnDF8NvX6E/sN0+NeOG4hbzn4l4v12W1KY97+27JpmVvLZKrF0fC6vXXdZjVRp4E8jU0Eq3JbaMYLCp0EpEIpv+OJZbON8mEf8mLqKVYJmYEpEd+Me1ttpiAtMkj+7dOo4zBalY2f2OFbeywXmsppa+aJSZNbPnogTNGkIG8eJqASLx3v7BIGtU6rcbt9TCP3sUEwT3rkRbiCqaayaIzMvkOyn0gU0fcgvtDnCV9Tae76w0AvruD4UzDCmB+BffGqSnmp50Kxnq/I21a0aPEPQycSYPEWdvNCFGzyplZ3K0TWhIfJ+2uY61h0LU703nku+BNpb/e5vnTVGN8W5AyPiKlYqdaYRNYFCi2tKinZDFqqi5PAlUafNrCfQhdqZiz3aRzgm62Cc+C5F89CRK8OTWzoQw+tYAYuZ/k7dnLSeuOHcvR+Mm3bm/ceKmN3xoQogTeFC2HibH4HECDryO06q2UHxzZc499uRwpOV
X-Microsoft-Antispam-PRVS: <CY1PR12MB07570D8C9029098BD101F1EEB48D0@CY1PR12MB0757.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93003095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0757;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0757;4:rUZztWGPKHOdSQb4UtbJnaXnQTdQwserBF0cLdbFb4KxUsjSF2vQX7azPShEHT58qnukZu0dLTJkhmCvsLzIAWdp2NylSQZrPAdplvDKdFLuUZtZllDdR7Bk64lEHYN27Swdk8IX2u+9D9wFampbT12Fu6KK+53GLL6Ow6vrpnOkO9x0s4EMa+wL/3ui/EQMsd2kymfsvY9ZzLt2NUTrwtD+jXGsV4s8F0kJ0gXnHWoZShb/huZjjec3dUfZZhyWg5sWtrA06efwJW8o0U/CT02FpKt4L/G8FSINW89Hf+ZTWtfSjCXjA9/akuHUYdvHCHwQkBTvFeMY7SFYZ95bQg==
X-Forefront-PRVS: 0655F9F006
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwNzU3OzIzOkk0RzdwaEJ3c3I5NXh0eHdnckJIY1drV1pn?=
 =?utf-8?B?SmRmWEc4YjhvY0Q3cEtXeVUvdktXMTRnZGIvSDdoZ0ZwdHBEZ0lhakk4TnNX?=
 =?utf-8?B?eGt2dE1vcFhpNENoVEV3NUpUT1UxWG9TWVlib0xoSEVaR1MzREtEQ2o2N0ZC?=
 =?utf-8?B?S0hLK3F6YkJPaFN4SXJHK1g5S2UvWFdGWGFpR1lBVnczMEFhSHVnT0tIbyt4?=
 =?utf-8?B?VmNWcm1xMk9vVk5UOGNCRm5vdzVEWERhWlp3aS9XeE41QzNSbW9DdjgxZFZM?=
 =?utf-8?B?Z3dDUkM1MENPM1BHdVhQcmJCSEdUZk9GUk83SkJDaHRiaDlzbXN0anFwWStU?=
 =?utf-8?B?SWowMm1kSFhWZloreUpPZG5wUm9hK2pMVzZIZ2NpRVpUeXdNQnJuNkwyaUFw?=
 =?utf-8?B?Y2dhQ0NwUGVRZE14SldGUEhBTWw2d0JUWDYwNmljZlVQdEZnTExJUWhNTjJj?=
 =?utf-8?B?OGlBYTFYY0hCblRncnd2aHFhZGVKYkdIUFNNMVNwSWFUa081Y2ZPNzd3RllD?=
 =?utf-8?B?andGR05Ec3l3dEpzcVBDbnhTZVFKMTdNN3RBajl6ZkhZbkxNek9IenBsc1Ji?=
 =?utf-8?B?aFNtMEhBVlRiNW5kWHgxVmJFTHgveEJPV09KNTBINmw2bXBGNVovSjlhdW5x?=
 =?utf-8?B?VjYzZEkydzFnRXBMaTdoa3ozSjY5MlVZSHAyYVUzdTZ5VnpvUU1nelpaZUNU?=
 =?utf-8?B?NFBuUlhhTm4vMG9RR1doSFovL2llS0pYbkdEbmlQRUUyTnovTit2ajdLR0lX?=
 =?utf-8?B?d1BzUjJFZmhKZk9qL0dkT1dLb25rcnU4QllRREZ5R1RiUFE4b1JpZVA5NjR5?=
 =?utf-8?B?NXRrbjZscVh4VGdBTEErMWU5YnRseXRZbTJ4T1ltQXJqNHNFOE9iZ2dRTEpt?=
 =?utf-8?B?Qnl0dUpFWEVpSGRsc3gza0xGTWpsanlnN2dQMG5idjZ0YjhLVzN6UVM3Q3M0?=
 =?utf-8?B?SDZhem5SRUIvUWxtVURmcXlnRDJ1dmFaNkhUdU9STnQraHIzSVUyNzl1YmJt?=
 =?utf-8?B?TTBrR0FDVHhxOVplaktrTExqdjZIb2xDTjdMQnh1a0FUN1R3TFRId1JmS0NV?=
 =?utf-8?B?bGRFaGNzQ3pjcWx2anFzU0hWd1lkdmNDYVczaCs1UE9zaVNVTlRNZFZ0VmpG?=
 =?utf-8?B?T3I3b2t2OGU2MWJib2ZncXhPWjlwZDU1Tm5ZTjJMZVVSZ3M3SE5BZzcxWVgx?=
 =?utf-8?B?TVl1NTZ3dWd6MW5UQjd1UjZsaVg2RnpSc2lSMStnOGRwOHlsMGN1VXhqQkZT?=
 =?utf-8?B?YTU0MitzNkJpYitDNFNqNmdKaGV5bW9RbkRxOFJvdjBKYTgwT3NuUDhpTVVv?=
 =?utf-8?B?QkdpczdaZ29VUVJKMVBKVTlBT1hVbzhNdTVOVEkvRGFZVDVkWWRUaU5PTXNj?=
 =?utf-8?B?V096T28zNmhzN091dXJGWEQwNlJmWCtvSHdQcmNaRWxFTnB2cmkxL2M2R0pO?=
 =?utf-8?B?R2JMUGh5K25BYUFvZlVsL09YNm0vZGxuWHJhVWR0SHNGYUhvalhSbUg2Mkhw?=
 =?utf-8?B?WjNpYk9nYmJic2dXeFEvRk51SUh6SEZpUUprZjB3am43ZVZPTlFvNXhDdHRj?=
 =?utf-8?B?UERGQ0RXTTA5MEl2MDNtbEJiT2NINVhLK2g4UW9kUjlwRzI3NmkxdEkrYUNN?=
 =?utf-8?B?SkQzMnhleHRFNFF3N3JaZWlEMmlSN0x2ZmtaR3FzSGVheFpUY2RES1hNYVd6?=
 =?utf-8?B?NVBtRnErbGhSVnV6Q1B5QUgvWXJ6Q2o0dENIWVp5b2t1Mm1xZEFhd3ZxKzNY?=
 =?utf-8?B?RCs3am1sb0lJZjNRdkdFeElNazI4WDJldmRTM2VyNk9QVXRwb09lZEpaenZr?=
 =?utf-8?B?RlBzNnlhbldDNUNlZnQxWkxGYTBFOWc3b2ZwRVdvMFVNT3NWWmVrekhYOTRy?=
 =?utf-8?B?aE43ZGlocHV6bWpZUThLcVZZeFNLZVJvcUN1dTJEd05zN1dNREZsZXhoZHp2?=
 =?utf-8?B?eGhieTJycHM0anZaRUFlb1M0OFU4SGFMT0JVazYrQWF1emRGQzFraHowWDNY?=
 =?utf-8?Q?Qq54xY?=
X-Microsoft-Antispam-Message-Info: EKBUOIkK0/PMcWh9Vsw9P3K1X/VA4TQfc9rpfitdIzFXM3Y8TY3v8cR27ebFp/h55YyI7czBvBCCrzZKckwJbz98Cy0bnz8jCXc8UtQVrGVQR0nLTkL/r+tycyqSyT95afSCUvYiWQoFOBOwk1Vubou+0KiePS8BxnYKZZCfYGDzqhw8GdnJfBt4R07rk7fi
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0757;6:dSIk3siaT5J/nNZR4zzz6uDSYaZnO9ujUeLDciILbUuO6+LftMKAGWeZ29Hm0IkqU+2M44KoOCHbSUcTP/wDbqkLtYbtV+XzUFAsvA2O6+jBZlUQ94hddsHq5mvH40woGNmeSC2E6R1en9XjnYI8Q4pfBJVxvHEKXQH4L7YiSgAhaSNf2U/A2jDJxeXHZFEz5Vu+oy9zktge6H21B4AS3aDtHOpfze+TnqJT+VVfCMYHz0cZbZfblnkJc/2sjHIN4KlsVT3hdCtQz2vbig4SSzw/JsF0mrdDIFSIjGNI0sloBB6tQ2ehG2ssV/rkJLlk4qR1oL/fzDVdvHLUukQcyoQIzeJURcn2v0GTmiUDy7vIruZ6G1cAAQ0+sL0fF4EauS9VTkPEDXoSi138xgK/BTZNEhAQIx88cFb10Rnwkd6ae2ZaYL2PMVHWMks/koWHSqSbuT1ooWd8DDyfMB/g/A==;5:UyCQDYF+Lg1huVsWQJl9NRcwpsHtq3caH/4y9xjmOOSiZLWa8wXkLbxeDDXF+3cNA4R4XaoNOLSXKlGPe8FFgH3Se4GXgzzjpiROkEN5quo3LUUgOjOk0xGtBjYfk+2QNt/9WNWZwJ1aFVL5u39B+W31tJPeJ3mIDzRtJ7XJ158=;24:0Aen0+BGbyTl8bCokjDO05dlfLovPrx2sGsZXIu0E4yOGS72OjkOo/I/GDf3h3i97t3hJMR+tA7ASdjfQNYgCyhOcte9f7VmoHt1Bi5c7ns=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0757;7:tfd17r7+URnS5GdfAKI8TsSJx2YFNyggs+ObpOTz588bkzjkGJ8yxMtB6uVmph24UdxxafBiR2x2I/FywX2vgrn4gl1F+brXsaKBTgNeLAJEfPemp5mkALJe0GY+s/qcpG3tX6FVn0RuARtVFfvA8uH2OYEu5Lt5NU2e5TpCXkaDvU0+Xc2FIwvpqAHVo8IO7rXr+Z0bjfplwWro2Y3QfzjHx1R7Cp4W/n9faFzZeXAILEmLzG12OkppNniAQq23;20:nUq00KOzjKlEcAk2ZmEEdRbm1CnSd5Grv+t8NHWSG1/XcY8GvBnVNpszb9+ZfmjlFSdU05KvOrc86umRWyNDJRutVpZgzWE99H27SjD9DKkpleUUwO/caOx4VyrdWEKDjWnFQ7LMQsZtXHEbV3frp1hf7Nsohw6Z8g/BypytFzjzfssYyLyUitA8zWg5744JE/q4YFuJlfA1fy5YAdtVTzsu1TBQtVBKNHeqoK28DCrv3Z4X2cInNuwBXGR/YaKf
X-MS-Office365-Filtering-Correlation-Id: b01b2707-ecfa-457d-3780-08d5abe9bd40
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 02:51:13.1593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b01b2707-ecfa-457d-3780-08d5abe9bd40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0757
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月26日 23:06, Michel Dänzer wrote:
> From: Michel Dänzer <michel.daenzer@amd.com>
>
> When it's set, TTM tries to allocate huge pages if possible.
Do you mean original driver doesn't do this?
 From the code, driver always try huge pages if 
CONFIG_TRANSPARENT_HUGEPAGE is enabled.

Regards,
David Zhou
>   Drivers
> which can take advantage of huge pages should set it.
>
> Drivers not setting this flag no longer incur any overhead related to
> allocating or freeing huge pages.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  |  2 +-
>   drivers/gpu/drm/ttm/ttm_page_alloc.c     | 14 ++++++++++----
>   drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |  8 +++++---
>   include/drm/ttm/ttm_tt.h                 |  1 +
>   4 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index dfd22db13fb1..e03e9e361e2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -988,7 +988,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
>   		return NULL;
>   	}
>   	gtt->ttm.ttm.func = &amdgpu_backend_func;
> -	if (ttm_sg_tt_init(&gtt->ttm, bo, page_flags)) {
> +	if (ttm_sg_tt_init(&gtt->ttm, bo, page_flags | TTM_PAGE_FLAG_TRANSHUGE)) {
>   		kfree(gtt);
>   		return NULL;
>   	}
> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> index f0481b7b60c5..2ce91272b111 100644
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> @@ -760,7 +760,7 @@ static void ttm_put_pages(struct page **pages, unsigned npages, int flags,
>   {
>   	struct ttm_page_pool *pool = ttm_get_pool(flags, false, cstate);
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	struct ttm_page_pool *huge = ttm_get_pool(flags, true, cstate);
> +	struct ttm_page_pool *huge = NULL;
>   #endif
>   	unsigned long irq_flags;
>   	unsigned i;
> @@ -780,7 +780,8 @@ static void ttm_put_pages(struct page **pages, unsigned npages, int flags,
>   			}
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -			if (!(flags & TTM_PAGE_FLAG_DMA32)) {
> +			if ((flags & (TTM_PAGE_FLAG_DMA32 | TTM_PAGE_FLAG_TRANSHUGE)) ==
> +			    TTM_PAGE_FLAG_TRANSHUGE) {
>   				for (j = 0; j < HPAGE_PMD_NR; ++j)
>   					if (p++ != pages[i + j])
>   					    break;
> @@ -805,6 +806,8 @@ static void ttm_put_pages(struct page **pages, unsigned npages, int flags,
>   
>   	i = 0;
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (flags & TTM_PAGE_FLAG_TRANSHUGE)
> +		huge = ttm_get_pool(flags, true, cstate);
>   	if (huge) {
>   		unsigned max_size, n2free;
>   
> @@ -877,7 +880,7 @@ static int ttm_get_pages(struct page **pages, unsigned npages, int flags,
>   {
>   	struct ttm_page_pool *pool = ttm_get_pool(flags, false, cstate);
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	struct ttm_page_pool *huge = ttm_get_pool(flags, true, cstate);
> +	struct ttm_page_pool *huge = NULL;
>   #endif
>   	struct list_head plist;
>   	struct page *p = NULL;
> @@ -906,7 +909,8 @@ static int ttm_get_pages(struct page **pages, unsigned npages, int flags,
>   
>   		i = 0;
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -		if (!(gfp_flags & GFP_DMA32)) {
> +		if ((flags & (TTM_PAGE_FLAG_DMA32 | TTM_PAGE_FLAG_TRANSHUGE)) ==
> +		    TTM_PAGE_FLAG_TRANSHUGE) {
>   			while (npages >= HPAGE_PMD_NR) {
>   				gfp_t huge_flags = gfp_flags;
>   
> @@ -946,6 +950,8 @@ static int ttm_get_pages(struct page **pages, unsigned npages, int flags,
>   	count = 0;
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (flags & TTM_PAGE_FLAG_TRANSHUGE)
> +		huge = ttm_get_pool(flags, true, cstate);
>   	if (huge && npages >= HPAGE_PMD_NR) {
>   		INIT_LIST_HEAD(&plist);
>   		ttm_page_pool_get_pages(huge, &plist, flags, cstate,
> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> index 8a25d1974385..291b04213ec5 100644
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> @@ -949,7 +949,8 @@ int ttm_dma_populate(struct ttm_dma_tt *ttm_dma, struct device *dev,
>   	type = ttm_to_type(ttm->page_flags, ttm->caching_state);
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (ttm->page_flags & TTM_PAGE_FLAG_DMA32)
> +	if ((ttm->page_flags & (TTM_PAGE_FLAG_DMA32 | TTM_PAGE_FLAG_TRANSHUGE))
> +	    != TTM_PAGE_FLAG_TRANSHUGE)
>   		goto skip_huge;
>   
>   	pool = ttm_dma_find_pool(dev, type | IS_HUGE);
> @@ -1035,7 +1036,7 @@ void ttm_dma_unpopulate(struct ttm_dma_tt *ttm_dma, struct device *dev)
>   {
>   	struct ttm_tt *ttm = &ttm_dma->ttm;
>   	struct ttm_mem_global *mem_glob = ttm->bdev->glob->mem_glob;
> -	struct dma_pool *pool;
> +	struct dma_pool *pool = NULL;
>   	struct dma_page *d_page, *next;
>   	enum pool_type type;
>   	bool is_cached = false;
> @@ -1045,7 +1046,8 @@ void ttm_dma_unpopulate(struct ttm_dma_tt *ttm_dma, struct device *dev)
>   	type = ttm_to_type(ttm->page_flags, ttm->caching_state);
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	pool = ttm_dma_find_pool(dev, type | IS_HUGE);
> +	if (ttm->page_flags & TTM_PAGE_FLAG_TRANSHUGE)
> +		pool = ttm_dma_find_pool(dev, type | IS_HUGE);
>   	if (pool) {
>   		count = 0;
>   		list_for_each_entry_safe(d_page, next, &ttm_dma->pages_list,
> diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
> index c0e928abf592..c7d2120f0362 100644
> --- a/include/drm/ttm/ttm_tt.h
> +++ b/include/drm/ttm/ttm_tt.h
> @@ -41,6 +41,7 @@ struct ttm_operation_ctx;
>   #define TTM_PAGE_FLAG_DMA32           (1 << 7)
>   #define TTM_PAGE_FLAG_SG              (1 << 8)
>   #define TTM_PAGE_FLAG_NO_RETRY	      (1 << 9)
> +#define TTM_PAGE_FLAG_TRANSHUGE       (1 << 10)
>   
>   enum ttm_caching_state {
>   	tt_uncached,
