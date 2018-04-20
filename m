Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754656AbeDTKoT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:44:19 -0400
Received: from mail-bn3nam01on0080.outbound.protection.outlook.com ([104.47.33.80]:63904
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754578AbeDTKoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:44:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 4/8] dma-buf: add peer2peer flag
To: Christoph Hellwig <hch@infradead.org>
Cc: Jerome Glisse <jglisse@redhat.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK"
        <linaro-mm-sig@lists.linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK"
        <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20180329065753.GD3881@phenom.ffwll.local>
 <8b823458-8bdc-3217-572b-509a28aae742@gmail.com>
 <20180403090909.GN3881@phenom.ffwll.local> <20180403170645.GB5935@redhat.com>
 <20180403180832.GZ3881@phenom.ffwll.local>
 <20180416123937.GA9073@infradead.org>
 <CAKMK7uEFVOh-R2_4vs1M22_wDau0oNTgmCcTWDE+ScxL=92+2g@mail.gmail.com>
 <20180419081657.GA16735@infradead.org>
 <20180420071312.GF31310@phenom.ffwll.local>
 <3e17afc5-7d6c-5795-07bd-f23e34cf8d4b@gmail.com>
 <20180420101755.GA11400@infradead.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f1100bd6-dd98-55a9-a92f-1cad919f235f@amd.com>
Date: Fri, 20 Apr 2018 12:44:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420101755.GA11400@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:c829:ec8:7386:6638]
X-ClientProxiedBy: PR0P264CA0006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::18)
 To DM5PR12MB1724.namprd12.prod.outlook.com (2603:10b6:3:10f::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1724;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;3:AI3rgySM9O+eSiLrRKBxOjrgLjPRLCo0GcQJc8onpMSdzNZ/iAc81ZM10mQqSNNExb0EyU61S8DoJZ/VQSaYKSx6fl8yEgfeTtmaCjmy662K2uVwdNXNk61ebU/kp9L4XHe+db6MqvgbE3T2mbtztuQR2GvaCOITK3F9BnQR0lQmJ057c3+tDX6TrvuGuC2pY5khzYN26dm8E019Z5xJoBhRYV3bWDi4Afy6STTMiSD+GoS62pGkrNqu/jThCLj0;25:QokxPw2ivWb/X6E+L4gtO9bO+9rDpwuE4IzML8PE0US44ZItqRDV4X4EuPW5n2stmAmxadbRj/rHutJw98ySAwsjEqLdOglKjKKNfslH0xl3M1HfMNaqNx5Jlkr3FJAFaab2H8B+/dLibZD7xoHVvrZJZYxFJlaUVqEYAjkTtnJl8yXeeWP89Epx7pGEzNsO0bWXx6BjErqmDU8ISJxA2krHAnVuFGh/Fc0DGgwjPkwoejEszHkG9RcirvRZPQzTe3TcehrkMVJR4q1HtNwY6xBEUTm2wSnt8EMHaA+fP0t08Sbrsiv56lqq+XNxwk7hLXsMZpeqJVqlqygCXEZG2w==;31:acZ2qA8gZ9uMKae3omWzWxy0uUJLee5rhQh7eXIpJI4jQAzSKhP6yQ4W/XI0MOxuV2oQzfjQdU36CW2nNmcS16zqi5ySNxRokt6Tr1TUYkyArT6vvmb69HZpARitbQEw49Y5t2SgTy7fuu3XVaywJWB2uszPI1Te0tzaUFr1rciQWGf2HH4U58MA9FLtPvQt9g0Wp/Pocyqsckd+MMqVCmjk8bkD6rsLQxza01gmnCY=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1724:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;20:RTmX44ethrfR/ulERyuVfxWg0hmYUVNmHWriHv3B6kiQyQB3n0mUYacHX2CSeoiq5GYzqoW2kM48S9gHI/1+/elCo3bYAGzqRaf6HGfEHOGe2gKFAQkD5OUbBbfATtDAmMDXL6ER3+wv9Pr0ZHCnU/e+SYOl+w/I5HkiwHJFwN0mNcbwe10hMcBpu1jFytyhxcv8yxz38Pwx4ikBz6KBeBx1IVJR3Y/cZcJpE2EzrSvY/l1O9IiZGDtXaA0IC22xQCs1CD55P8cpbnrDFvAxHbA15Os93qKcmjyTiOSs/AIZdggGADP0B1iPNNIIaiOZdlsE7/X6GfZNhar1VT6upeivVl/9sD0o7kgkAVVwh3GwPvISR+84tNgF3VMKTe70pqQzj9P5Pn28YvTjMmCs48ifVSBXjwG4+jgbpM7Zpk1pvFecjNdACPI0UlqnirpHpORIewEJ/k0LC+cgHkLeA9O3cXHk+DT4SmDeHHHG/XAd76HXiIX/NiIv2GPJkZcL;4:MldKx5hhQVyFMz+UIzA0mTiFCtxo2FcvJm1wAlEMUIfHMOmUNI2atOD5o43T64AK7eAFQuM149kYlqjleiucs74iae2gSPnD61A1niCkzIGQtiTsP2ma2suA7l5PsHLGl7hUaTNqbQsoKP09EdM2NBlqdhtEDAq/cC7TN46nMqlzyfryX4LSSnTX6CCqgXozivoqAEcR6KPJ3VPGgffWdrxt8JeWAHMlspqLhnZkcij6+v009S5DIULaPu6QwyXESulo+lxhMr3QRuIfM2rOMA==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1724EE660FB906FF3EAA31FC83B40@DM5PR12MB1724.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501393)(52105095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB1724;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1724;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(366004)(39860400002)(376002)(346002)(396003)(31686004)(65826007)(6916009)(65806001)(8936002)(1706002)(6116002)(386003)(47776003)(36756003)(65956001)(305945005)(54906003)(4326008)(6246003)(53936002)(316002)(58126008)(50466002)(16526019)(5660300001)(64126003)(186003)(93886005)(2870700001)(23676004)(478600001)(229853002)(72206003)(6486002)(86362001)(6666003)(31696002)(25786009)(7736002)(46003)(2616005)(67846002)(52396003)(52116002)(446003)(52146003)(2906002)(2486003)(11346002)(476003)(81166006)(76176011)(8676002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1724;H:[IPv6:2a02:908:1257:4460:c829:ec8:7386:6638];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzI0OzIzOjU2M1lZR3JkOFRuL3FsQy9kL3JPTE1LQ3Q5?=
 =?utf-8?B?S3pkNFU4eGd1dmcxb0RvR3k2QUpRa1RSQWZrUXByVUVheGdnMzVHR3g5NHJi?=
 =?utf-8?B?aEJMZHlTdk5aY3hPeGVXS3FrdkVHTlZpYzBqUytwbll1Q054Z2NFRWVJaVcy?=
 =?utf-8?B?RWR0eTRjdEZUZXAzVUxKZ0VwN1R5WEQ5VTNkYnlJenArQ1NwWnVyaDZaVFBT?=
 =?utf-8?B?NmRjOFc0SGFEeE5sS2c3WDVua2dVQWVnRENrcW43cm42OXBDOVNtZGRkeHNG?=
 =?utf-8?B?ZXlRY2Z6MU1JOHREbmU2dUpWSHJOZ3EyY1M1RGFtdjhUWjJxRUJlajZZL0Zx?=
 =?utf-8?B?d0o1bkt4SEFaRFJPVkw4NjdMNkg5Q2VWVmV3Rk91SmpBVTlwUnJoc0Fvbndk?=
 =?utf-8?B?bEM4cDREZjZJZjhGZ2FKN1U5K1orOXJ6aUxFRFpDTmx0M1hQVkNCekNBb0Q3?=
 =?utf-8?B?aUZZMVhRSWtkbUg4QzVUbUJvMk1ld015OTVPT2crbk5hNWxqdFNidEl3NHVZ?=
 =?utf-8?B?QnBudGdJYWYwMDVTekVMUEY2TmJsSHRaM1JoemlxRGFTZHJGVjlnd3lmLzcy?=
 =?utf-8?B?V1ZoTUlyZ2ZWUkZ2OHhCSkZRMExDbGpOZVgzMkNSL1B4MUdsL0FINUpaVUZl?=
 =?utf-8?B?T0I4dHhUeVhCY1Nkdkl2dXlQOHlVU2gyeStTWTZwa0ljQWhWOGtUQlFXaXFz?=
 =?utf-8?B?NjYrUWxWOVdJeTNORU0rZHZHcDZNNkNCNiszaEpiZk5kL09JeEEyNW9BN2Yv?=
 =?utf-8?B?TGZadHEvbWg1ZGhKTlN3NFZ5Y002VEgyUnlqc3JnNzZHdFhKNGhJQ2dxVzM1?=
 =?utf-8?B?a1VOY1lEK2s4UkM2N28xQStmN3N4OWY3bS9RL3hHL0xYWDFFaSt3WDBUR0Nt?=
 =?utf-8?B?SU5CNzRBaGxCeVFUZkNuOVNPQTVMSTZ2U2FqOXBwTS9vaWhVVUNvTzB5WmY2?=
 =?utf-8?B?bHFXU1RHY2t4d2ZEQWRJU1hlSHAwZGlOTnFDUHdTQjk4M2ovUWdHVTdjNHRp?=
 =?utf-8?B?WkwrV25Sd1FhRUVKL3RaVk9sVStOa1R4UWF1ZlFrTkRnZldMaTVsNjlOYmh4?=
 =?utf-8?B?V0V1Z2syTFdLSTJsa0hWM1NhS3ZqQnk3a1Ywd3puZFdZSE05MkgrM0ZzdlZ1?=
 =?utf-8?B?dUQza24wR2VFcmFMS3RCS2JhRWhLSDZ3a0J5RWMyOU1FZHlaV3JxWGpxM083?=
 =?utf-8?B?MFVDRUVDVlJPUXhmQXl2UTBXTWpVYzkreWppRi9CN2dCR0dOb3dkRWRwMGxl?=
 =?utf-8?B?VDQ3bXVoT2xVTVZOTHpqNk5aSTlVMzF5R3N3bitZc1FkdjlXWU1NOGNxbUdp?=
 =?utf-8?B?eUM1VjgwbWdjYzgvdEhacVpwYVF2eCtOYWdzS2JBZlpjcnFJMzZDSVRBbzNy?=
 =?utf-8?B?eHpnVEVIUmNiUjdFT2dMLzNJY09xcDRIVzRYUmtDS0F1YklFeE5BbEhOWmM1?=
 =?utf-8?B?dHNTanowRWhpRCtvK1Vkd1dpRzRkZVhlQ3hsVFNlOWtPZkZlZ1JVN1NDNzdL?=
 =?utf-8?B?K1laclk0U3FuQ2RnYmw4NXBjc2lGc3pJa21SQ2RkOGZJK093bnlTbk9JMFpT?=
 =?utf-8?B?MSswcVBCZ2phc0c2Nks1Z0xYcHpITGdiSVBYVU1oMThxNThjRDhzQnU3S2ZU?=
 =?utf-8?B?dXlscFBGVDlGZlJzandYZytiYlpVQ3Nnay9VaElFbmFOYWo4dmhTdGd5L1Br?=
 =?utf-8?B?WWNLNVVQWHZmTzY4cUtuYTlqSkQ5OExOMUpxOUdNOURZdnZ2bk4zanNlSVgv?=
 =?utf-8?B?RElVMzZrOVJkTE1scE9EMFRSYjVsdlZTYk1yd2xMQXhqODZmTnVjanNCekJs?=
 =?utf-8?Q?hTT1aoQmidL0F?=
X-Microsoft-Antispam-Message-Info: Hq+JFk88HtZvxvngl1P482gl/7wnjqnuBDzdLAFbL115UdeyTR6tdFRymNffaq+CQPLX0a7eVBjicsCd+JqaxpGM+lRbrYTrTi3DfsvdQcHHDYYbHXuuPWPyGMWq29FfyYHqTM4o31l73qRn85gczL9B8GYyctwbPmS7AYxpRsylDIZ/4ybbLvLThMmuAyvE
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;6:8snuYEqjBcpCjAl3HOgfFe5LG6QerEyUUz66UM1hdlwhCQ0WNFFC3H/7xnNU8sbA7U3VOjWxN1VRFpp+yWDAlc++zU8IFSPcqelWvjHyb7wQ2PIF9bmwwBFSCAZ+DvVdzm4IoZEMzXzrf9sA/q15rU2s4kH3Lh+mQTbaWyHDGuGuUOPgtfW+p77Q1n2XV6xa5JLbFDgFtSox3Q9wUwMyTp5oEqy3IriO7uI5FN1PtffEMe1YSX8wrZKU+GDRPsPeE2tXLmOAM0Xg8qVsr0x/D53+2EYeL5G7zJxBNRi0RV7cSGcNmtDkO0t/HjIJZhpvhejriOT6Xuw35Zj/ddCeIaxR/F8Ie5dOkcxD6YHIRjlrKKn4duH71XkpD9ZNHr0nmaIBjj13YHqNhrQ07TUHp2D2iL//zN2N2PY9ADIsnVzQhG/WFgKodb4xtw25RyuAZ3ba7wKYUz0C7Z+Ogv+wMQ==;5:u31jt+e2xsaURQSYbeF/RqfHOYnDiEi/D6yKI/Ym6OTKAVEaO6uRyMIhwP2FQCMnb/FSyRCK0Wd4HH+UiEitR2D5C2L8GptAIv8E4lzArJ8rbhX3JwxqPlBIcYpPmNqk/jj8KfMdXb3KoZnOmAFnEtMt7pIVnyctMOdGvaQWgOU=;24:kIr5BDL0RTMeFEAgXC4tjwCDGxBC5uJLZt+HVMAApq+ksVnCxCN/V3zEfInleYt+F5lAQ+j7B4ByQ1shp1gowjoBRpn04NuRTC2wYrvnM68=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;7:g/EclMyao98ZozW8xzO/n1WHOh53HZAwVNjF51/HwdzhnJOMJ93eElmmC5P40Fg/dlg8s3XZSNFJ8AC2XAMNNR+92dDbQo/B9BFCFe43SLTcnB2GBCnKNAdPUxd/HBXDB0694vMQIBhRVaX5r8aEGFGORCL9esb8BmbyLAFedR2eHAVdU+gWEyv9rp/Y8Iik/u+rh6Nwwn4JAR1zY0HE1Q6izLF4ECEj7qMZF+XcInGpSE0X9H218VIAhQDeVNvE;20:o4lxekglYrZsRMmZ6RLG2y/K2rNsf6dZnGrk5lrG+fihn34haXd6KOxbbcVaq86uLHR8Cfp1JlXejiLeTJBX53/r96eE7M0+Q8I09euMziFNtTQu4lQB0rywfEKsbxXv9gtnh39amTYStXLDiyl/ZAYWryfHR+d4xcCkRW7FaaaWq0+JGIJPDukZ2ea1l1dkyet1zQwbIM2OM/MOMOfzAqz6Ci39U/nON4WKDb8a5WUArksgGVOtKZ++ipCLgZxU
X-MS-Office365-Filtering-Correlation-Id: cd8a0328-3696-48fb-7781-08d5a6aba81a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 10:44:11.4125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8a0328-3696-48fb-7781-08d5a6aba81a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.04.2018 um 12:17 schrieb Christoph Hellwig:
> On Fri, Apr 20, 2018 at 10:58:50AM +0200, Christian König wrote:
>>> Yes there's a bit a layering violation insofar that drivers really
>>> shouldn't each have their own copy of "how do I convert a piece of dma
>>> memory into  dma-buf", but that doesn't render the interface a bad idea.
>> Completely agree on that.
>>
>> What we need is an sg_alloc_table_from_resources(dev, resources,
>> num_resources) which does the handling common to all drivers.
> A structure that contains
>
> {page,offset,len} + {dma_addr+dma_len}
>
> is not a good container for storing
>
> {virt addr, dma_addr, len}
>
> no matter what interface you build arond it.

Why not? I mean at least for my use case we actually don't need the 
virtual address.

What we need is {dma_addr+dma_len} in a consistent interface which can 
come from both {page,offset,len} as well as {resource, len}.

What I actually don't need is separate handling for system memory and 
resources, but that would we get exactly when we don't use sg_table.

Christian.

> And that is discounting
> all the problems around mapping coherent allocations for other devices,
> or the iommu merging problem we are having another thread on.
>
> So let's come up with a better high level interface first, and then
> worrty about how to implement it in the low-level dma-mapping interface
> second.  Especially given that my consolidation of the dma_map_ops
> implementation is in full stream and there shoudn't be all that many
> to bother with.
>
> So first question:  Do you actually care about having multiple
> pairs of the above, or instead of all chunks just deal with a single
> of the above?  In that case we really should not need that many
> new interfaces as dma_map_resource will be all you need anyway.
>
>> Christian.
>>
>>> -Daniel
> ---end quoted text---
