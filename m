Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeDXS0f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:26:35 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:24203 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeDXS0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:26:33 -0400
Subject: Re: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
To: Russell King - ARM Linux <linux@armlinux.org.uk>
CC: Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180423072301.11962-1-peda@axentia.se>
 <20180423072301.11962-8-peda@axentia.se>
 <20180423160833.GF16141@n2100.armlinux.org.uk>
 <5d6866d0-75bc-4de8-9b87-4fee5430e9dd@axentia.se>
 <20180424080833.GJ16141@n2100.armlinux.org.uk>
 <8448e90a-4562-b564-c160-1b5c67e0f92f@axentia.se>
 <0cbee3bd-8987-5f2f-519d-f8d1b426f2a3@ti.com>
 <20180424170625.GL16141@n2100.armlinux.org.uk>
From: Jyri Sarha <jsarha@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b7a7ffb6-b282-cbc5-435e-9ca1cd405e33@ti.com>
Date: Tue, 24 Apr 2018 21:25:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424170625.GL16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/18 20:06, Russell King - ARM Linux wrote:
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
> 

Nothing but time. Embedding component helpers seamlessly into drm
framework does not sound like a couple of days job. Right now I simply
do not have time to take on a challenge like that. If someone does it I
am all for it.

However, I would not call device links substandard. They are in the
device core after all.

Best regards,
Jyri

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
