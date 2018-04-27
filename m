Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757552AbeD0H2L (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:28:11 -0400
Received: from mail-eopbgr00107.outbound.protection.outlook.com ([40.107.0.107]:22085
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757451AbeD0H2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:28:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 00/24] device link, bridge supplier <-> drm device
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org
References: <20180426223139.16740-1-peda@axentia.se>
 <1881012.XPHlTWYXH6@avalon> <8a9fcd8c-962d-1acc-c2ba-74a3d8f59590@axentia.se>
 <3483427.EaMxDYJt8U@avalon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <11768d9a-91cb-55e3-a026-3663241bffe5@axentia.se>
Date: Fri, 27 Apr 2018 09:27:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3483427.EaMxDYJt8U@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0003.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::13)
 To VI1PR0202MB2784.eurprd02.prod.outlook.com (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:V9MZQo1A4BVegWamV4ghiUJoatLY20yA76Ef2Yj825yjPHE72TjYcKBD49+pBMtzby37ocNT+9Sk5DKNBG/JJh3ouKri7AONdeGVyOJgKIFRu2+bzhJf0MoQ5GZd1WpsT3v+WNuLCgOlGWPRQtQi5DlfOcpKgd92wOljF2L3S2QhqQR+uLGn22TsA4JOlotwfqLMkx41YHuQdC4QdpvzjdnAvEyYeZmDSGqUhNIf7PN/HQ03TFD5WlQiNHNR/e45;25:u2O3p7/2CjY+en3E0f6feCDla59nZPC9T7YUuTlfJPchGCq+rbyfuw50wouE+JAevaxEk7TOEbbL+VZlF9EL2uD0hFZDR/3ZiE0WY1W0UnZIKZhg3l66X3dDgoYKX1jEjo1r+f98qDrZZ8Ka1GwQyyMyOkgFxmf+jg52R6WW8Llkogg5WQzh5oSLKZzG1keT7rTwUvZkawm6ZHsvezEBBrX8r6gekIFK1x2XoibHnu/xVUjFGtwvOZ3uTk8LtT+UAeAyLiZb/ycnZT7soT5c6wR82zpvEqf1GLGM4Bt8obGqiKsE+6SGjIzaub/OdTZkdBUK0n8mXgqgT/oL6KRAyg==;31:366zcOw/+cHwoxTcLDJewOp4Axn0rgYrxD96DVM9Ib5WQSOWOB+wi48pVUuhIjA3JTGPIw9lcSQUZys+f2vpE+dds45Ed+W3xzaGgid+RwY/H7W+vMba3U/bldvRnbtPA26GS6bWgQGQRMuXz7eGscV2tjoeSkHpp6Rcbr9tNUx9QxAD1+BlUt9WARvM2p1bhCWjK094kyR92ICEeusAc8ZWrmN6sIA1w0dXQlT8ja0=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784D5FBA6E4027CA09283BCBC8D0@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501410)(52105095)(10201501046)(3002001)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:1ZAS4NkEYj1HU128rfqdG2jktyvFB6qYdZe9GcQOvKan8OiJACaILi/44st1+XBF9Jor3cALlKs5Si6b2I2N/GJd0FcsErx5uP0hODnJ7PBWa4T5fL6yBc5UypxPA8l1gZJywpkbrwV8T4rW0SdlrougjkcHbl1FL3zMQR5VEfFc3ik6Ia2qmmJ1kIme4NDy5pYvJZ6bYWIsnO0/MK6EFrlmtUh3KiBLpbw0u+Asp0ZmolIvJsj3daKsgg4fybAvIzo8JJafYO9SF0lQkXdn/w==
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(39830400003)(39380400002)(346002)(376002)(189003)(377424004)(199004)(6486002)(105586002)(36916002)(52146003)(52116002)(23676004)(386003)(486006)(68736007)(76176011)(8936002)(2906002)(2486003)(97736004)(31686004)(7736002)(64126003)(53546011)(65956001)(7416002)(5890100001)(65806001)(5660300001)(36756003)(7406005)(50466002)(81166006)(65826007)(8676002)(81156014)(956004)(74482002)(39060400002)(47776003)(31696002)(446003)(11346002)(476003)(2616005)(4326008)(3846002)(6116002)(305945005)(6246003)(230700001)(106356001)(16526019)(186003)(478600001)(25786009)(3260700006)(58126008)(229853002)(316002)(117156002)(66066001)(16576012)(86362001)(26005)(53936002)(6666003)(77096007)(93886005)(54906003)(6916009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODQ7MjM6Wngrc1BRYWZwOGhYUjA4MGw2aTBZK1VB?=
 =?utf-8?B?TENIT29HRlFsZUNRSUpoZ1BBU3NJcFdoZlVwbTdFV3RKSjhSYVNGQisvYWNi?=
 =?utf-8?B?ODBrT21mM1NqcDJkUHhjTDVpWWlhS003OWc0cmNzRUlieGcxNWE0dHhZSnA5?=
 =?utf-8?B?SEJkK2lDY2x3cGI2OUkwOCt1SmRLQ1BtbVJjZnRmYnJ3NWtRUmJCMlU3V3Y4?=
 =?utf-8?B?aWhjZ2gwNk5RZ2tGUDQzTW5VUEdSQXNOdjB4NlhCQ0pOMjVvWHpEem11TTFp?=
 =?utf-8?B?RVhlM1dvK3cxc0dvTWxZeS9RcXpTTk9aY3lJaUdkWE1kRDdTTll6N05kL1Er?=
 =?utf-8?B?WVB5SlJXKzV2eGIzV0FuSVNyY2J5aDNNRC9DZWpiNDR4cmdoN2xmSzBCQVZp?=
 =?utf-8?B?NGJvMk9vUER3NmNMdWg3UEYwa3BrcG8wNGlXYmFiSFFIQk1QdTZBQmZuRmN3?=
 =?utf-8?B?ZU5PTng3aGZnSnBTakRkR2ZGb0hMMzUzZ1NVczZIKzFiT2QxMFB3bUgzNXlK?=
 =?utf-8?B?cFRJQjRRY0o2K0k4VHV1ZjlUbWY2YWJFNW53V2JyQlhEYVZLdXpDdUVOb00y?=
 =?utf-8?B?YVpwVGMzS1ZRekc5YTdaZkg3U3RDbmpwOGM0RW1LL0dYS0gzMWhjRkVIeHBV?=
 =?utf-8?B?YmM4elJEQWFpcXNiZmYvUjAzeHhhUDdwdW9FV3Y4YTJqZU1ub1JGZkorOGNo?=
 =?utf-8?B?bFpEdSszckYrbHNvRC9hMi9BYUNCMkRPc2gzSVpZaHZQKzlHTjN5cEtQdXV0?=
 =?utf-8?B?aTRZMzBJR1pVQXlnbEZZdTdxUXZsZk1vVkZnVXZ4OUFFS1BvVDFuM0ZKUTNQ?=
 =?utf-8?B?ZUdNSS9acUJnRUFoUzg5VkkyWGRjVi81czdoQk1aa3AvTy9NN1Rzamo4T3hy?=
 =?utf-8?B?Vmp0UTVidEJPTDZibmlGLzR0Viszem1HSHFOdXE2ZjRPeXpqVXhzUFNoLzdk?=
 =?utf-8?B?UDFoSkgzcmNCMXRIaDFQT2FoTk9Rc1hQaU5wd3ViSlVjTnRzV2JqeUFwRkVs?=
 =?utf-8?B?UWw2bXdnNkFTREpqQ3NzNk5hQVJoSExwdEloOGx6NmxIODE2U3pkR0pUcmI1?=
 =?utf-8?B?QjBSYlN1TmZFWUZQNmZ3Qk9TL3Vzb3JqNDJpRFZZd0dXbTNIUnEzUStHb2ZT?=
 =?utf-8?B?aFRmVExmaW5DcXpMdjgyajNCSGFUSTNBQVBYNVk1eGZ1aFh3bWwzN1Fsd24z?=
 =?utf-8?B?dmY2QnI1MS9GSlFmV0ZYbUg5UGF4anZaN0hheDM2aTdpZVRKYlhUK2NZcU1P?=
 =?utf-8?B?enlsL2ZsOGdpb0VhOG5OS09vWC9RQ0VBdENvZ3RCc1BZSnNwSkNDczQrNWN1?=
 =?utf-8?B?VW42UWlSS2xkVTZYV0RRWDZFZm80bzd0UGtmZk1ieU9FaGdJa1JlKzJnenJz?=
 =?utf-8?B?T2NjOEVhd1czUG9NcXFKS0o1eXpLMEJNMitmNk5Yb2p2ZDRoSFYwRmpSSjZ4?=
 =?utf-8?B?TDlJcjNiN1U2QVk4M21lUEdLbkkzTzBsRVcrNXpUT1dYOVRBcVVMZ0hLcmww?=
 =?utf-8?B?ZHpPeUVXdENZemhQT2lKamMzYndWZ2lGbUpJdDd4RTBlaFNBeVJ2RUsxQmd1?=
 =?utf-8?B?dzFPaXNuQStneXQ3ZFlKSFJrTTdlNDA1NUJzVHkxMnMxQVV5Ym9BeE5ZTXI5?=
 =?utf-8?B?MTRqMVhQVUxmamlSRE52Zy9lNDI1WitRb0RBSldiMVFhWGRvVzBmODV3RUVF?=
 =?utf-8?B?cTNKZ0lOV2kwbTRiS0lNb29NR2ZmWTVkSEQxZ2VpZy8wN0Y3V3R5eUlWa2Jj?=
 =?utf-8?B?bGYvNzh3cmxtWk85T285UzNSYkh3RmF3eXVySjQ4YlVvWE93dURSWXNoOWhD?=
 =?utf-8?B?SkJxaEpYZi9DM1JhRy9sQ0lIRlhDQUMyWXQzbm1lZi95QTd5UzB2WFFBZ3dr?=
 =?utf-8?B?djBXNHJramJkdlptUmhMM01peXBwOWhBQUtQczlrNXl3UkRCa1JSVUc5V3BD?=
 =?utf-8?B?RWhxcjdoYklGWm1JN25YVS9RVjJEenQ3bnBwaTlTTDUrbVA4MUlxZEhUNmhz?=
 =?utf-8?B?Uitta0F5TUVQdENWdVJySEloUTlJQ2EySlFPNVNoNTVZVG5sS3BjbDg3VXZn?=
 =?utf-8?B?TGcxQ1MxWi9ZVjJUc2pGKzd2bDlSckJwZmhTam5wOGZ3WnlRQnljbUpRMFVk?=
 =?utf-8?B?cnZ1VmhSL1pPMVRwVU5QM0c0cjV5Wkp0cC84a3VyQ25aQzlTYnFiWkJjN2Nq?=
 =?utf-8?B?U1NHQ0dWVHlON2hhTFQxMlpEUUkzMGtxck9INzBFbFkrckJTNWcyTGJNSjY1?=
 =?utf-8?B?ZWg2Wno4cUdubi9obVpqaTUvYnpiTU51eTVRV09DSFk4TWlmVXBoZ3N3PT0=?=
X-Microsoft-Antispam-Message-Info: miB6ET7MxTKRXH29qsBRvxBAek4hm6d+bNJa5s2lDEGEkqkQnM1AO+hdelDQPqgP6WrL93UNjiPpXV5d42cJbO2tf9R27DhC2hZaeE2HtKkg/4bUzF7nXcuVob8reVuZob8OtYaLdstAfbs7i726rMyV8oBnleSKabea7x0TDuotb7JofuA7SwjfG5Vy1tRE
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:w3n1t+i2kjhky6iJxy0nEN/FQ5hhc+T4xDJFP2yiPmian6BRNiq6pocsvbW0nY9+md/QuQbZAoUBkAkli+3NavhZDW6aQl1LW+9gFm2wxYNTfE8wwikoNsh6KbOQy11woHLh4DlgRjEtUvKgf3T2VuKB1BaXgmYNR+wga+24tBCWpYDufoJ7I6bVfUNIvm7yeDIhs92FntVBQqrYMc7rm8x18iZl7R3wanGME9gTal2YA0Uw6Ha/JeqJMjpiCFgkr6lCxjsojspt/MP8+J9N25GTLPzG26I3btxR0dd8C8HJQlYAjooCYfxMYLxKLfUWAU5VhluGsEjRgmE8+rHYrd+44/1bmf89/WKRLCHHs9ewIhqSPC4liKkFpHBGhz29/Pdd3oYFm14kt1oJnoDN/uneH3v2eJAeD4KQcJkb7EvXys4stWUGaX/ULPFV2xOlDosiOAMYlPoRYnN4H2K2QA==;5:I5pVR05YMHt1wJSqeoLFAbttM/3tAVQU4HsTwJU0wmnvf1zoPjms1wi4nupxGGrv8ErOWuPOVS4j+wnIlTjujNWf+uzSJIUqIaq1VtHB+ed5moUWLBY4TSf8Djf7vFlPA17IkVboID0yCtOTsBGk8NBcM/kHaoT4SnUuTlLGfos=;24:XN2SsxfM6ffpqG8FgMO/2sJgvr4Ws/lLm1QRrogD5l2ImUT2an+GEcC06gXgobBnmomwQeDD2wAbeyrJpYvtFLwmOpHAekmwyTvnwgZg4iY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:Vw78vi2YZwVCh119V+UKibe0sn528zzhBgOIq78eQ9jmJWEc39pzTNwljUcOpf9TQKrt/uM6bcZQ5IBWMbHyckI/E6goHc2ksMI47Bm5E/uEHr+5D0xstUZ1Uvbes/FRp/leotulNn23rkLTGXVhOzryqVBL9eSwHmsnD+dwZFd0vxnl6/CMrY43Huu5yiw41aY7vmkY9ZaBLOjEEW/9fJjdhY3RmJeXxr0x3RmJMWpXnYQZLlt4ZcHJ23W1OkbY
X-MS-Office365-Filtering-Correlation-Id: 6c90d225-a8b1-4448-04d4-08d5ac10696a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 07:28:01.0021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c90d225-a8b1-4448-04d4-08d5ac10696a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-27 01:18, Laurent Pinchart wrote:
> Hi Peter,
> 
> On Friday, 27 April 2018 02:09:14 EEST Peter Rosin wrote:
>> On 2018-04-27 00:40, Laurent Pinchart wrote:
>>> On Friday, 27 April 2018 01:31:15 EEST Peter Rosin wrote:
>>>> Hi!
>>>>
>>>> It was noted by Russel King [1] that bridges (not using components)
>>>> might disappear unexpectedly if the owner of the bridge was unbound.
>>>> Jyri Sarha had previously noted the same thing with panels [2]. Jyri
>>>> came up with using device links to resolve the panel issue, which
>>>> was also my (independent) reaction to the note from Russel.
>>>>
>>>> This series builds up to the addition of that link in the last
>>>> patch, but in my opinion the other 23 patches do have merit on their
>>>> own.
>>>>
>>>> The last patch needs testing, while the others look trivial. That
>>>> said, I might have missed some subtlety.
>>>
>>> I don't think this is the way to go. We have a real lifetime management
>>> problem with bridges, and device links are just trying to hide the problem
>>> under the carpet. They will further corner us by making a real fix much
>>> more difficult to implement. I'll try to comment further in the next few
>>> days on what I think a better solution would be, but in a nutshell I
>>> believe that drm_bridge objects need to be refcounted, with a .release()
>>> operation to free the bridge resources when the reference count drops to
>>> zero. This shouldn't be difficult to implement and I'm willing to help.
>>
>> Ok, sp 24/24 is dead, and maybe 23/24 too.
> 
> Not necessarily, maybe I'll get proven wrong :-) Let's discuss, but I first 
> need some sleep.

Ok, I'll add my view...

I don't see how a refcount is going to resolve anything. Let's take some
device that allocs a bridge that is later attached to some encoder. In doing
so it adds hooks to some of the drm_bridge_funcs. If you add a refcount to
the bridge itself then yes, the bridge object might remain but the code
backing the hook functions will go away the moment the owner device goes
away. So, you'd have to refcount the owner device itself to prevent it
from going away. But, you can't stop a device from going away IIUC, you can
only bring other stuff down with it in an orderly fashion.

Components, that some bridges use, takes care of bringing the whole cluster
down *before* any device goes away, so that is obviously a solution. But
that solution is not in place everywhere.

Now, my device-link is pretty light-weight. And it should only matter if
the owner goes away before the consuming drm device has brought down the
encoder properly. If that ever happens, we're in trouble. So, the link can
at worst only substitute one problem with another, and at best it prevents
the fireworks.

Sure, there's the reprobe problem if the bridge's owner device shows up
again, but that's pretty minor compared to a hard crash. And there was a
patch for that, so in the end that may be a non-issue.

If some other solution is found, removing the device-link is trivial. It is
localized to bridge attach/detach and nothing else is affected (in terms of
code).

Cheers,
Peter

>> But how do you feel about dropping .of_node in favour of .owner? That gets
>> rid of ugly #ifdefs...
> 
> I'll review that part and reply, I have nothing against it on principle at the 
> moment. The more generic the code is, the better in my opinion. We just need 
> to make sure that the OF node we're interested in will always be .owner-
>> of_node in all cases.
> 
>> I also have the nagging feeling that .driver_private serves very little real
>> purpose if there is a .owner so that you can do
>>
>> 	dev_get_drvdata(bridge->owner)
>>
>> for the cases where the container_of macro is not appropriate.
> 
> I'll review that too, it's a good point.
> 
