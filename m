Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeC1KDv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:03:51 -0400
Received: from mail-eopbgr30093.outbound.protection.outlook.com ([40.107.3.93]:13232
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752311AbeC1KDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:03:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] drm/atmel-hlcdc: add command line option to specify
 preferred depth
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Takashi Iwai <tiwai@suse.com>, Egbert Eich <eich@suse.de>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
References: <20180326073502.19259-1-peda@axentia.se>
 <20180328093454.4149fa3b@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <ce723d9f-6858-0bad-bffb-85ab036510ee@axentia.se>
Date: Wed, 28 Mar 2018 12:03:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328093454.4149fa3b@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0101CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::26) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 585006ac-7db3-43a7-7d7f-08d5949330b2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:p4yNBOkb2OYgplkZgmsjxGpXaJz5fDjvwQtya8cAcfIin6+ZcA6684Iu9xg/x9RKh49azukFLg6GEI8MhpRnixFhh8eebf6PKWU4jmJZmpwiTSIp/cUI3swKOFPdmvrp0rbUFqgrr11R3TUL1ykq5lqPSDo9zcLt7+7LozJuen+LL3Yqfh9xP9UdPdEIdzvefayP9GXnaszpHWCy03TFIUx77HZzD91pdtEtTFn42k682dMrDDOTAHpnqiHcrMRq;25:Wrnial9COXrsObzNHd8pedRopavaQlFJ6iUOwYH2sdTjRKRKIrH93r1QitXibKHnVL4spyE+6C91dyDtWggR+a3eX3qTfp0bRHc12b5Per2SH/3vepbzs9POovKpW3D2sq8L5Q/odSETb5xEqTCLIZPjZObNgcyt1MX7UMcg2sqwtwl16xhola0BiRmQdNos5i89/0OZBdYaqG10GkWDs0OpkHxydFxVYzrvD3CAsdN8kzUNHIMFwQRwVTzvd/qJCArA1uuOT4NF8XIg37/FagzQOGmENDN1opt5eMd7q1ppCrPCtF6UUdYHjrYc11oMX7SuavDqoCsvy/JqWLiCtA==;31:R/XgC15JmwDABoza94n3gSt8f/AXq97U1TbRu+LqqvYwaiWAIoyMzkxm6hZmcfeJkJDvdZc6ZSjlheps2FFHLjVTAmp9JXodyPO1foHDXI3IPvT1b4bm94MYZ7qIagt2Duc81cOgUFD0QWY6lTYQavHG7CISMuoSYHAiOpAaEFX71YJcZm9vDXbAisnZuUKwPcbsMDdF2oRS6zCSYXJt5LTTQw67zut7qWnFD5DL/KA=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775E3E914EF9291CD49816CBCA30@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:haJFDatTTnKtGtgUXWEkaqVmpTe/7MSdDDUvm8WZWUuQ1say7homKQiiuJnRNIeY3dXN4zhxNSCPViCFAotXmg8gmRk5JCl5WTpsCOyGylW4fZpKFWrmvIL4viG92sXs8nA85aXq1jGmmRqY2NoBcFkc9w8PrJHJalbqoCHl/IMDfQWqDOQZacv/OTznhXHTrjGNuNWqRMx8Dp6AccRzwlgZQ+y93qff9muRetHQJ2gQ7yZ/FOggi+Qq/EKmieH+OdRMHzZ+pdOqdIOyAjHLRA==
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(39380400002)(39830400003)(346002)(396003)(189003)(377424004)(199004)(81156014)(966005)(25786009)(3260700006)(81166006)(65806001)(11346002)(7736002)(105586002)(76176011)(53936002)(66066001)(65956001)(316002)(36756003)(97736004)(5660300001)(117156002)(4326008)(64126003)(58126008)(16576012)(8936002)(54906003)(7416002)(2486003)(52146003)(230700001)(59450400001)(47776003)(6916009)(36916002)(23676004)(6666003)(52116002)(305945005)(6246003)(31686004)(486005)(486005)(2616005)(956004)(476003)(6306002)(31696002)(446003)(3846002)(6116002)(2906002)(6486002)(229853002)(86362001)(5890100001)(26005)(77096007)(65826007)(386003)(74482002)(8676002)(50466002)(53546011)(68736007)(478600001)(106356001)(186003)(16526019)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6WlBWZy85MHlvNlFHU0k4RUxLQlZHTzY2?=
 =?utf-8?B?ZWRVZy9kM1A0SCtXbVRQMCt5bHpMWUdBSGFQWDVQWUFNQmovQ0pFSFJVdGpX?=
 =?utf-8?B?OXRkbXJYdVJEeVJpS3RtRE92cktJZm9GbmVLZmxqbVU2Z1FqSENFNDJwYXMw?=
 =?utf-8?B?ajROTjBsMFI5UW5MRlBHWWtKVjRjM3NEcW1ET0E3NC8wdHgzWWhvUlN6Z1hi?=
 =?utf-8?B?Sk5aTjZSZXpPTWM2dzNCd3QwR2RxSXFQZGYyWmx5TERXUUlQaFh5S3VTVlo3?=
 =?utf-8?B?RUg1NzJNWlZ0ZEJKcWV4RWdBM0d3Sm5xMGhzM1ozdVRBZE9RYzV1NzB0OWds?=
 =?utf-8?B?cFBNeUt0NzJRMDdrUThxWFI1ekx6bUtSbndaZFNmNi9oclpjdlBQTFRzOVlN?=
 =?utf-8?B?bWIrYWdLLzVJUkhGYWxTeE4rSzh1V25kU05UdkFMdEsvaUcrODJlTFM3bjRZ?=
 =?utf-8?B?ZFpWS2RrS0Q3WHRvMTN5bmRucVhaZzNBSUVONGMzTHZEbDBSa2pXYmR3ekN0?=
 =?utf-8?B?Vm10Wmc4elZCN1pMcVRUQXN3RHp4ZnRIbWY4T08wckdsRXFLNmltdGVDaVp6?=
 =?utf-8?B?OUZBOEJvUGkvZlpPdWNscncvUE9MeGcvcWM0aVdrczJTcTFvRG1CeHdPNVAv?=
 =?utf-8?B?QVJlWHYvTXpuR3Jkcng4RFpUWlBIUXJac3hGTDlkc1BRd2F1bGdmdk0xUFox?=
 =?utf-8?B?T2FBdnRSaTZRcEFMOURwb25MNWc3bHRnR0xLVHhjYVNUZ1BqYnllZC8vVmUv?=
 =?utf-8?B?QUJmaGkyKytiWGtnUVVMZHFlVUtldzl1SXZSOGxwLzl1ckZCaEpVUDJkTU9X?=
 =?utf-8?B?WjVhMWF5WCsvSnYrY29Qd1FQcThJcDFQWHU4VS9reWNPVWp3MXQ5UmxDRU80?=
 =?utf-8?B?WHo5MEwxY09CTWp6eXhWNXVGME9PYi9KbWI1OUR1YjRqT2grUnBnd2V3UGww?=
 =?utf-8?B?WnRJekZzL1cyMEdsT0tDRzF1OExNa3FvQkhrOHBPWmY3UjhrdUJBUjZBSDlH?=
 =?utf-8?B?QlRENm53Sm5mK09jVGxCUU9TWDN6K1NMYXBQNFdTZmIvZjFhQ3hLTnlWQ29T?=
 =?utf-8?B?bmpVQUlZMW9FZUE0bGdIaGVOc1lTR0QyRkdONzFSRHYxU0g0cDh6ajhNTEYz?=
 =?utf-8?B?eDBHaklpSHlKVk43eU5OOXZOL3RXVmJYYTdVSnVKNFFSR1BiWS9hNVBpNXl3?=
 =?utf-8?B?NVcrOUl5dTFQajEveWJmNHA1VzROS3hKT3k1VmcvMHVGVnQzbC8rQ01IYzhZ?=
 =?utf-8?B?bHFVdUNqcDRkTVlacFEvbXU4WnY5YUxmUVNFVDBWaUJVQzhwUUlBdkdBMzlE?=
 =?utf-8?B?T3lMRENFYzBSdWdBbHI5bXhlNm93aTlrZ1lReXFNR2gyckYrYnFTV1pQaHh5?=
 =?utf-8?B?aWZMY1ZBdUdCNGh3SVRiTkdIL1FxaVFZclE2K1NZaFdRTXpnNGx6cUdXUnIx?=
 =?utf-8?B?NTVEU2tlZHdqcXdWTllDYVFSUitUZC9zTWZTTWsyL2dxaUo2cFpnWThkV1Bv?=
 =?utf-8?B?MWRPZlVxSW5NbisxTVFQWDRrV1hVbzZBQ25JTDF2UE5qTW1qV0RUN0QwVkRP?=
 =?utf-8?B?am5pUDlYREEyQkJmeUd6Mit2ZWE2cWJYT01JeXprcjloOW1QV0JrYUdzRURl?=
 =?utf-8?B?aWlxZVpUTDFoMmgxM3l5aVVuRjcxeDBoZkxlTGdNQ1Z4MlRTOHJ5UjI3aXN3?=
 =?utf-8?B?V2VMVDE1YnlhVXhyUDZnbDlnL3llYllZWER4TEI5Y3o4VkpkK3Zianhka2d3?=
 =?utf-8?B?QnViRysrSnFkS0FlemRMeDB5ODZqMDRHeDBzaVZTWFI1dzhIei8xK0N5eUN5?=
 =?utf-8?B?SUpSRTc0SXhRbXNQSnVyNlhKbmVIMlo3RVJIQ1FJK04wbC9qYUFSN2JXVnND?=
 =?utf-8?B?QzZIL0ZhUUhQVkxyQmdnUThqSWxTb2Q5MlVleUJKZ0tsWUNwZy8yZU1BVXhV?=
 =?utf-8?B?OVdsMENhd3pLUU9HMzRlYk5HYmlNb3BxQnZvTkkraGs1Yk9nRVVjb2pPTFBF?=
 =?utf-8?B?c0NBcGJhWmVGVHNHUFdIeHJ5V2k2MnczTGFCQ2lMMUt5REsvKzZQMlRqYVlU?=
 =?utf-8?B?MkpNRkZZb0FPSTZTL3ZRcmszQ3VuVkhSYUFtWlVGaklua2svam43L0ZWQ1FT?=
 =?utf-8?B?WDdQUHJwVG9XNkx4aWx4eTlnNzlxQ1dpRUtSeS9KdHVEaDhDbkJzbUl6dWpU?=
 =?utf-8?B?STNYUUpMMXpyUUVLSFRSOXhPY3drTEUwOXQrL1U5bTNHOFoyRWd4R01NSnZo?=
 =?utf-8?B?WVFRNTVKZXBKMGFnNUpVKzZUNVpVYlNsUmV4ai9jcm53NTJBVWJMT3JwMGdi?=
 =?utf-8?Q?fKC1PczHvgPq9u+spQ=3D?=
X-Microsoft-Antispam-Message-Info: x4wTH/6g/GD2dE/DL98SnqNhotjfdc1Sf2JNRmvijeXHspR0Na6eFFNJ261aVX6CvoHh3Va2791bFWlNAAi4JZIHV7IC2PIM41hUl1n8OugBuXRVYWr4gW03gN4spGwrgfYYOareUOM+gMmmBDvsYnqVDmI5q4Keh5vVW0fbJzy+/zjFHRB78pIyZ52N9kGe
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:13+fp2ZH0jbjzXlwSLiNk9+B/kIrmp0NdRHv6ntVpp5geTRfAYWLTaqZPOUoW+3AIEiVP2EMuAIHn6QWnzJncDD+0KIWNLloHy82/62dwVdHHbba/Jimje+v+NNMeX1+cWFYg06yVTyVfi7uHsib/aa4q+YevFtOfH0SiiuOvnO8GelV3NKSUuYfrzD8x/RxHPB9rFW7C5GDL7gsmlhkAWnYf7RJZib4002xA4ryf/j3gCATc+V2JqCSJ9zTiAKCsZtv8NFZttJdps1l+dJPP8eUyvoEFysDyR0SGKbHVNHdc27+k9gwmfr+f7Xt7x9odRVYI1qF68THd9MZj1Iy/wXMegjh9hIEChI6ydeIYtMwBEmC9XcmlZQ3dZy9SU73P3ZEypwDiQIw95/owKw3CfPq+gPQkqHtDRT5Zbb0x0T9ZU0GgRsfH8UY6+NFK7T7OW1PXhxaCI76iUaV680awQ==;5:vEwtlvYNgyT5NhBmMkAE5vQMJXofzougLJi4dqiNau6zOFHR42rAjntgNJ3qnD123MB/XOIorxgs+lYXCFNykHJElqOl4m0jBG1t7qQGsfhCyNuF6nRWC6HRRZ2wzZp/5dGsA4ee7voDuZ2BdgsjCzkoJ8uECPCmeyPfgi9GxlU=;24:65xiXiywLIRNDsKy21GinR3Q6GmDypzARCTMm4LS5eVUjAVkMYjtc881UsRUsHHWbcNvc0DcmafweuqJGkW2NeX4VmUN5GzrrOe8cCGfac8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:bn+xgcujIlSAB0xhLHTq2vmCEKwwhjreUoIrJNYGMMOA4uuXVrJegEjagryu7dT0sFkZgBB+uNhzBG6ZVToY1TeHx3VIh30434TxZR9syaYWrKynYpMqXdmSmHVA5+2TpHyf00L6FhD2gwWEH4AZc+LVGgXnsNQrJf+sW55tynjaUYxl3DET+tDzsgI1IzL4u5BjLZOfOJzJRYpqxh5oXqgR3o/mpJ8+7hmLmT+jg8Jb9YsIinwyIK4ahbSYfgtq
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 10:03:43.0900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 585006ac-7db3-43a7-7d7f-08d5949330b2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-28 09:34, Boris Brezillon wrote:
> Hi Peter,
> 
> On Mon, 26 Mar 2018 09:35:02 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> I have an sama5d31-based system with 64MB of memory and a 1920x1080
>> LVDS display wired for 16-bpp. When I enable legacy fbdev support,
>> the contiguous memory allocator invariably fails with the order-11
>> allocation for a 1920x1080@24-bpp buffer (~6MB). But this HW can never
>> make any good use of RGB888, so that is a wasted attempt anyway that
>> would also waste precious memory should it succeed.
>>
>> Sure, I could rewrite user-space to go directly to KMS etc, and that
>> makes the (attempted) order-11 allocation go away, replacing it with
>> one order-10 allocation per application restart for a 1920x1080@16-bpp
>> buffer (<4MB). But after a few restarts, order-10 allocations start to
>> fail as well, which is only to be expected AFAIU.
>>
>> So, I'd rather not change user-space (which was originally written
>> to target a smaller display) so that I at the same time get the
>> benefit of an early pre-allocated fbdev frame-buffer that can be
>> reused over and over. But to do that I need to tell the driver that
>> 16-bpp is the preferred depth. Add a module parameter to do just that.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> I found some inspiration regarding naming and implementation here:
>> https://patchwork.kernel.org/patch/9848631/
>>
>> I have found no feedback on that patch though, which makes me wonder if
>> I'm perhaps barking up the wronig tree?
> 
> Hm, isn't that something you can already overload with the video=
> parameter?
> 
> 	video=<output>:<resolution>[-<bpp>]

Heh, you are right...

> AFAIR, <bpp> encodes the color depth, so what is the benefit of adding
> this new property to overload the default depth?

...but hhhmmm, I think I will have to have to encode the display size
in the bootargs so I will have to use distinct barebox environments
depending on the panel, but that's no biggie.

Splendid, please throw away the patch!

Cheers,
Peter

> Maybe I'm wrong and the default depth param is actually useful, but in
> this case we should probably make it generic since other drivers seems
> to need it too, and we might want to attach it to a specific display
> engine instance.
> 
> Thanks,
> 
> Boris
> 
>>
>> Cheers,
>> Peter
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> index c1ea5c36b006..f0148627c221 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> @@ -29,6 +29,11 @@
>>  
>>  #define ATMEL_HLCDC_LAYER_IRQS_OFFSET		8
>>  
>> +static int atmel_hlcdc_preferred_depth __read_mostly;
>> +
>> +MODULE_PARM_DESC(preferreddepth, "Set preferred bpp");
>> +module_param_named(preferreddepth, atmel_hlcdc_preferred_depth, int, 0400);
>> +
>>  static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9n12_layers[] = {
>>  	{
>>  		.name = "base",
>> @@ -590,6 +595,7 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
>>  	dev->mode_config.min_height = dc->desc->min_height;
>>  	dev->mode_config.max_width = dc->desc->max_width;
>>  	dev->mode_config.max_height = dc->desc->max_height;
>> +	dev->mode_config.preferred_depth = 24;
>>  	dev->mode_config.funcs = &mode_config_funcs;
>>  
>>  	return 0;
>> @@ -658,7 +664,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>>  
>>  	platform_set_drvdata(pdev, dev);
>>  
>> -	drm_fb_cma_fbdev_init(dev, 24, 0);
>> +	drm_fb_cma_fbdev_init(dev, atmel_hlcdc_preferred_depth, 0);
>>  
>>  	drm_kms_helper_poll_init(dev);
>>  
>> @@ -756,6 +762,16 @@ static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
>>  	struct drm_device *ddev;
>>  	int ret;
>>  
>> +	switch (atmel_hlcdc_preferred_depth) {
>> +	case 0: /* driver default */
>> +	case 8:
>> +	case 16:
>> +	case 24:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>>  	ddev = drm_dev_alloc(&atmel_hlcdc_dc_driver, &pdev->dev);
>>  	if (IS_ERR(ddev))
>>  		return PTR_ERR(ddev);
> 
> 
> 
