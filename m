Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeBVI2r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:28:47 -0500
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:5690
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752666AbeBVI2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:28:46 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 2/2] drm/amd: Remove inclusion of non-existing include
 directories
To: Corentin Labbe <clabbe@baylibre.com>, David1.Zhou@amd.com,
        airlied@linux.ie, alexander.deucher@amd.com, Dieter@nuetzel-hh.de,
        l.stach@pengutronix.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1519287709-28638-1-git-send-email-clabbe@baylibre.com>
 <1519287709-28638-2-git-send-email-clabbe@baylibre.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b6130652-1098-f011-2fc1-26e5969f100c@amd.com>
Date: Thu, 22 Feb 2018 09:28:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519287709-28638-2-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To MWHPR12MB1312.namprd12.prod.outlook.com
 (2603:10b6:300:11::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc36aa5d-36ca-4b42-e345-08d579ce47d9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1312;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1312;3:8+1dD/c4y7aVNV/n7UwTzphy/z6RFe/miLQshwPgV/wXbdtPH2sDkT7GKFjFyQ9KGyWiKmhOiv1buQkLYDzr6AjdR2IC5px+Q1PBjUjuziBxFuvQspaR+kgEUC6G6NgozL4KWsag4F3aXXYzUyvlMqMgudy9JTMb1oZzDtBLy4iCIEa30T+tGQc0ZZBu4yEt8tw18FxU6VbNK70VFEuPe5uq1SbPZpaTvQu8X9CVTd99gBfXdaDW2O5RMuver79L;25:cuwH2oORaKdYG83ZsjqSG4sT3Tsu+h+jYeHUlWa+dzPh089HT3OsTaVEH6px7kjnFb04SJAvfCEuVM8mYHsX9Us5jhRu4qQR0lkFq8L5MJxY1SK7wMps4QnE84OM3eMMhRvOy+/Cx0dD8Itk5Vec70Jfhlzg3ArUPJoEaJ2rPMcIXVSMAm+Y/aopZ5oxWKUpW+7rjF2RbIllZzFHPS4wCwbRuaN4pccEysJvlbAeNqD/bIOdt95O6AS+BlGvdsqyK5ekfXLIjPJIdKuOdf5C+f92Ul+JWwCw6zfKSGsgZGxUCZul8RmkJ0Yi1tCwjv5ZVRwwLA1/uPFOQvm9ptU88Q==;31:nKsPTOIe6NNlZLeKzQEKC1QIdgXLlIIqGcqplEwtuecEOioyES/6U/WrcOsYp638OxB1fbt0STKXNeZW+otH7M40hJgXWfTPMP/gUdlwQsZJlVYA2F2YKe9lC2K/pGaOfTX2Ug76BYyl7Nv6TMZyEyFiSuYcYzphQWwkTEX/sJX62HM55kfmRIIlX6xD70zhjQwHxWTKjb1n/mSXkW8ETtVBMVVvumi9DF2NRb+Al3c=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1312:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1312;20:UK/BS8Vn81y1JjClbWSyJZ1Y0OmdQwrL8lZYXqncgs6gLSg5GzYqNFnsyS2miJRhWp8Ybu7cffd/GqFnRQjrglkQesTwHl0VYvFppoAXuq7Eav2NYsYZMwMUq4CT5iOx1oZ7ArL2uCuK6fTW8OqOQpIVPZqlyINHWx7Fm1EeUl4rXDVgDASY3+OvH8wLumdZ3kNKLNUfCVHDs4q/NbQQbLKr5Hi9S5HL6z6GDcWLjDniWJCeSPAVej6g5zuQTKIC6XgVyeTmiBiHEfTPJmyUqShBtUV7BeLzMWwDDNFg4MGUeMRyKnVvDfWnsmf0BaBXTPOcB37n0gkhHsLAd8E4x+LI62ncb9xAGmAueZWEfb1uxjTwOgr2k4Gy5WCYV07tfLjqzr+K9R+AklYdq4dg25Cxf3NXRDqFzRamKcUaqtwHzbChiC8snZ7pllNmM5jGt0NEoJy4CIE2jK3lYjK6tI0xi+sf0f82utqXJUjp71+iu2TCdnBbgaqfTPMvaNq2;4:J+1awHHkICWPm0YgqkVGeH85U7Gbc0+tOlel0n1FljFSLe+BV6SkX4JI4UlICHVoyDA4D26qh7E3eFwkTX7GXmUPgd9M/m1ZE9wrnJ9qQv5NyUd0676f6Op/psgLdL36bphm+8Hz4WSNcCFtyhgnng3G1LYp8Mxtn/98QJOOza/pqyrD+QT2fj+8KmNUa48s5dmX73Jv9pW8AozQZs7GOG/8W1rM45lTCPEAkb3urs1XUkyxGNZpS+OzmFFI1lgm/+7blR1ZBBoRLDpvg5VtRTNXFErRjMF7wY+lZxv7b2JERn7LUxYLczB1BZqk3bqL
X-Microsoft-Antispam-PRVS: <MWHPR12MB13120C42F1D4133F80B3248583CD0@MWHPR12MB1312.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001077)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(944501161)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR12MB1312;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1312;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(39380400002)(366004)(376002)(189003)(199004)(229853002)(478600001)(59450400001)(53936002)(68736007)(6246003)(2906002)(305945005)(72206003)(31686004)(76176011)(65826007)(64126003)(36756003)(105586002)(2950100002)(65956001)(6666003)(7736002)(2486003)(23676004)(52396003)(50466002)(52146003)(52116002)(5660300001)(65806001)(47776003)(16526019)(186003)(2870700001)(58126008)(86362001)(4326008)(97736004)(6116002)(1706002)(8676002)(81166006)(81156014)(31696002)(386003)(316002)(25786009)(67846002)(8936002)(106356001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1312;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMzEyOzIzOnVqYzZsK1lWZklDM1IzZzJaZDBIYmxsTy9F?=
 =?utf-8?B?czdvdDd4OTdpWUdhWFR2VFM1ZklpaXl1U1RZZ2pLbW04Yzhvcy9lYnZ6c1kx?=
 =?utf-8?B?RzdwRUtSUElDUGNJaHppQUJ4cDZQOFQ0YXVFM2hLMlZLY3p6eTd2SWNqRnAy?=
 =?utf-8?B?U1J4WDR6S3hoRzBkN3liU216VFJTakw3Z052cEFva0ExWjF6c3d4T2x6eHB6?=
 =?utf-8?B?SmdjOEs4WkVHOG50RHgvdGJRanYwTDUvOTJROEI5R2xITHpQdGFNR0NDekQ3?=
 =?utf-8?B?Mjk0cm5TL21vRjNWTWdyNXZQSXRVdHhLcjU4amJCUlBLQnJ3eVJRZU5NbFdR?=
 =?utf-8?B?L0pVUCtEdllBOE9qaUw2Z1drSHg0UjBUSGtHSjFiMHRXQnlnek80aXZiaVM0?=
 =?utf-8?B?bzF4ZzlZNnlvQnRSUURlajZiM1U0TkpxTStabmthQUJLZW0wb0ZYckhUd3RD?=
 =?utf-8?B?TkhzSEtaOU5OdHNTRUp6K3ZtNTVTdC9XZTdDcURVL0dXMnVjaFp0ZzVCc2lI?=
 =?utf-8?B?ekV3ck5zTS9UdEU3QkhPOXQ3dHZEdGFBVEZYdXgrTTVpNVZHQ3U3T1ViVnpI?=
 =?utf-8?B?ZWlGTDhpeklqcE1OR05GeFpId3pMSVBXaGVwVWUxN0JIWmdoV242dlB5R2FK?=
 =?utf-8?B?cGdnOE9neW9iR01qa0FvWFJKak9wNE55OWg1cW05a0o2TzF5UFhpVllPVkFP?=
 =?utf-8?B?S1VWRUJxdXU1UVdFaFEzb1A0ay93aGQ5ekVCOUloMWVEejdiaURKR21ub245?=
 =?utf-8?B?ajRxMTVKbm5BdFAzbzlQRVBVRE5sYm5EaGJyK0MvSkpWNzMrWWYzQkozUno2?=
 =?utf-8?B?MnpGbklQQ1prQ1ZjUzZ6ZVNuZGkva0s1YmxVdTdWajIvbWdETVpKSEJjVEp5?=
 =?utf-8?B?Ry9ITGFUeXgreG83RUVFeFJqVjQ3TTdSKzJWUGxCNGYvZm1DS05pUTBSUWRk?=
 =?utf-8?B?VEVjSVgzdEtZV0tOSi95MHNDQjNJeFl4SkdPcXg2QSs1SXFHMysrcm9tczlh?=
 =?utf-8?B?cTNURHFTd2IrTlhpWlFreGU3MHZXSEsxME9GT2llRXhSZGltZmkzMVo0cFAx?=
 =?utf-8?B?TXNOTDlOUWNQWUhLd0RzRVpNTFowdWlJNG1ZYm1kMEhhaStDSkNCYXFLcHVO?=
 =?utf-8?B?d2dhNm1RK21nd3h1eGp0SUNzbFVVMUdwTDAvMG1Ic2dBWi9LZFhsenkzT016?=
 =?utf-8?B?dVNHWWpmd0pTbDd5dHdibVV4eW9wenY4MThhQXdFWVBYczdDelNNRmIxS2dt?=
 =?utf-8?B?a1MrclRvZjJHRkVMQ3hCYkdSRUpielh1VGNYdVNMZStRUW9NWjdJaEpDaWlI?=
 =?utf-8?B?OTFGRVNmRVdTcGdvYk9YQmFtRkVGekxudk9abk92OUpIYncyL1lranp5TjBO?=
 =?utf-8?B?YTBURHVYVDA1Vy82LzY4T0pXRTdVWmc2QVNqclZaVFVDNEdLVzRlNDduSWVt?=
 =?utf-8?B?WHA4Q3dwcEhzUHdlZWk3YzlaR2t3aTEyN3UzQ2ZyTUxzV3NqbzFXQllPU21Y?=
 =?utf-8?B?ZkRrWjhibmwyVGxIOFBZS3BFYWFLWkJGN3duL3M2dys3SEttbmRoMHprdWdh?=
 =?utf-8?B?L2M3K3FWMXBVZ3NURHVjTVVoeXNoTkQ4SDcwTGVtL2wvNUt1bTJwR1FjRGNu?=
 =?utf-8?B?NkpHUWs1dFZzTXV1K1lGR3c5R3R1OTFYTFlWMDZSME1CcWFCN3VOTE9mUXdT?=
 =?utf-8?B?UElKYjFRQUU4QlhhVnQvRDZvQmNxZkJ4ZlJjbTB0L2p4VDVWdXRsUUorKzV5?=
 =?utf-8?B?VGkzZHJrUlJmbVhGdGRMQT09?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1312;6:d5HqpLUVU079FukWxmE1ROpsltZMxtN0NJciaqZBZQB1Kgti5JNead2aSl0FS2i9AdBz58fMJCyNv7vpYoJ+22TGB/jT4kHmKTjh4Ff+fV5EPREMO3/LNu0tGM/Snak9sRQVDQA6d3jPlkqlxpv/VSGzGNOPvUTIN9HCylmzyZMiyA1d1zU5ehrC7J/+RAGmrXfzaL8P9zatPCAs7pgpq2mnZjOgAxw54HabN+/fUbbFoUy/dKLf1tcGn8DEHNeRuqL4cwctBOz4CiWXroLS70lmelwXuRfx0fV91wSptnhJNy3pmII4aJcBnICbwjJExQGiq7ltqQGFrwnFAl7+F5w4bKlNQsj8O7Z0lRwSD3Y=;5:cbCa/xh54Cwi/pcmyMYdC4ifjcBbklgR6UaMdHq1Ji0SS1GilxFasJaR+8/9e6SnIfYXO/a9Dhr4KKM67P9XB52vAVnexLNwQ7nSA3sleeoj2rm+a8I8PO6RDbZnCWYmLXTEx2SqVGw8G6F8nN6Zxbor0EVYArXVYo2cfR3aFHc=;24:whuOQc6TwTRBA8HKv+qd3cyEzVgUlAJJMoBzUMKNPLul+4HPw3OJgrRhK1SWzlvgEalIrjCvFtJVypiougVq8bskdg8j5O6rbddhMf72KtA=;7:lX0QSMfWKovy8EtRH81H0gi8B5KNYFklOALNVwX/zpzbOmhfxBN6K7xX1p1fC/jhmIpyxdfaQ3vOTrCLcI+m64Ay36uc4MQVua8eqYWS8StGl+pkus/7NT6INtXwCfOHU3IbPERqTgaF1cd1GWNMsZHyoakzq5fXnVc6gTBXnLRC9B505JIVDVcNzZNzBnWP/jcVTC49+wASG7VraA82iueZDoePe8gjSvXhKPoz1wX+BBed6H6rMPbWRFtUeyLc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1312;20:ODeHNS/p1ijoxn6G3D35PIA6IZBZXO4SJD/GrWLRvpXpCOJF2y2vxFBdiutAXFk/3yDdd+LAYkzAvYR9ACpLGp2VRS7oeyuqtQlc6FXumkL1fxRzMPUFt+kutU8CflAtrMLvmI2BVgkhQzGmtwaR+9+qvuamtOUkcPV8lcv5hsWMBnNTxjDnvFAHbV17sE+1KWN9LPoT/MG8K6ydzFOvAZaVzHsTQb2kI4qOXVHeCz6bBA9CxBd5R41+y65LXqhr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 08:28:37.5821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc36aa5d-36ca-4b42-e345-08d579ce47d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1312
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.02.2018 um 09:21 schrieb Corentin Labbe:
> This patch fix the following build warnings:
>    CC [M]  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o
> cc1: warning: ../display/: No such file or directory [-Wmissing-include-dirs]
> cc1: warning: ../display/include: No such file or directory [-Wmissing-include-dirs]
>    CC [M]  drivers/gpu/drm/amd/amdgpu/amdgpu_device.o
> cc1: warning: ../display/: No such file or directory [-Wmissing-include-dirs]
> cc1: warning: ../display/include: No such file or directory [-Wmissing-include-dirs]
> [...]
> This warning is shown for each file in amdgpu directory, so it spams a lot.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/Makefile | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
> index c27c81cdeed3..22c72dffdf98 100644
> --- a/drivers/gpu/drm/amd/display/Makefile
> +++ b/drivers/gpu/drm/amd/display/Makefile
> @@ -26,8 +26,6 @@
>   
>   AMDDALPATH = $(RELATIVE_AMD_DISPLAY_PATH)
>   
> -subdir-ccflags-y += -I$(AMDDALPATH)/ -I$(AMDDALPATH)/include
> -
>   subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/
>   subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/hw
>   subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
