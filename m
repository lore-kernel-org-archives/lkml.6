Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934285AbeDXN1A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:27:00 -0400
Received: from mail-eopbgr50097.outbound.protection.outlook.com ([40.107.5.97]:65399
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934103AbeDXN0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:26:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
From: Peter Rosin <peda@axentia.se>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
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
Organization: Axentia Technologies AB
Message-ID: <ab0d5160-88db-3589-916f-ef973f7b506f@axentia.se>
Date: Tue, 24 Apr 2018 15:26:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8448e90a-4562-b564-c160-1b5c67e0f92f@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0043.eurprd07.prod.outlook.com
 (2603:10a6:7:66::29) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:AIT1HVf7vwWubvzZC48WwJOzim91q7tEyHAQ2suPq8PRvHyBf6jl1+9a5G/GhKsgvym/T5DtlkBw9FfEVQK7M449uk/XBfdrYV1hbrwn1r0LjVjivB6bO4Ou2+/kstjQpH2R0QMRAtogwSbJnwrlP8Zaq/w5kFDynHgNVldbKW979Bhr/xVXGXo3BmYdlohrSo0Ukf7hwBOZPkIo2zlWoAvRjY99EI5xxQdNReLJt8X9raTdgPHXINyAaoASR4+L;25:iAsW5KzqIXZmyvie8PF/kx7ndHTM1V919XXiR9NNk37WdGveDupbKwy51QwjzXjpGutJj0Ah1qL15b0eWQIl+DXy9vsssk9Iy02xvNpuEucsiAytLP+hCTSxVAwOaNAyR3ZcGcj+uVg/I8MF6D/J9AKG6rkOA/rcATJeqldSlxzgL5zOxQHEoJ//PMd+y31R4pocnv18YE09M3jPBdHqvnR71mQAOfK16nhy1e+8t05nuVyolfgQ2j0DF5d+xESmy7QYRFBMm0hthzoDs6LgRB7fT9kXpvL5oG4Tt1cQuoc9pq0ckapP/6s2S5Ix7G396ziSJVTHvJke2QpjRyajCQ==;31:7MqN+XsLPy0UqywK5ylGdUJBGeURpRIGMOdJJrGf5Io1QWR8fz+0G23SbWW0dgkBvpKJ5xSs2C2ZFJhOxlrkmUQXrr8fXtFWkCv0TvITeML1EufFQoX1PuPbDPRrfy4Vipv9XsBBq4QAUU+y7dYqVWhw11+ESyFDqneFz1dX/r5/UD3O4SR3w35uIl8W+3P5zh31/TEcAgkj+EjZBudchcTyDpsmUyoxGZ7yI/90HX0=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2770C933D8D3A6B838CB93ECBC880@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6041310)(20161123558120)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:Fnk7kvMvYQ3YbaBtQhnehdN64OM7qlqGd3A2a6BPSbR10T5NtJBmhWaLBbwYZQ7pXCJ7pgLD7MvSlP7nQDw+lgIemQS8wsTHJxMhF3q6FOaSvHH1/m4oXbC/JP8NHLfn9AxZJCqxrN20n61N+8+H0YaO02nHpvB94fbKl6Ic4lPbHqVdoNI5P2Og32eWWD7t4q2a3J7c9x5f9ROoNds0B9v3A9CtzvvLiIDPK5y2T8WFPuA+cqfxe/Z0C6mdZAx7Ma/15OQsmSb4oq1MRbUZLQ==
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(39830400003)(366004)(396003)(346002)(189003)(199004)(377424004)(8676002)(66066001)(2616005)(31686004)(8936002)(74482002)(386003)(53546011)(4326008)(65826007)(956004)(81166006)(5660300001)(6916009)(6116002)(36756003)(81156014)(3846002)(2906002)(230700001)(26005)(59450400001)(6666003)(105586002)(476003)(7736002)(486006)(305945005)(6486002)(106356001)(86362001)(5890100001)(7416002)(229853002)(50466002)(52116002)(36916002)(58126008)(77096007)(478600001)(68736007)(53936002)(97736004)(16576012)(6246003)(31696002)(64126003)(2486003)(52146003)(23676004)(3260700006)(25786009)(316002)(446003)(65956001)(76176011)(47776003)(93886005)(54906003)(186003)(11346002)(117156002)(16526019)(65806001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6MVUwenlZeTlFZmdrdStKTE12TzdnMWRw?=
 =?utf-8?B?eXZrd09VU3A5OXlNdDAxZjJaTDVqNVBycVQrcGNTMFB2RjR1RngveXpsZmhC?=
 =?utf-8?B?aTErcFkxUm1tQkpZNXBkVXZiaGlnQVhxcGpsb3FNRzdoKytuMGpwZEJYV1dt?=
 =?utf-8?B?RFJDbXF0VFFIM2JWUXpZeTU2UnIxN0x1T0tJVGEzalVrd28zSjZtVWVibGs3?=
 =?utf-8?B?U2FKc2Rhd1hrV0NRZnFMbE1mRkdjWGI1L29HY0FSVDBGeU0rUEo4WU9oREVa?=
 =?utf-8?B?dXhjbjJWRU0yNXBqYmVJbnhaV09oRlBXUmtOTnFCSlRjREc4aWo3VTlqVWpx?=
 =?utf-8?B?MHZNcyt4ekpwaVpScjdBTzNlNCtBS1J4Umk1UnFjYWlxVEN3dUd5c2xtdXhw?=
 =?utf-8?B?UDJtOHJrTEJIOE1kR2JEdzFIRVpPc2k3ZDk2NXJSSTNKTWlQL1lQL0hpYVF6?=
 =?utf-8?B?OGxCUnN3dlU1OHJhUlovMjlZc0JiWWcrV01wWWVmOCtEL0dIUjVreHpVVEs0?=
 =?utf-8?B?TkFPRTFBbHpIWHFoaFFVZVBtRGRjbm1pbTdhV1BwbzUyMTRRdlVqVnFpbFBZ?=
 =?utf-8?B?QXFEVVVyd2IwRnZ3STdMTnZQN0xsUVdvdGtLQ0Y3ZXhkNjRwdytMc21ma1BW?=
 =?utf-8?B?YVIvS1oyNDhwY0hnVEhraUgyY3dMQllic0lXU1V3N1VmckgxaE1qcVJlTVlm?=
 =?utf-8?B?TTN2SE1yU3VuZEdnNkFiZWlLMFBjazBXREUyNVpaVXVBQ1pDdlNRaTdvVk9X?=
 =?utf-8?B?RWlXRTBLN3BPT0MxZ2lxQnVYcitTLzl5cDBEZkNDelBDOStITHpRa2tESVB2?=
 =?utf-8?B?VGEzN2NrdzVydzdjcGd4ck5ZMFh6RGlUallKc3k5TWE1RXZPU2w2QWdBbFNr?=
 =?utf-8?B?Yjk2NWg1K0hueTZWRDcxdnNCWlJYOUdIZzBVWG5XUHVoRlFDWkJBZUJOYXc5?=
 =?utf-8?B?Z3VYa1UvQlhMRlFoTjVaZVh1QXdmY2dETSswYklrd0NkZjBaaGtLV1BEYk5L?=
 =?utf-8?B?dWNNVmpGRWZvb0xpMHEvNFdGY2FzR0Z6R043L0hvVFEyYkI4R2dQTnhBQTRl?=
 =?utf-8?B?aVA1QStDRXUvV3pTdFlXRzFuSU50SGlmT280UjZ4QzU0YzFBWE55dllaZ0dp?=
 =?utf-8?B?MW9ESG1UQkVtWG16ZFU2UkF6ZVlmWXFDdzY4OW5wUktWU21NR3ZTdUpOdVFm?=
 =?utf-8?B?ejN3UThaQ05sL2dkVnV5S1BjVk5haVVZSERvWi9Uc2tlbjl4UjhON0tkUEI4?=
 =?utf-8?B?aFF5eFk4QlMxSW1CTVRkL3IvdUJJZTRyWE82aWRDL0dsTFgyUk13dVZXVTVX?=
 =?utf-8?B?ZHNBVGgweGlCdXhwL0ZqWU93elVUdmx6M0ptcWZ5SnFzckVONGtMZEFvUi9m?=
 =?utf-8?B?S2hFejBlNjQ3Wkl5R25yWXh4YkJOZUpldXFETndGcW1NekIySHdGUHUvcmlN?=
 =?utf-8?B?cUNaWkFyS1V4dlF0bzkreEVpTXFqN1UxM2x3U2tBWUNzN0E2Q0xTQllBMWc0?=
 =?utf-8?B?ak5UTzE0MnZoUndCZG5zYUdxV3M0Q0pEZVBpK1dtZTJVaHl2Y0tLUzM4Q1JB?=
 =?utf-8?B?SG1OQTluZENzQ3FNb3V3Y0dwWHJxOGx0c01QVzVEckdYZkRQbXN1MkF2QTJn?=
 =?utf-8?B?d2dzL0QzQTdnUEN0QjRsdHdhYnNwdUVSMzlxaWczcUR0aWNKbkVUc3ZrNi9C?=
 =?utf-8?B?SEl1eHMwV3YvSVkvUDJRcXhGZVRTVUhhSVliTGFHYitRMjFpLzExcGYzUkpE?=
 =?utf-8?B?dlZXdUJxYjYrYm9mR0xWKy94c1hyR3ZyUzY4a3Yrc3ZZL0lmWGxpUkRBbXNG?=
 =?utf-8?B?SWUySS94NExRSVcwNGZsV2xuZ2xHNGIxVE1DQWdpWmxJa0NlQi8xelhTREV6?=
 =?utf-8?B?MlZxNVVMSE5yVG14QnJrcXo4dmRCOWc1U09yTy8vN09LSkRET3dPMlFoeGJT?=
 =?utf-8?B?Z2lwZEptbUozc01aRzFJUmhaODlNeFJCQW00MG1PaDEyWG43aWZmVFRqRzdk?=
 =?utf-8?B?c2JkTElRSTN3Tld0Sm1wMXRrNUpBRmZCaklEeEpvM1JyS2t1U093SEY2M3g4?=
 =?utf-8?B?Y3RJZWpUNHJwMlM1eE1obTFUM0RkdUYwSUFoVTAzcjhpWEI4L28xMDBMSnJQ?=
 =?utf-8?B?Vi9BTEpWWW0wR2JMZEl5RFdldTZJOHIySUJwMnZ2ZkNHcy9BK3pHRVJGa1Ir?=
 =?utf-8?B?ZHYyMXJrR2dIK0VubDg0MXNtS0JVRG9yMEhGWE5EQ2FVay9lVk1rVllJM1Z0?=
 =?utf-8?Q?4tnunlWWV8RZX8OKuhZv?=
X-Microsoft-Antispam-Message-Info: 7yMaohb59ZpxPvM8WMdGSjXoRrwJVLqUxER+xkgvuYHbSiSCLp2dFMO0h54pJJE2TTWif+lbemPSPSplj9jsy0vANKwL/orxV/fPXHxclKHHia6t0lt6r6dpbeOSJ53vkjQRRWdTlJYH/l4EfO0DoIpIRyllE4DH9MW+quhiNA2ngfjF4W3Bs6ZhPpovcguf
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:RahZouq+J+EPhxxiOXoTropcPmHckIR/bGfE8xq0+m48vIs8X+Wg3rPu9UAFMwqZCJrAvtdlvBMpRy3N1xKcJIzvrPsdGUUArXHVglfX7vDvXHFWAoFogtbQv1pFpHeZi3GfIuOyhvKHoCp0s5+Nj6d7pYY9+gEgXSQhlLh7ilTB+YGWgroUC3kybwNEknnP1Q7X1Q1lGwmSZ7jpbS3FBKwsV8TFx/2Wt6dyYqXYrC9kY9UFj/E+iIpoyuqYRtwdKUF/UKxeooDbGz81i8hRuP14o2JZL/rMfayBm+7PPqZVGgtc+pCmNDYxDyxbcu/x48VDHtYbHHRrihsFiJqtp1e+07NKh62REixYcQygVNdsdFFUYWWXAqlRwZtLpcODpCytl9ZLa4OztDi2IL9en56QHerXAX6lzlkShPzixJXsobTwRUbBJo6yPbXuRJNM+EHrDkzRM6Vlvr+tdoRMfg==;5:AvkvcgFXEbrjmX3CwfkECZHkYnOuUq9IntlRQwaYWPDv5fiHCBg5g9uAzJcDgfRFMqGrvHPKGWQQShjtew45zA+W2kISB4l10TQHGBLjVOybmC70OiOrAnV+s695c366ZXUMUgYS5f8AfyREuea2iBgUKPLGQTob2buFn4Z96k0=;24:Bhw1dabyOFGl6vT3TmZCiB88NkW4Xw338eghiMRziZ0Vu/m4Xvk6K45rwH2cdDhUMynNp4IpTjRaaLk0saXDwpR5tkeLpj3lZ5xj1oscIEs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:pARZmbwRnlMB8dhdmgCqrns7YtaG4akw4OzvUUwpnYPDiviaRIovVt6SjjcCnlij8uvC6GTWJZ6cQhdEHXrMRTmdbSae3nFNgz92x5Btblt2CEuoHBZQG9QL3FMmam6fsJy6/Tbwg7ixIXkZPWbH74tTrfWBasFcNosV44W5IvBhf4MXC8L0gmdG8OnqKcXTi+Qvqfpdy1lgXr/SAjls/GebwNpt4UZkoooXgsnZwiRUz7LKSF4STTCWqS0bRmnw
X-MS-Office365-Filtering-Correlation-Id: 96e79c51-7150-4a64-f0e0-08d5a9e707b1
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 13:26:46.4826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e79c51-7150-4a64-f0e0-08d5a9e707b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-24 12:14, Peter Rosin wrote:
> On 2018-04-24 10:08, Russell King - ARM Linux wrote:
>> On Tue, Apr 24, 2018 at 08:58:42AM +0200, Peter Rosin wrote:
>>> On 2018-04-23 18:08, Russell King - ARM Linux wrote:
>>>> On Mon, Apr 23, 2018 at 09:23:00AM +0200, Peter Rosin wrote:
>>>>>  static int tda998x_remove(struct i2c_client *client)
>>>>>  {
>>>>> -	component_del(&client->dev, &tda998x_ops);
>>>>> +	struct device *dev = &client->dev;
>>>>> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
>>>>> +
>>>>> +	drm_bridge_remove(&bridge->bridge);
>>>>> +	component_del(dev, &tda998x_ops);
>>>>> +
>>>>
>>>> I'd like to ask a rather fundamental question about DRM bridge support,
>>>> because I suspect that there's a major fsckup here.
>>>>
>>>> The above is the function that deals with the TDA998x device being
>>>> unbound from the driver.  With the component API, this results in the
>>>> DRM device correctly being torn down, because one of the hardware
>>>> devices has gone.
>>>>
>>>> With DRM bridge, the bridge is merely removed from the list of
>>>> bridges:
>>>>
>>>> void drm_bridge_remove(struct drm_bridge *bridge)
>>>> {
>>>>         mutex_lock(&bridge_lock);
>>>>         list_del_init(&bridge->list);
>>>>         mutex_unlock(&bridge_lock);
>>>> }
>>>> EXPORT_SYMBOL(drm_bridge_remove);
>>>>
>>>> and the memory backing the "struct tda998x_bridge" (which contains
>>>> the struct drm_bridge) will be freed by the devm subsystem.
>>>>
>>>> However, there is no notification into the rest of the DRM subsystem
>>>> that the device has gone away.  Worse, the memory that is still in
>>>> use by DRM has now been freed, so further use of the DRM device
>>>> results in a use-after-free bug.
>>>>
>>>> This is really not good, and to me looks like a fundamental problem
>>>> with the DRM bridge code.  I see nothing in the DRM bridge code that
>>>> deals with the lifetime of a "DRM bridge" or indeed the lifetime of
>>>> the actual device itself.
>>>>
>>>> So, from what I can see, there seems to be a fundamental lifetime
>>>> issue with the design of the DRM bridge code.  This needs to be
>>>> fixed.
>>>
>>> Oh crap. A gigantic can of worms...
>>
>> Yes, it's especially annoying for me, having put the effort in to
>> the component helper to cover all these cases.
>>
>>> Would a patch (completely untested btw) along this line of thinking make
>>> any difference whatsoever?
>>
>> It looks interesting - from what I can see of the device links code,
>> it would have the effect of unbinding the DRM device just before
>> TDA998x is unbound, so that's an improvement.
>>
>> However, from what I can see, the link vanishes at that point (as
>> DL_FLAG_AUTOREMOVE is set), and re-binding the TDA998x device results
>> in nothing further happening - the link will be recreated, but there
>> appears to be nothing that triggers the "consumer" to rebind at that
>> point.  Maybe I've missed something?
> 
> Right, auto-remove is a no-go. So, improving on the previous...

Heh, I didn't address the rebind triggering part at all, and while I'm by
no means responsible or have any deep knowledge, I thought this was true:

- driver .remove for the device owning the drm_bridge is what typically
  calls drm_bridge_remove()
- driver .remove is called as part of the device being unbound from the
  driver by the bus (i2c in this case)
- by registering a link to the consumer, this unbinding will trigger the
  removal of this main drm consumer device as part of the unbinding
- so everything aboput the drm device will be torn down, and everything
  will thus have to be reprobed to get things back

But I could easily have misunderstood just about everything in the above...

And maybe it's really inconvenient to have to trigger a reprobe of the
whole drm cluster? Maybe all drm driver parts should be components?

I have no idea.

Cheers,
Peter

PS. compile-tested the below and drm_bridge.c needs to
#include <drm/drm_device.h>

> (I think drm_panel might suffer from this issue too?)
> 
> Cheers,
> Peter
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 1638bfe9627c..b1365cfee445 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -121,12 +121,17 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  	if (bridge->dev)
>  		return -EBUSY;
>  
> +	bridge->link = device_link_add(encoder->dev->dev, bridge->owner, 0);
> +	if (!bridge->link)
> +		return -EINVAL;
> +
>  	bridge->dev = encoder->dev;
>  	bridge->encoder = encoder;
>  
>  	if (bridge->funcs->attach) {
>  		ret = bridge->funcs->attach(bridge);
>  		if (ret < 0) {
> +			device_link_del(bridge->link);
>  			bridge->dev = NULL;
>  			bridge->encoder = NULL;
>  			return ret;
> @@ -153,6 +158,8 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>  	if (bridge->funcs->detach)
>  		bridge->funcs->detach(bridge);
>  
> +	device_link_del(bridge->link);
> +
>  	bridge->dev = NULL;
>  }
>  
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index b8cb6237a38b..29eba4e9a39d 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -1857,6 +1857,7 @@ tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	bridge->dev = dev;
>  	dev_set_drvdata(dev, bridge);
>  
> +	bridge->bridge.owner = dev;
>  	bridge->bridge.funcs = &tda998x_bridge_funcs;
>  #ifdef CONFIG_OF
>  	bridge->bridge.of_node = dev->of_node;
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 682d01ba920c..b8f33aba3216 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -224,6 +224,8 @@ struct drm_bridge_funcs {
>  
>  /**
>   * struct drm_bridge - central DRM bridge control structure
> + * @owner: device that owns the bridge
> + * @link: drm consumer <-> bridge supplier
>   * @dev: DRM device this bridge belongs to
>   * @encoder: encoder to which this bridge is connected
>   * @next: the next bridge in the encoder chain
> @@ -233,6 +235,8 @@ struct drm_bridge_funcs {
>   * @driver_private: pointer to the bridge driver's internal context
>   */
>  struct drm_bridge {
> +	struct device *owner;
> +	struct device_link *link;
>  	struct drm_device *dev;
>  	struct drm_encoder *encoder;
>  	struct drm_bridge *next;
> 
> 
