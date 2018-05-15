Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753889AbeEOOfA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:35:00 -0400
Received: from mail-by2nam01on0060.outbound.protection.outlook.com ([104.47.34.60]:61728
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753863AbeEOOez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:34:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 1/2] add a function(ioremap_encrypted) for kdump when AMD
 sme enabled.
To: Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, dyoung@redhat.com
References: <20180515015133.4363-1-lijiang@redhat.com>
 <20180515015133.4363-2-lijiang@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <8c8f20cc-b39d-137c-9d71-1e566f905acb@amd.com>
Date: Tue, 15 May 2018 09:34:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515015133.4363-2-lijiang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0701CA0017.namprd07.prod.outlook.com
 (2603:10b6:803:28::27) To CY1PR12MB0165.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0165;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;3:5Cnwi4wvU9x9eMPdb+CshaM4X+IDD5DTOZIfq1zOX+bPItzp/2JlGB8x5Lev9j/GLsE5TcQGnm4KSoQkI8F90KTi9MF2KsaNoYLX6JR5W1C4/DyTXnN1XvG3u/VPFktjDF7hARSO4N01EgiYg4QuuzUgIjZAi43q0qkFT4avLQtsdKI66bB+Ge2pLErjoO8sRu/H9j6ITXkyLVFsIxG7NsVl4RwoXSMFqrzcBdgbWHYhFXk/y0iepg2ryaWdmGl5;25:mkKJlVdQ0rU6HjVBO8AC7Gyq6EdSD6z4eAa7z1GxF1S5mLWaTR3tbxE+TPLCUSz8QqvBPE5paaROaLf3CZS06R+IyDetE8VZRlgOCovTahp/VZp774CU/sNLHec7BiGOKfSSBJlZ8Id0jD/0eHBa/51R+fKk1KaD2VAIVbftZ5QQw6FYNJwqeduYPaNS0CK06Z+RMQSj85U1/PMB7XEox3xm5/YX4K1hHb+Kot2miC1rrInv0+uIn1Kma4uvoRT+ctIyARUJGpqHwG4bpx2HGc9NTNMBF3/gTJUPKdjszk0oBu2n9r6MqMDLZFr5iw7kzncnISu0lgeRIt3bp5C52A==;31:g0FiPPvaBHRLm1YJSUULZ6V/ACRkMYCFOoK3CxVwHlaytrg7cU6TfuyQNYFsV7bjecBRGP+DYSczOl1biyzGGMChtev6cdFLy4giPiScw9ZJTMXnUCV85MamU8oYEGhWFiJegRQO8eit6x90GJeFuGgi5WPfyBEelDzn1SFFtT8gfimAdY6aPh/D6AUsA9J4PWw0UvzgtrlLxY6w+iti4iyPCWIXcgBLtott/LKcCHc=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0165:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;20:VAYaoQXapNhnhtIK75TYbAOyLbB6p4LCEHVM33DM68c+revAqh3JfDk7iUgEPnOZJDHxhb/MIJtvJ6mQLO63LPYqESK4Z4nqTpyEc3uJxonWk+5oxgiJQYLLrpNg4d+OxY8MVLJtFmE/zgvro7S/DRdiqXp/PyBKSqwm739xm7uZ8enud2KylUdHo7Gchq70OA0XdqC97CPH5Y1aqmUCQA7GeTB0XtYny6YdEkPqMEraADrcVJAdUrhznI6L8XUZOd9UV+Ee2sepkZQPKa1q8elVg24uEFMy6v5zKeDRyEBXXBGbBdBklsaEVT0GwLNyDr7I1758UWsPb3YB/6sNmPeNjiUemUD+Jnsu/RDW6sj7qSI0TWPscEXYOhsRbth97Bgocqu1yBGI86IswoGsF6pOns3dqX0VuEPDmOOznlBWVo5Gf25bbj5gyj7JArDBRZf/TPF6JRwgkH0dYd9dSwQpij8uPorEakK7luBOvwcsU1MgzSuMNJULdfB42hdX;4:qPA87tZ3iBX4uujHGCPUl6uL/Sg+o6LFhseb6s93JQtnOK3VXPfWKmQ0p4xfoSpiWbjBjs3DqH7MQ9ZkhAjpB3o3DrXteaY7gBxAJNKWx+DbRejr4DPb31BIriqILu1+Dh7O0xb1iFO4oLIRRr2MOkabQa1VpzRzb53+nF/1uXS9zRriyWtoZYmnWfp+0t/EVbf2alTvSmhZYXF6kUDRowanFIurG6wUXwCa4m2W5UOEYsGM+D9awsZQLYbpC3K+KzCIm9wHQziTIPlJ+Cwpkg==
X-Microsoft-Antispam-PRVS: <CY1PR12MB016516B55A0EA3C8E9527BDDEC930@CY1PR12MB0165.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0165;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(376002)(346002)(39380400002)(39860400002)(199004)(189003)(23676004)(86362001)(2486003)(486006)(386003)(186003)(77096007)(26005)(16526019)(50466002)(31686004)(25786009)(6666003)(3260700006)(31696002)(2616005)(316002)(47776003)(65956001)(476003)(16576012)(64126003)(58126008)(52146003)(53546011)(76176011)(52116002)(11346002)(65806001)(446003)(305945005)(7736002)(66066001)(956004)(36756003)(81166006)(5660300001)(6246003)(81156014)(4326008)(8676002)(65826007)(53936002)(105586002)(97736004)(106356001)(2906002)(230700001)(72206003)(3846002)(6486002)(229853002)(6116002)(478600001)(68736007)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0165;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY1OzIzOnhEQVZtaE5uaW0vQ2diQVA2RGp2S00rVlo0?=
 =?utf-8?B?WDR6aXFsQVZTV1lvNklwMXYvS0ZxbE00RmpaZUNkWklqdTRQQU95aXpkaFo4?=
 =?utf-8?B?Vm9FR0txWC9mOE1xaGxoVTJiWUFkSk9rZU1VakFBL1lobjR4Yk5NMEgxTTFS?=
 =?utf-8?B?Z3dkWXZJbkVYd29tKzQyUlk4clY3ajZxak1WYkZndHV4cHBCVUt0bUc3NC9Z?=
 =?utf-8?B?WDc4U0Q5RjhYcW42TkdDNzJHVStnRzdjc2lYNlJYVnZBQWk5L1hLYkZDZ3ZT?=
 =?utf-8?B?a1V0aTUzdTZVdHdrQzJMR3h4WXprNWp6UFpEYStnWUZmWHhFcFdjVmxsZy9B?=
 =?utf-8?B?ejNLQ2NnQXIvWmdCQjkvc2tiVWUwc0xLMFdxTVZCSjYwTkovNGVNc2dlU2Vp?=
 =?utf-8?B?UCs1UGp1WDRnR2FWdFoxVm1mdzd0NjFHOWZ3eTZyZHQ4TFd4cEJ0TUF1Yko4?=
 =?utf-8?B?ZzdZdlV4cUx2NVgyR2FIU1pFSVU2NEg5a01TS2w0THc4RnpUQmtXUVNYYkRI?=
 =?utf-8?B?UmI3YVhML3BEZ0JjK2RaV0VuNXU1SnptYSt5Um5FUDI1R2pZT0grUllwNzFn?=
 =?utf-8?B?N0s0SHptaDVuYStiWjgydW5SU1FyVHJBN04wZyswN1k2akJqakpGenJHQU0x?=
 =?utf-8?B?TUtUcjd5bHVzVU5idVNmL1dzWVBia0hpaUhJRFVBR3Z0QVNpQWNXY1F1QU1q?=
 =?utf-8?B?MGZneks4SjdYdFZRTmJmQXlvaDFsTnBld0l3NFNoNWNTb0VRbEtZVldaTU9o?=
 =?utf-8?B?eXY5ZkpuN3F6T1QvVmNlbVZja0NHaDB1eGl2RnhPZ2hldVVYWi9iTm9lUFZk?=
 =?utf-8?B?VFhjNisyM256WXFObjQ3VnNNY2dKMHlsaFdNOGNjSTMwTGxPM3Q0RXBPVjk2?=
 =?utf-8?B?TWZBcXJuSXdrc2lsTHNRREdIeGlJMDYvQytJb2lDSUlTenJFQmdNblg5b3d4?=
 =?utf-8?B?WUMxU1I0RjRiMXdzTnZuTFUyN0tranJuZG1uNWRYQnphRGJJKzZZTlJ1TStr?=
 =?utf-8?B?RmllNHFydEFWT3RwM01NSkZoOXhPSythU0RLejA0cXk0QnhZNFJSTnIzRGl1?=
 =?utf-8?B?aVZNeHQ4dHhKbzRIK3p1Wi95NnhFMkJTNDlqcTJMRkRLZFhiVzBvdmpzRkIz?=
 =?utf-8?B?QlJzR1lQZEg5UDJxcFZwVy9GMWltK2kwOVN5OVY0MFVVamU0YkdESElJdzU0?=
 =?utf-8?B?WnExU1NKUXJIZlZDTFZ6WGx1WDVkSjl1SFpCbzd2K045RHE1T1B4dGJqMExG?=
 =?utf-8?B?KzJ2MDFNNnZ1Rm1USEhXeG5hUGE2QlFoNjgzZnNKMm54NlkwTlZESGVZbHJL?=
 =?utf-8?B?NVh5dTZscVZ2NUVWTG5RLzBWWitJanpsK0pCbmRTelMzbEJ4NDV3UlpRNnFC?=
 =?utf-8?B?NnRWVGg3dE4va2p0VXF6MDRTdkcxTVlDdDBrcXlVOGE3OUVuMzdNWG1GQita?=
 =?utf-8?B?UUVjdjc1WTI1N09OQ0xzUzIzL29ZdjVLK3FJWEczTzJyd2FWaXZzNzF1N0g3?=
 =?utf-8?B?Z2VoNnFlV2hSd2tPNGJlTStEb2l6aUxPN1hCK3hQaDlMRi9LMXVpaW9BN01j?=
 =?utf-8?B?Sk1ORXpUNk9PZ0FQUHNyaVhKNHBYNWtqaUtxUlBwZGVkbHFEY0ZTNzRLK291?=
 =?utf-8?B?MXpkdUE1N1NISVp6MHlTNkc1MjRUZGRITGNQNnMweU5vbmdmTmdxaFROaVBs?=
 =?utf-8?B?aldUaXVhdEcxM0JpQzNWVXBNQzBhakJrRkVxWFhZS2RQZDREMFUrcEJHamMw?=
 =?utf-8?B?am5KSGhYZmhyVFZSaWNHMzh2N1ZvR3o2R3VLV0ljOGo4VlRLYWJobkxIakxr?=
 =?utf-8?B?c05vT3dmM256REM5MTBYeFk1bnRWS25UYy8vYmhEWlphUWx5ZWc2Qk9ueEti?=
 =?utf-8?B?R05SeWNzLzJ0czFQaVpPeVZ3OHhRKzhLOHBLUlhxVnhra3BqRUZzaGFwRm8w?=
 =?utf-8?Q?TfnOlD6K61g0IVphHWP9lSp5oXiQxw=3D?=
X-Microsoft-Antispam-Message-Info: umbFmSW4TRtHoyazIlCPipHuGHBhejKXdqjQvC1yiyPLk2qDufBdOW6X/vFbGdN+Vlye9CwguzFE3d4E8okG5KpbNsR/QGreskvagToFR7ZY+pmSSnH5CqW0kvhDPBG6MhhCn6Q75zShGagLpMSgriRgoWrPa19evrzUSkjx6EvZqzFnV6tf1WR0Mb77X9Y2
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;6:vxYx4fbw2VADjHHYLoyL/egMWJ7SK50iRo9h6VYRi4tfy1+vULAoA52pLhjT2vsqU3Vu/JfLJ+wr8p1LieDlGvKm0p/jXF9CQq3b2CfhWTEde8QHbN7ZTEKwxh6ZEGwei5UZ9DW0mlABqKlnQ3v/3v4tpBEgQsNUP1TfD7lqjjrkXmpjeGTPhXDzWUHfZsOu827piTCshQ66OPXbTfg/id/RRnShuZFy4RT8ZoOF8xYWyaZBsymj6aMXZVVbpSDFh5sKmuSh/gk/KRqdM6iF/vVn6N7tTkHQ2B+R92xm5kayzJhuIvvTVQi83uiYmEGQvR+gPhP6nu2BfiYqSeEAoFAgrYhtID72o+jsHIv48W9HtztqB6suimEVF64vCL+pzT71iRf2nT4PYsYYZr01Oxdfh7beCVK0C3fSRf0ZsIqHszjp8P0YCGffblrxzvmhnIzJlKvY364hq68nHZ+iRw==;5:hv7YpEdOUgWCUm6Ev7vDD95ulBpUKJ4HSFbMEvd9QHJj/ZGn2CI69iXo7gn054x5uJaWVbZDeY6w/rNl4681g9/z1SHByYHIcEffPqjkDyXXry9avqdSwwbUFOBx9axWGs7SDHdwo89GXRWTagul5LzOi3KqAwrg2agoJy+oTXs=;24:9Zdgo02d2CMZUGfkHLCOtkQnkc2Xje2+wSTP+nd+dCku2JSixTCBXmUPB+J1ihB+3361CaLss4FXloAQ76lStJyZtNg4KBqqTmpf+j2fn0w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;7:ypHqSoJTo+IBdIv4W4iPQqwCd6N0rt7CSpyJV2xlGow+5UEQiZ3dTkx+tbBjTJvJpDbx/83c3shng7fchTtWhLYaIlCt3V2ugihar7ykOko7N0IO9KQ3mpnUVpDiIZzgk4eSUeiUEDNtqDuD2Vc6st3CFYp1RZJu+wQ6MpjToYuWJrvxgC4bda3YGzTEogBhKDsIShcSKLtnMEn57cYaPh4jgSYqbFWneTA8QRfMlX7x+G3uhKk7mlMPSqKiodBq;20:UenEgdJEfuXENtLmm1LhdVSur8IgjPX6ZeYFGnYyx5D6hvtqd1FHPYg4zTl1QTLC50icox9hrhGm+YOH1JiyLRGs11xnz8Ax/GqQaeEfTLUuHxkOnhzciVKsTJxfZLsR/o78TGlqlkKLU6pGS9NJs2Ya/ZyclzLl1NVJRmVQoXWmFPWlNnQovkP/e7NXT+HTbHk+HG7u8YKd2n+aLwGXIbK8YLP95uxLYkojtC7d3Fa4eHqNrZV1EGHkFdapRDJ1
X-MS-Office365-Filtering-Correlation-Id: 016130b1-c23b-4f51-aa6d-08d5ba710606
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 14:34:53.4839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016130b1-c23b-4f51-aa6d-08d5ba710606
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2018 8:51 PM, Lianbo Jiang wrote:
> It is convenient to remap the old memory encrypted to the second kernel
> by calling ioremap_encrypted().
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/include/asm/io.h |  2 ++
>  arch/x86/mm/ioremap.c     | 25 +++++++++++++++++--------
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index f6e5b93..06d2a9f 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -192,6 +192,8 @@ extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
>  #define ioremap_cache ioremap_cache
>  extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, unsigned long prot_val);
>  #define ioremap_prot ioremap_prot
> +extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
> +#define ioremap_encrypted ioremap_encrypted
>  
>  /**
>   * ioremap     -   map bus memory into CPU space
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index c63a545..7a52d1e 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -131,7 +131,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>   * caller shouldn't need to know that small detail.
>   */
>  static void __iomem *__ioremap_caller(resource_size_t phys_addr,
> -		unsigned long size, enum page_cache_mode pcm, void *caller)
> +		unsigned long size, enum page_cache_mode pcm,
> +		void *caller, bool encrypted)
>  {
>  	unsigned long offset, vaddr;
>  	resource_size_t last_addr;
> @@ -199,7 +200,8 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>  	 * resulting mapping.
>  	 */
>  	prot = PAGE_KERNEL_IO;
> -	if (sev_active() && mem_flags.desc_other)
> +	if ((sev_active() && mem_flags.desc_other) ||
> +			(encrypted && sme_active()))

You only need the encrypted check here.  If sme is not active,
then the pgprot_encrypted will basically be a no-op.

Also, extra indents.

Thanks,
Tom

>  		prot = pgprot_encrypted(prot);
>  
>  	switch (pcm) {
> @@ -291,7 +293,7 @@ void __iomem *ioremap_nocache(resource_size_t phys_addr, unsigned long size)
>  	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC_MINUS;
>  
>  	return __ioremap_caller(phys_addr, size, pcm,
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_nocache);
>  
> @@ -324,7 +326,7 @@ void __iomem *ioremap_uc(resource_size_t phys_addr, unsigned long size)
>  	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC;
>  
>  	return __ioremap_caller(phys_addr, size, pcm,
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL_GPL(ioremap_uc);
>  
> @@ -341,7 +343,7 @@ EXPORT_SYMBOL_GPL(ioremap_uc);
>  void __iomem *ioremap_wc(resource_size_t phys_addr, unsigned long size)
>  {
>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WC,
> -					__builtin_return_address(0));
> +					__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_wc);
>  
> @@ -358,14 +360,21 @@ EXPORT_SYMBOL(ioremap_wc);
>  void __iomem *ioremap_wt(resource_size_t phys_addr, unsigned long size)
>  {
>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WT,
> -					__builtin_return_address(0));
> +					__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_wt);
>  
> +void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size)
> +{
> +	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
> +				__builtin_return_address(0), true);
> +}
> +EXPORT_SYMBOL(ioremap_encrypted);
> +
>  void __iomem *ioremap_cache(resource_size_t phys_addr, unsigned long size)
>  {
>  	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_cache);
>  
> @@ -374,7 +383,7 @@ void __iomem *ioremap_prot(resource_size_t phys_addr, unsigned long size,
>  {
>  	return __ioremap_caller(phys_addr, size,
>  				pgprot2cachemode(__pgprot(prot_val)),
> -				__builtin_return_address(0));
> +				__builtin_return_address(0), false);
>  }
>  EXPORT_SYMBOL(ioremap_prot);
>  
> 
