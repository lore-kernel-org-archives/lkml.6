Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbeDYJJk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:09:40 -0400
Received: from mail-he1eur01on0125.outbound.protection.outlook.com ([104.47.0.125]:42336
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751621AbeDYJJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:09:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jyri Sarha <jsarha@ti.com>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180423072301.11962-1-peda@axentia.se>
 <20180423072301.11962-8-peda@axentia.se>
 <20180423160833.GF16141@n2100.armlinux.org.uk>
 <5d6866d0-75bc-4de8-9b87-4fee5430e9dd@axentia.se>
 <20180424080833.GJ16141@n2100.armlinux.org.uk>
 <8448e90a-4562-b564-c160-1b5c67e0f92f@axentia.se>
 <0cbee3bd-8987-5f2f-519d-f8d1b426f2a3@ti.com>
 <20180424170625.GL16141@n2100.armlinux.org.uk>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <bc00b6ca-38bd-bced-b86f-cbb49e5b0960@axentia.se>
Date: Wed, 25 Apr 2018 11:09:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424170625.GL16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::24)
 To HE1PR0202MB2778.eurprd02.prod.outlook.com (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:dS25E0nozKmAMSKB/UEl70v8V5kAISz/eze3He6DAdccyKXihZh2thBtRySgs5Et9xo8Ddub8aNHXpu9J2GUHFnWAjrCAWiIrGsu7qE0InktgHew5izkr+6gghE8gG/stOuklxQL0MYZskwgWMGcsIGTOz9Quj0rCOOSixj0Mac4IHg3Oeu4AymPZngfFrhS6Z2VEevdhKS/csUQXSe5AgkdDiaAtYAvixxjze0X+Y7SiHBFLW6IsV4hlaRKnaAv;25:PslC2MEXy29DNRF5UdGSm31+uKiqr/F7Xb07tghO59nFZAob+EJ6TmvyflC/QkV+ZcaOPyWSZQ4uJTrGLzA/dPaKCNkeYL7ZcgRvLTrwsnDVp/u5nqBCZP2N+9ltZBlrSx06/Dm0d6ylemsk2D1ylY3MjM5633jZ31Ftlt93ot1ob8rlOQZMWXDBnRjhYvJh8yhuHa1XS2IN/Gr4557xX7XByX07H7G9hitm0lkvvWHJggf2JuYIb2o5GjMyNa/4sqZfzz7yE5LVCH6xPTMHKcGxwFqzb5XFKHiZC+tUVNrx87lfI8bKEoG0pGnj20JtSbJ4iuT1x0JUBCWNl/EPlA==;31:OD80PlVsZvAcefpOug2BPKZEKcZUSQLIapIq+ViAFxSCDdEzyscJ1EhHChtVvtof6yVGD1H02lZ+7d8KQwBVaJrAi2AjW5ODAiY7kLcz2PnrcSJDGCGVbhBGckjvMjge9Lq2EHSP5WN+2CCUOba7mOXjf821hU689UHRv1cqJ9LYHyx3avGnk9ggZj6wi2hVLmJtrcdBMSv0pm9tmO5LNuc+7ouAcsPHSjRdj9g6CF0=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2778FFFE1DAE940A837AE0F1BC8F0@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(20161123562045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:EmwzBrTQ2o3cRDvz0dvLjinBYOwnlKPq8/2381nsbTMMch+LbGvUPJ3M5fii7ya7uDQIFDS/Xd1grlvfTjHe9NpaQgtwY9J0T3KeYcO5AKYWvUEma4582zF+vMB2bvwYLc/CrQuQ3ai6WKwz6SYLTK/1GwcTBP4aicZIHXoi96aDHvYiumSeo5xtruL8xPubZdZ4RvKouSNTL6SKZALuUDc4G/1WCp/vpqLzAwpdYtsmtCn3nTxIzUisBmgxwII1Fq0NfNutNZGS/nuQdvtcuQ==
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(366004)(376002)(39380400002)(346002)(39830400003)(377424004)(199004)(189003)(65956001)(66066001)(8676002)(65806001)(54906003)(186003)(81156014)(81166006)(16526019)(58126008)(16576012)(110136005)(230700001)(47776003)(316002)(6116002)(3846002)(5890100001)(2486003)(86362001)(8936002)(53546011)(52116002)(93886005)(386003)(59450400001)(36916002)(117156002)(52146003)(23676004)(476003)(2616005)(478600001)(486006)(4326008)(956004)(68736007)(25786009)(31696002)(3260700006)(7736002)(446003)(76176011)(11346002)(6486002)(5660300001)(6246003)(65826007)(6666003)(305945005)(106356001)(64126003)(105586002)(74482002)(77096007)(36756003)(2906002)(7416002)(97736004)(26005)(50466002)(31686004)(229853002)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6NGhBOE9LcHROaHlCcDlqNVhWZ2dBSkxO?=
 =?utf-8?B?L1Nka0oyblhSdEJ6Z3BmMEpUN1M4NThFdE44bmt0ZGVoRXJJTkhqWTc2VDJG?=
 =?utf-8?B?dEExUms0cHEwTW9laitwVVlYdlBFZnJqSnFSbVNLbjRXOVcwWk5PdHl4cEt4?=
 =?utf-8?B?MitHMmhoS2NPN0tTUVlFZlF5UVhnb2d4ZllrSHVUc1JjMFJhRWhLclROYytj?=
 =?utf-8?B?aG9rMVY0ck9BdW5xbVhqVTgycUNWQlgrOUdadlBUVWMrU3IxbWdWVlk2SkhR?=
 =?utf-8?B?bGNzRVkvQ3E3YkJEekQ3NUVMbUhLNllPY3NEekRZbGIwRmxUaHFUTmZZcW9v?=
 =?utf-8?B?OUQ3Q090K01QS1pBdm9OZ3d3QmJZZmJRK211UG1zNnZhaWR6NE51Z2JNRUt1?=
 =?utf-8?B?VXE0RTE1eHFJTGlxT243bDZSU1JsU0NZUFlsLzdiZ0ZqV3FsVll1b0h4Y1V4?=
 =?utf-8?B?MHIxSXBScCt1ektTNXBYeklJRkx4ZG5UM0pmb2ZCK25oVjZXRkxHQmVWUjBk?=
 =?utf-8?B?cmo0eWRpbUJDUWJ6bkU3U3ZXeGs1WmVQYmJQKzR0QkRKYWx1KzBwSEVlQTdq?=
 =?utf-8?B?T0oydWtNWXRVWUJRSVBRaDU3NE41V3ZxTCtzWmp4MW9PNEZFaStxWXdtYVdO?=
 =?utf-8?B?L3Q3RnB3L3B3TUc1VnZrOTFMc0kvSUUrZTVFNlgxZURxVnlEYlVBMkZGYzhw?=
 =?utf-8?B?akwwQmM1UE9SdW9UZVBVcmNrSnIwSlVnZ3VjTmV0WE9wTzdVVzhXUThFSU91?=
 =?utf-8?B?ZFJyQkJLV2VCeE5DeHliWnUwakJXZXdneS9PZDBpcXYxZ0hDY2RTcDk0NCtl?=
 =?utf-8?B?NEJ0VFZ6dGZ3MGNrS0J1SHZtdlI2NEJBT3p0Y0hqS0JQaWV3S2FlWk5PVUdT?=
 =?utf-8?B?SytpV1R3RkJnM1BpMGZCRzc3SG56WGhVWmxBd2E2T3Rsd0JNT0VxaC9SQkQ5?=
 =?utf-8?B?N01MTXp0Nmk5UkZmeUhzTVA2Z1ZuQVNhcjFVQWdKNjJESDFRMlNyODduUEMz?=
 =?utf-8?B?ckY5aXBHRGtzMUxDeEdPbnZyNzZ4d29KQlZRTkhiOXZFeS8weEh0eklUbms2?=
 =?utf-8?B?Q010L2F6Wm51MXRqSDI1Q0dNS2R1SjRKOGNqUDNPbFNZRzdiQzNmYkM2V290?=
 =?utf-8?B?TmZYdmxobXl3NVM2SGcrZm5nNy9UY05jR1oxV1VWQjVReGh3ZUdBWWxUQmhX?=
 =?utf-8?B?NmNxQTl6UDc3bC9XZzZTTWRxL3FaaS8vN0RKaFpVSUFUdi8veVdHK1A5Y2FB?=
 =?utf-8?B?dTRzYVJjOGRWVW9US0hmc0Jqam1xY1NIaTQvbTRhenpudk1HWk4xVGtmUy9O?=
 =?utf-8?B?c3dtNnIzUGovYWNCMUlFbFNQazZQT212MHZHb1p1dU5XYmtRemczSmNzc2I2?=
 =?utf-8?B?eXZjSlRSWVNLUlIzMElzYW1WbW1vMTJaZHdQb2FuQlpGQVUvNExCaXFEOTJi?=
 =?utf-8?B?WFdPMDdUaU8zNS91cDRIQ1haVjlhaFRxVDVKQnV1WEUxTWdhWWU4VXNiZnpo?=
 =?utf-8?B?YlZnMzJ2Z3R2c1JXZmxOTmtIQ0N2dkE0VVhuSVp0NnRtbC9oSTV6dnE4Z0cy?=
 =?utf-8?B?dmNSNXZ2RXp6WklBbTlsRHNVcXpwVjJhYk5aNEVGdVRzWEU4M3dFd2N0dlBs?=
 =?utf-8?B?c3V0VE00RlQ5Z0Q1cFRpd0ZkQXZlQ0pmc1JnREhzQkFvNmFXVHBJNUFpUnli?=
 =?utf-8?B?VklQVXY5Lyt6TGhlWlMxcFVxZjBsZzY4NWpZUFpKSjhaS1dwbjBGMWlFaUdX?=
 =?utf-8?B?cjN4VnhZWGw4bXNlSFZSYkFwU2NZOFpFQWNxU25kNmgxNGdvM0lRczliNWhp?=
 =?utf-8?B?WTVyQklOa0REMGRHOVBwZFFrTlp4S0tEMjh4OVA1b2s5eE8ybFNiaGlSNlFC?=
 =?utf-8?B?WGxLMi8vZzc1bEpCV0xyVm1GL2JOQkRkdkp5QUMvNnRtTGNjSVhPdzVocUpJ?=
 =?utf-8?B?K2tZOVAwb3VkdnUzWVE0MEVGZVpGaFkweW1nMjRjQ1c4b2lwUlZMZ1haR0hp?=
 =?utf-8?B?c3JBaWNsWFpKWDh1NW9uQjI1SkZJNEJqTU5pNHVRUHExdks4WHVwd21lUDk0?=
 =?utf-8?B?LzRlekRyT0FMbGdVb0Rlc1M0dmxsMlJYYkpxQjhWSmNULzNXdnhhSk1LQVBZ?=
 =?utf-8?B?UTgwZEFPa3lESW96amNUOGVzd09uVmU5TkdxSkVzWUtSRXVOS2hQOXVwOERZ?=
 =?utf-8?B?dDJ3czBUQ3d6MlpRUjBDd3VYUXg4czRJdHlEZFRKVi9aa3hsTjVqTy9mK1BH?=
 =?utf-8?Q?+ApZGqcmA+vWuqGO3kkc?=
X-Microsoft-Antispam-Message-Info: MutqHAzp9BFOLMj1clwm0s3TjgXsx5+vb0WWZnTzNmZvsNhwSCcYh8fgQTa62/aSwOzri8EtxPPQIlu2zjJzGeN1ukllhEJ8gKgUsL4swtgBA77ZqN7CHdjM7Y+w8usf5oHWrE4AIbg4kF1+z6B3b8736Pty5csH57/QVX9bTi6UW563oYgKSpby42SoLuL4
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:MBvS6p0IeNP8ogUxNaUvCUN+HSGnVZruqCy6xvaIyZCmyVzqRSn9ofqUdhYMKNQotP9Gdsiboha42J3G/3rHy0A2MaZPzTygvpIpN7njGphFP0KHtezFBU2cU7vvTWnmLjCCT3UhwW9XPB0LbfuB0Il1rw/c/qnZgMM9ROcl+wEmVBokOXd5uJFcP3GHpOBUxq+RpHk1EM5RPLMSDGJ4SrtVrqAzQ52/QhUxyaFsTdrApD3W0jvDeFTAE6J6M1CXlg3ESCPlhZjSCN6xjKMsM0u7/aMoaUZ/k/pSqn/DNVF36vS8mqfOEb5ojyDBAPRna4Q/BGbQrJACytOQ7iNncUUWKmOBkaqUtF44Es22uABM8HLMcW7TvkyNzebLxSYjF1FRCNCWu9RF5W5mxyX50G2Llx/UeSqUJwXFDixoIkkQcRRPvxIPv1QvzSNWpMkhEWH7s1/WYULayttrrVCsKQ==;5:f8H+l/gMKDIWasYijf3eo75iUTQ8udhb3wRfcErzHUx6H/cn+Ao3PZZtTEullPNd/4aOyu1MAqhBifwI3uUh/JtuS1hj1OC81pV3YJBQRX+ajMBrtgaioAud4wsAc6J0Q8svDPaWquu27P93qfksnUcJSYa9CTxZUNKniNCphrw=;24:J5cq+QtsQ2KsNV6U5UDVVUt3P61k32nF0gEZ8oZXIA4GpPAaUWtWWo3LrFX3kMCqjbXiRFDjRxiiqqOX5nf+YY5rBZBAnCUWiA+/kb8OJTs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:Teno7W2unP4hq8qt+oyv8nak+GzusY7rWJ2049GeCbeb/xF8R51+yMjuflQjjmXN1F5V+XTk3Hp8SX/kXyMHosyEz57ewf+vlCtzCQe735p3rzZIsOay2ETUijiz/sxxJRMHiReWATDprdMOvZCwZnMp5/HLUr0KccptZMD5epCMGoa9DiY1tLzsmBFyj5X7JyFFTO2uXN5JQt5PBLEyWx8j4HxqS1yxL5kN+HXWSVl7S7w0Q6BVolx/D8m6PVWx
X-MS-Office365-Filtering-Correlation-Id: edb77828-f696-4b32-2f09-08d5aa8c4029
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 09:09:28.7314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb77828-f696-4b32-2f09-08d5aa8c4029
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-24 19:06, Russell King - ARM Linux wrote:
> On Tue, Apr 24, 2018 at 07:04:16PM +0300, Jyri Sarha wrote:
>> On 24/04/18 13:14, Peter Rosin wrote:
>>> On 2018-04-24 10:08, Russell King - ARM Linux wrote:
>>>> On Tue, Apr 24, 2018 at 08:58:42AM +0200, Peter Rosin wrote:
>>>>> On 2018-04-23 18:08, Russell King - ARM Linux wrote:
>>>>>> On Mon, Apr 23, 2018 at 09:23:00AM +0200, Peter Rosin wrote:
>>>>>>>  static int tda998x_remove(struct i2c_client *client)
>>>>>>>  {
>>>>>>> -	component_del(&client->dev, &tda998x_ops);
>>>>>>> +	struct device *dev = &client->dev;
>>>>>>> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
>>>>>>> +
>>>>>>> +	drm_bridge_remove(&bridge->bridge);
>>>>>>> +	component_del(dev, &tda998x_ops);
>>>>>>> +
>>>>>>
>>>>>> I'd like to ask a rather fundamental question about DRM bridge support,
>>>>>> because I suspect that there's a major fsckup here.
>>>>>>
>>>>>> The above is the function that deals with the TDA998x device being
>>>>>> unbound from the driver.  With the component API, this results in the
>>>>>> DRM device correctly being torn down, because one of the hardware
>>>>>> devices has gone.
>>>>>>
>>>>>> With DRM bridge, the bridge is merely removed from the list of
>>>>>> bridges:
>>>>>>
>>>>>> void drm_bridge_remove(struct drm_bridge *bridge)
>>>>>> {
>>>>>>         mutex_lock(&bridge_lock);
>>>>>>         list_del_init(&bridge->list);
>>>>>>         mutex_unlock(&bridge_lock);
>>>>>> }
>>>>>> EXPORT_SYMBOL(drm_bridge_remove);
>>>>>>
>>>>>> and the memory backing the "struct tda998x_bridge" (which contains
>>>>>> the struct drm_bridge) will be freed by the devm subsystem.
>>>>>>
>>>>>> However, there is no notification into the rest of the DRM subsystem
>>>>>> that the device has gone away.  Worse, the memory that is still in
>>>>>> use by DRM has now been freed, so further use of the DRM device
>>>>>> results in a use-after-free bug.
>>>>>>
>>>>>> This is really not good, and to me looks like a fundamental problem
>>>>>> with the DRM bridge code.  I see nothing in the DRM bridge code that
>>>>>> deals with the lifetime of a "DRM bridge" or indeed the lifetime of
>>>>>> the actual device itself.
>>>>>>
>>>>>> So, from what I can see, there seems to be a fundamental lifetime
>>>>>> issue with the design of the DRM bridge code.  This needs to be
>>>>>> fixed.
>>>>>
>>>>> Oh crap. A gigantic can of worms...
>>>>
>>>> Yes, it's especially annoying for me, having put the effort in to
>>>> the component helper to cover all these cases.
>>>>
>>>>> Would a patch (completely untested btw) along this line of thinking make
>>>>> any difference whatsoever?
>>>>
>>>> It looks interesting - from what I can see of the device links code,
>>>> it would have the effect of unbinding the DRM device just before
>>>> TDA998x is unbound, so that's an improvement.
>>>>
>>>> However, from what I can see, the link vanishes at that point (as
>>>> DL_FLAG_AUTOREMOVE is set), and re-binding the TDA998x device results
>>>> in nothing further happening - the link will be recreated, but there
>>>> appears to be nothing that triggers the "consumer" to rebind at that
>>>> point.  Maybe I've missed something?
>>>
>>> Right, auto-remove is a no-go. So, improving on the previous...
>>>
>>> (I think drm_panel might suffer from this issue too?)
>>
>> Yes it does and I took a shot at trying to fix it at the end of the
>> previous merge window, but gave up as I run out of time. I re-spun the
>> work now after reading this thread. I add you and Russell to cc.
> 
> Right, and these exact problems are what the component helper is
> there to sort out, in a subsystem independent way.
> 
> What is the problem with the component helper that people seem to
> be soo loathed to use it, instead preferring to come up with sub-
> standard and broken alternatives?

I think the answer to that is rather obvious. If you design with these
components from the get-go, I see no problem with them, but it simply
seems way easier to retrofit device-links. Just take a look at my
untested patch and patch v3 2/2 from Jyri [1] for panels (that presumably
fix the big issue, namely leaving wild pointers). They either don't touch
neither suppliers nor consumers or are totally trivial (assigning a new
.owner field in suppliers). Compare that with adding a couple of dozen
boilerplate lines with hook functions etc to each and every drm_device,
drm_panel and drm_bridge.

Couple that with the fact that apparently the problem of unbinding
and leaving wild pointers hasn't been all that prevalent, implying that
the problem of rebinding can't be all that critical either.

But what do I know?

Cheers,
Peter

[1] I can't seem to find it in archives, so I'm including it here for
reference. It's small enough.

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 29d2c74..7474045 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 
+#include <drm/drm_device.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_panel.h>
 
@@ -101,6 +102,13 @@ int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
 	if (panel->connector)
 		return -EBUSY;
 
+	panel->link = device_link_add(connector->dev->dev, panel->dev, 0);
+	if (!panel->link) {
+		dev_err(panel->dev, "failed to link panel to %s\n",
+			dev_name(connector->dev->dev));
+		return -EINVAL;
+	}
+
 	panel->connector = connector;
 	panel->drm = connector->dev;
 
@@ -123,6 +131,8 @@ EXPORT_SYMBOL(drm_panel_attach);
  */
 int drm_panel_detach(struct drm_panel *panel)
 {
+	device_link_del(panel->link);
+
 	panel->connector = NULL;
 	panel->drm = NULL;
 
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 14ac240..26a1b5f 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -89,6 +89,7 @@ struct drm_panel {
 	struct drm_device *drm;
 	struct drm_connector *connector;
 	struct device *dev;
+	struct device_link *link;
 
 	const struct drm_panel_funcs *funcs;
 
