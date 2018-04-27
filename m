Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbeD0KLA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:11:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49412 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932686AbeD0KK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:10:58 -0400
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH 06/17] drm: rcar-du: Allow DU groups to work with hardware
 indexing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
 <20180426165346.494-7-kieran.bingham+renesas@ideasonboard.com>
 <10312647.9oa0HbEkDa@avalon>
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham+renesas@ideasonboard.com;
 prefer-encrypt=mutual; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <b1eb3242-930b-396c-7969-00f6b45ffb5f@ideasonboard.com>
Date: Fri, 27 Apr 2018 11:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <10312647.9oa0HbEkDa@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 26/04/18 21:36, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Thursday, 26 April 2018 19:53:35 EEST Kieran Bingham wrote:
>> The group objects assume linear indexing, and more so always assume that
>> channel 0 of any active group is used.
>>
>> Now that the CRTC objects support non-linear indexing, adapt the groups
>> to remove assumptions that channel 0 is utilised in each group by using
>> the channel mask provided in the device structures.
>>
>> Finally ensure that the RGB routing is determined from the index of the
>> CRTC object (which represents the hardware DU channel index).
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> ---
>>  drivers/gpu/drm/rcar-du/rcar_du_group.c | 14 +++++++++-----
>>  drivers/gpu/drm/rcar-du/rcar_du_group.h |  2 ++
>>  drivers/gpu/drm/rcar-du/rcar_du_kms.c   |  5 ++++-
>>  3 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c
>> b/drivers/gpu/drm/rcar-du/rcar_du_group.c index eead202c95c7..c52091fe02ba
>> 100644
>> --- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
>> @@ -46,9 +46,12 @@ void rcar_du_group_write(struct rcar_du_group *rgrp, u32
>> reg, u32 data)
>>
>>  static void rcar_du_group_setup_pins(struct rcar_du_group *rgrp)
>>  {
>> -	u32 defr6 = DEFR6_CODE | DEFR6_ODPM02_DISP;
>> +	u32 defr6 = DEFR6_CODE;
>>
>> -	if (rgrp->num_crtcs > 1)
>> +	if (rgrp->channel_mask & BIT(0))
>> +		defr6 |= DEFR6_ODPM02_DISP;
>> +
>> +	if (rgrp->channel_mask & BIT(1))
>>  		defr6 |= DEFR6_ODPM12_DISP;
> 
> So much cleaner with the channels mask, I like this.

:-D

> 
>>  	rcar_du_group_write(rgrp, DEFR6, defr6);
>> @@ -80,10 +83,11 @@ static void rcar_du_group_setup_defr8(struct
>> rcar_du_group *rgrp) * On Gen3 VSPD routing can't be configured, but DPAD
>> routing
>>  		 * needs to be set despite having a single option available.
>>  		 */
>> -		u32 crtc = ffs(possible_crtcs) - 1;
>> +		unsigned int rgb_crtc = ffs(possible_crtcs) - 1;
>> +		struct rcar_du_crtc *crtc = &rcdu->crtcs[rgb_crtc];
>>
>> -		if (crtc / 2 == rgrp->index)
>> -			defr8 |= DEFR8_DRGBS_DU(crtc);
>> +		if (crtc->index / 2 == rgrp->index)
>> +			defr8 |= DEFR8_DRGBS_DU(crtc->index);
>>  	}
>>
>>  	rcar_du_group_write(rgrp, DEFR8, defr8);
>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h
>> b/drivers/gpu/drm/rcar-du/rcar_du_group.h index 5e3adc6b31b5..d29a68e006a7
>> 100644
>> --- a/drivers/gpu/drm/rcar-du/rcar_du_group.h
>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_group.h
>> @@ -25,6 +25,7 @@ struct rcar_du_device;
>>   * @dev: the DU device
>>   * @mmio_offset: registers offset in the device memory map
>>   * @index: group index
>> + * @channel_mask: bitmask of populated DU channels in this group
>>   * @num_crtcs: number of CRTCs in this group (1 or 2)
>>   * @use_count: number of users of the group (rcar_du_group_(get|put))
>>   * @used_crtcs: number of CRTCs currently in use
>> @@ -39,6 +40,7 @@ struct rcar_du_group {
>>  	unsigned int mmio_offset;
>>  	unsigned int index;
>>
>> +	unsigned int channel_mask;
> 
> Depending on how you like my suggestion in patch 05/17, this might be better 
> called channels_mask.

Done.

> 
>>  	unsigned int num_crtcs;
>>  	unsigned int use_count;
>>  	unsigned int used_crtcs;
>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
>> b/drivers/gpu/drm/rcar-du/rcar_du_kms.c index 19a445fbc879..45fb554fd3c7
>> 100644
>> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
>> @@ -597,7 +597,10 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
>>  		rgrp->dev = rcdu;
>>  		rgrp->mmio_offset = mmio_offsets[i];
>>  		rgrp->index = i;
>> -		rgrp->num_crtcs = min(rcdu->num_crtcs - 2 * i, 2U);
>> +		/* Extract the channel mask for this group only */
> 
> s/only/only./
> 
>> +		rgrp->channel_mask = (rcdu->info->channel_mask >> (2 * i))
>> +				   & GENMASK(1, 0);
>> +		rgrp->num_crtcs = hweight8(rgrp->channel_mask);
> 
> You could optimize this by computing it as
> 
> 	rgrp->num_crtcs = (rgrp->channel_mask >> 1)
> 			| (rgrp->channel_mask & 1);
> 
> as you know that only two bits at most can be set. Up to you.

Hrm... that looks like a neat trick - but I might leave this as hweight if you
don't object.
We're not on a hot-path here, and hweight is purposefully designed to count
bits, and thus self documenting ... whereas bit-magic is ... magic :D

 (Don't get me wrong though I am a fan of magic :D, and I love good bit-tricks)

> 
>>  		/*
>>  		 * If we have more than one CRTCs in this group pre-associate
> 
> With those small issues fixed,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>


Thanks, collected.

Kieran
