Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbeDXKO7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:14:59 -0400
Received: from mail-eopbgr10109.outbound.protection.outlook.com ([40.107.1.109]:32544
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932511AbeDXKOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:14:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
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
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8448e90a-4562-b564-c160-1b5c67e0f92f@axentia.se>
Date: Tue, 24 Apr 2018 12:14:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424080833.GJ16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB3PR0102CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:8::40) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:GltSKyR5PUT1VuqYddKYNa8MibDUeihClav1mVW/tK6hPb3V76m5o8ypY5fAnDXtRSk4PJ+D4WSGSf4x8XywHNkAqtwHfrMVEXKdf3NMuhFQdsMNDYkI0qSyjm1dTkKIvg4YbPSXuCmFSpKxcN1LhrWC/pngwkzuBksb3CJF4VgBRW/TXB5VAmwWEOyuabl6uIqCypj/Ogriiq6by1bASjruC77uf1fHkJCIn9KJci0u2vkVPIdd+TkRVQsGbmrQ;25:HAfzNIvHnxf3c1VZbWPciwakMBP5ik9Jg+57ke0IUesMNrPrV2v6SszqpWtipyn+tmgyaf0Eq7WreDJBZj2PnbVZcCfieENXvraVr+o2TcIcIy4RcH8f0qAKTB40K726UdKcJCGmGsRBzlVuTJ+6jeWVbevorzrh+eLtsuiTrB8tl5sUPu16VGxzrEQxu04kqPf0ovVWcn/AEqsy97iFUh43ccYlLL5QI21qCYqkqLGXlEIxdTTc9zVk4kTOVMEazCTQYJSOn8ktZXNftF7yJl8232V2sbD6P+Ab9DaVk3U1uLdMhqIYFqW14/2rSqL+8gQu9HA5FWyi/GbslIHIPA==;31:FQVniSdd8wu2gF0s3rNq11Ix+fGiqqol5Jo5+p4F/vxyKb5mxsNOKpfpcMGD8bWg24NHtLhV0KkXEBrq9SQ+1v8W6kRceVksXgPxIndLxXd049zaWOTDIxUyY2E876nSuiga55eD+j4JgaDnnj23gy/5VEAodYEwu7L2opNnO5UPLIXVpp6fhBF+1uRekMyEbjVQNfGuy89EAloWZK5tLdzaJdyJxBwMvAV8jCN3GIM=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772C306A562CEA2A65C02FCBC880@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:LaRXbKTIlT/PFXTlspAm6EwZSxzP83deDul45FpE9/z4vFKd/8nxuMMKvRV0pGnY0Lan/XwAel9Ylh1aN+XF60IB2caQbNbe6VD0nR/kQ0n6Zar61RG3INnUehKjBSLlP7YG1782+cWrm28SXsaIIDtFrnm6bxrCgU+fO4BCGjVks/XVJVUyMdMtRg7zxAP93EIk3CG/nBR7WxByZ836MgIzuoHWdrsFJh24kT2XQseT5oPyhsGZw37wqMZVs3SseummBc55Ec/Hu8x8wapO+Q==
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(366004)(39840400004)(376002)(39380400002)(346002)(377424004)(199004)(189003)(186003)(6246003)(31686004)(31696002)(76176011)(64126003)(53546011)(77096007)(16526019)(53936002)(68736007)(478600001)(3260700006)(59450400001)(7416002)(65826007)(16576012)(8676002)(8936002)(26005)(117156002)(5890100001)(86362001)(316002)(4326008)(106356001)(386003)(25786009)(5660300001)(81156014)(81166006)(36756003)(66066001)(58126008)(476003)(6116002)(65806001)(65956001)(47776003)(54906003)(305945005)(2906002)(7736002)(3846002)(230700001)(50466002)(6916009)(956004)(2616005)(6666003)(11346002)(446003)(229853002)(6486002)(74482002)(52116002)(52146003)(2486003)(36916002)(23676004)(486006)(97736004)(93886005)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzI7MjM6SWVXZ3h3aE9xVkc2eDJRYjJoTWQxb0Rr?=
 =?utf-8?B?Vk9aWlNZYTVVTUtYL3U3elJqYnBkbWtySW1wRENGdVo5QVBKY2M2RG5Jcksz?=
 =?utf-8?B?dWgzSWg2RHVCWW5GY0JOTVdCZXArOVZKUE1GL25DV2lZVWl0L0phUHRnS0s3?=
 =?utf-8?B?S1p0cCt4ZFZXaU1VNXVjY3NUQ0Nqdy9RU2dMcEVSQjJEajlZeENOSmJXQ2Zs?=
 =?utf-8?B?Sm10NkZuUUxPNkVKdGhLNzBYR0prMU9xcExFWnhjZHJsRlRIdUhUcDN3Sm9x?=
 =?utf-8?B?KzFZWnpPOGZOUmRpNFVFYUNRRlY5bU9CWWJWU0dkb1FoWk9vanNqdEZ5ZWg0?=
 =?utf-8?B?SlNqTWJRemJNL09YZVF0Wi85OWdHTnJzc241T2VOcnI2K1VhdGZBNFpuNSto?=
 =?utf-8?B?WE9jM3RDRW92MkF1d1VVaEFnVEhLbHdQLzBBOCtLZ2FwNjJuck5KWWJGRTJp?=
 =?utf-8?B?bjFMaitWYWJZcmpnYlZKcHpkbUZ3SzVpemJRN2hUR1lrM0l2NHBWMkFCRFFt?=
 =?utf-8?B?K2F3OWZEVmVGT2s1ajhxbEt6L01XNmhqQThmbUpCd0tXMXkzYkVDdE15RmJZ?=
 =?utf-8?B?ZkRBeHpYRTFSaHI4dVR5Zi9zV0RJWi94Q2FsaGJyWVNuczVtZ2J4UnZ4eVJT?=
 =?utf-8?B?MXlpWHh4WXo3dkd1NFlzV050MFM3dENVVWxhdEJQelVQSUNkVFlMVEhqMDBy?=
 =?utf-8?B?VEVCZ1lSZnJORlVxQlZCeGl1dXpacGRXeXZndXg3QzRrMGp6NEkxT2JFeWpK?=
 =?utf-8?B?VkY1TTdLb1JrSnlTVEErbDhNU3ExbUgyMzJCWFBEK3cybzVoTGpzZXBBQm5Y?=
 =?utf-8?B?b0NndVN1dE9wU0o1UWUwdWQ5bFhtQnNzQUVyZFR4YXlxVkNOUHNxNTQ1TG9W?=
 =?utf-8?B?elFIQWJ1SGExdXR3VW15WXovQ2FCeUdWSmIxOCtyS21LTzJwelZob2FHVGZR?=
 =?utf-8?B?TDhvNjRWTXZqeUpQUlhmc1F5K2FTQ1U4SDl2SnhRT1JhNCtySUNsS3gxbTh4?=
 =?utf-8?B?VzUrdnhhTEdFeU11d2pGcTdpQXp1ZFhFOWcwWUtzTGQveGg3blEzTGNQQ216?=
 =?utf-8?B?SHZVNTc4TE5vWEJsOE05cDROZmI0ZENhUi9IN3dXYVhVZEh5bHFsNkNPVEZ6?=
 =?utf-8?B?d1psZHJYQ0lHY1NEQlFtQ0pVRnZYdHI2YkQ4cHkzNXNMK1RHY2oxRzgydHhZ?=
 =?utf-8?B?YUk2dlczRC9CWXRjay9EVi81MDFsMmlJZW5VTmJKclNYUnV4bkZFSDBPRk9U?=
 =?utf-8?B?cjl2aDFhUWFaajd4OUJyUGNic1A5V2Q5eCtmSlRoVnM0OGoyd3RvaW9oRXR0?=
 =?utf-8?B?MWJSZ0VrbmxhTXMrT0UzTmhUaFlrRkx1TTdQQjJsWHJ2RWlZbU4yRzFCOHc5?=
 =?utf-8?B?MzBaNC94c1A5ZW5pNlF4SzhtV1A5YitYYmtwR09vNlE0NmY4T1FIcHNSalI3?=
 =?utf-8?B?bjVqNXdBdVdkMzh4V1FnRHVNT0RvUk9jVktPeGNvQll1UWNLY3c2NFU0U0RO?=
 =?utf-8?B?U2dBUjA1dXFBampOenlZSFA1RGNMZytZaHZpTC9hdnEzYk9yMHFMcUFhdEs3?=
 =?utf-8?B?UEJSajAvTHhNbjRpYUYzWHViR2h2QzZQelEydFZPdmNYa2l0bTNJMXVQNGtr?=
 =?utf-8?B?RUxoM3BRVE5NOFZpZ0Y4VHEyRnk4dm9iSFVBZ0dXRC9kVnRoR1JVaWxNQTRo?=
 =?utf-8?B?QXQ3b21oOVRWbnpweE5JTkdseXNVVWg5TDM3Z3lkaUxnMGtlY0hlRXhUOEx3?=
 =?utf-8?B?cEx1Vi96WStvaUZZSEVMS0ltbFB4Z2kwU0lEM2pFSVhRWThGWjhOcVRqNWNv?=
 =?utf-8?B?anJRZWh2WVA1eitON2lwMkkydGZLMlZJMmJXalZEc0taNGZSSTNuZHJva1ZD?=
 =?utf-8?B?Q1BTeUZyUi9jNHY2WHhpVnc2Z3BuNmh4M3ppMGxwVjMzWG9YeERqWHBKcE15?=
 =?utf-8?B?eFh4OHpGMHRrNkMxamVuMURzbFZYQzRoRXphT0M3TGQwSnNjVnhRdmxmSVlC?=
 =?utf-8?B?Y2U1TWQ4WWRrRGhCWHJaWmJPTFVyeHRyd0g1Rmllc0VRWU05QjloaTFmTVlI?=
 =?utf-8?B?ckJkYzc2SjQ1a0dnR3NNV01vWVNoNGZ3cERmRUxjMkJMRjhjMXlHc2RGc3A4?=
 =?utf-8?B?MDNDMzZ1ekNyck1VdVh5RHpsL3RBTkJZTSs2YkZzb1VVVXBNRmRCUTI5TDFr?=
 =?utf-8?B?L3Q2b0t1UUdlYm9VZVIvd1RubTdTWVlibm1HUldWa0xxTVc3d3RvMndwYkZG?=
 =?utf-8?Q?BxZL9KhvrrSgOWjiG5vA?=
X-Microsoft-Antispam-Message-Info: ty+ninHn4z1IcVFDeIFEaGaIMHj40XLkRpWObQgnol2V177V4bcijDXlunrg3fCY2uypNeCyQirnibY1aJHYzsgB/3g/KIAgHki0/PQSmoXWZ3bD9VHnyH5P9vqbn1lKEJkdbFbQKDZPoIg5M6wW0m1ohc6QwIXWLFh/EV5/qIqSMr9bxdQNCTuV9oYqez4v
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:l+0hoQnGCLglxyxDYrCXcAExAShg69U05WxBzLdVR224ZWm/er/qX6vPMKWb03VCOZo0g8Pxkhq5XVvHgDeGIniM/rvhX7AklNph16mmlMvZHtdcKlKMJa4Ap6mIUugzRrE70XsQAQr27Fe3fW++hsLmikZiNUjMI7wrNvle5sEGXo8Gqcdt2xWbH5ySZM8vK7CUUrMfVldPuD7K80DgXa7YKHeznjO9AIctQkmuNALlP1OEIuwIhuE4qx//mEo6CLrt3zWbfnlVDPNZY/lvmWmVfOD15Dwz7lr+qgTzcPo4n5Qdp7x4IhEslE4l4SO3lzDfXtJnYifEnJfCpTDPpzH76mb4WgkrD5V5L+2bPayVbwEH68dDj0k4o2kZl4rY4weJoiwTGc0+RbQCXETvIYgnZFTbphGF+3Z4IRSiRzkah/j1kpZyhjd/nFSMVcs9Wu+4bGg8O9rPLO52rqxKCw==;5:EWJDTkn52vz8bdu+PG34DBjbQXqFwvg2f6T6GkgTTHRQLLl0pfbMmACX8attRwsNRt42ClVWhJtMsXiEUVF4r+FxoEcouOMsP5d/3UShjnTLPC5S0sJ3PAursUdBb2r+svvjTXf986oFLx/CjiwQ2ihWtY26euH4DJkE1rtnAKc=;24:bhPQSUlfctnEfv49sCB9CpTJZXlvm/Iswx00UhvuR6PcdTh6Us1sVV0xJ7Aq9St/wEqZa4FuCklt0rIqECs30uo1+zMn1xh7HUZS33oDyLk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:30CSDNCR9RS4fHnmUsZ3uuXUprbXBebdsU+z1jWZB7pwNgfP9lJbnX4OZJTeWSrYCc+yBffylsnGTUiTLYV3jbNV7TGOqK5E9qnOlWjY/jxXfyc+YPr1aXAwoMkqGxbXKkX2EK+SdUCurxnUTWhVXNoVl72dWmV8pTqJ948IaXVbrF8B6vhCY5RDSRIlKze5Is9qLxBHJrkiq7Iv+WS3CRBZz2lYfSg/r1uil5tXxxQmPqbzQTyoqc5O5Q+rb3bj
X-MS-Office365-Filtering-Correlation-Id: c80eb96f-71f6-4710-2675-08d5a9cc3764
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 10:14:49.9676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80eb96f-71f6-4710-2675-08d5a9cc3764
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-24 10:08, Russell King - ARM Linux wrote:
> On Tue, Apr 24, 2018 at 08:58:42AM +0200, Peter Rosin wrote:
>> On 2018-04-23 18:08, Russell King - ARM Linux wrote:
>>> On Mon, Apr 23, 2018 at 09:23:00AM +0200, Peter Rosin wrote:
>>>>  static int tda998x_remove(struct i2c_client *client)
>>>>  {
>>>> -	component_del(&client->dev, &tda998x_ops);
>>>> +	struct device *dev = &client->dev;
>>>> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
>>>> +
>>>> +	drm_bridge_remove(&bridge->bridge);
>>>> +	component_del(dev, &tda998x_ops);
>>>> +
>>>
>>> I'd like to ask a rather fundamental question about DRM bridge support,
>>> because I suspect that there's a major fsckup here.
>>>
>>> The above is the function that deals with the TDA998x device being
>>> unbound from the driver.  With the component API, this results in the
>>> DRM device correctly being torn down, because one of the hardware
>>> devices has gone.
>>>
>>> With DRM bridge, the bridge is merely removed from the list of
>>> bridges:
>>>
>>> void drm_bridge_remove(struct drm_bridge *bridge)
>>> {
>>>         mutex_lock(&bridge_lock);
>>>         list_del_init(&bridge->list);
>>>         mutex_unlock(&bridge_lock);
>>> }
>>> EXPORT_SYMBOL(drm_bridge_remove);
>>>
>>> and the memory backing the "struct tda998x_bridge" (which contains
>>> the struct drm_bridge) will be freed by the devm subsystem.
>>>
>>> However, there is no notification into the rest of the DRM subsystem
>>> that the device has gone away.  Worse, the memory that is still in
>>> use by DRM has now been freed, so further use of the DRM device
>>> results in a use-after-free bug.
>>>
>>> This is really not good, and to me looks like a fundamental problem
>>> with the DRM bridge code.  I see nothing in the DRM bridge code that
>>> deals with the lifetime of a "DRM bridge" or indeed the lifetime of
>>> the actual device itself.
>>>
>>> So, from what I can see, there seems to be a fundamental lifetime
>>> issue with the design of the DRM bridge code.  This needs to be
>>> fixed.
>>
>> Oh crap. A gigantic can of worms...
> 
> Yes, it's especially annoying for me, having put the effort in to
> the component helper to cover all these cases.
> 
>> Would a patch (completely untested btw) along this line of thinking make
>> any difference whatsoever?
> 
> It looks interesting - from what I can see of the device links code,
> it would have the effect of unbinding the DRM device just before
> TDA998x is unbound, so that's an improvement.
> 
> However, from what I can see, the link vanishes at that point (as
> DL_FLAG_AUTOREMOVE is set), and re-binding the TDA998x device results
> in nothing further happening - the link will be recreated, but there
> appears to be nothing that triggers the "consumer" to rebind at that
> point.  Maybe I've missed something?

Right, auto-remove is a no-go. So, improving on the previous...

(I think drm_panel might suffer from this issue too?)

Cheers,
Peter

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1638bfe9627c..b1365cfee445 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -121,12 +121,17 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (bridge->dev)
 		return -EBUSY;
 
+	bridge->link = device_link_add(encoder->dev->dev, bridge->owner, 0);
+	if (!bridge->link)
+		return -EINVAL;
+
 	bridge->dev = encoder->dev;
 	bridge->encoder = encoder;
 
 	if (bridge->funcs->attach) {
 		ret = bridge->funcs->attach(bridge);
 		if (ret < 0) {
+			device_link_del(bridge->link);
 			bridge->dev = NULL;
 			bridge->encoder = NULL;
 			return ret;
@@ -153,6 +158,8 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 
+	device_link_del(bridge->link);
+
 	bridge->dev = NULL;
 }
 
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index b8cb6237a38b..29eba4e9a39d 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1857,6 +1857,7 @@ tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	bridge->dev = dev;
 	dev_set_drvdata(dev, bridge);
 
+	bridge->bridge.owner = dev;
 	bridge->bridge.funcs = &tda998x_bridge_funcs;
 #ifdef CONFIG_OF
 	bridge->bridge.of_node = dev->of_node;
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 682d01ba920c..b8f33aba3216 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -224,6 +224,8 @@ struct drm_bridge_funcs {
 
 /**
  * struct drm_bridge - central DRM bridge control structure
+ * @owner: device that owns the bridge
+ * @link: drm consumer <-> bridge supplier
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
  * @next: the next bridge in the encoder chain
@@ -233,6 +235,8 @@ struct drm_bridge_funcs {
  * @driver_private: pointer to the bridge driver's internal context
  */
 struct drm_bridge {
+	struct device *owner;
+	struct device_link *link;
 	struct drm_device *dev;
 	struct drm_encoder *encoder;
 	struct drm_bridge *next;
