Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757917AbeD0KOm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:14:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49444 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757645AbeD0KOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:14:39 -0400
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH 07/17] drm: rcar-du: Add R8A77965 support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
 <20180426165346.494-8-kieran.bingham+renesas@ideasonboard.com>
 <1954980.A0ABKULED7@avalon>
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham+renesas@ideasonboard.com;
 prefer-encrypt=mutual; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <cfe1b007-de3e-d8c0-90f8-4be8f36b324d@ideasonboard.com>
Date: Fri, 27 Apr 2018 11:14:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1954980.A0ABKULED7@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/18 21:43, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Thursday, 26 April 2018 19:53:36 EEST Kieran Bingham wrote:
>> The R8A77965 (M3-N) SoC provides VGA, HDMI and LVDS output.
>>
>> This platform is unusual in that the VGA is connected to DU3 leaving DU2
>> unpopulated. This is reflected by the channel_mask accordingly.
> 
> I'd write s/VGA/DPAD/g (or s/VGA/RGB/g) as the DPAD output can be used for 
> other purposes than VGA.
> 
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> ---
>>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 29 +++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index d6ebc628fc22..4d195ff8c569
>> 100644
>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> @@ -246,6 +246,34 @@ static const struct rcar_du_device_info
>> rcar_du_r8a7796_info = { .dpll_ch =  BIT(1),
>>  };
>>
>> +static const struct rcar_du_device_info rcar_du_r8a77965_info = {
>> +	.gen = 3,
>> +	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
>> +		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
>> +		  | RCAR_DU_FEATURE_VSP1_SOURCE,
>> +	.channel_mask = BIT(0) | BIT(1) | BIT(3),
> 
> Depending on what you think of my suggestions for patch 05/17, you might want 
> to reverse the bit order here.

Done.

> 
>> +	.routes = {
>> +		/*
>> +		 * R8A77965 has one RGB output, one LVDS output and one HDMI
>> +		 * output.
>> +		 */
>> +		[RCAR_DU_OUTPUT_DPAD0] = {
>> +			.possible_crtcs = BIT(2),
>> +			.port = 0,
>> +		},
>> +		[RCAR_DU_OUTPUT_HDMI0] = {
>> +			.possible_crtcs = BIT(1),
>> +			.port = 1,
>> +		},
>> +		[RCAR_DU_OUTPUT_LVDS0] = {
>> +			.possible_crtcs = BIT(0),
> 
> I wonder whether it wouldn't be easier to read if we replaced possible_crtcs 
> with possible_channels, as this structure describes the hardware and had its 
> num_crtcs field replaced with a channel_mask. This would require converting 
> the possible_channels field to a possible_crtcs field in 
> rcar_du_modeset_init(), and I think that no change would be needed in 
> rcar_du_group_setup_defr8() (but please double check). On the other hand, no 
> code would be simplified, and rcar_du_modeset_init() would gain some 
> additional complexity, so it might not be worth it.

I think we can leave this for now and consider it later if worth while.

> 
> Either way this patch looks good to me.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, collected.

--
Kieran


> 
>> +			.port = 2,
>> +		},
>> +	},
>> +	.num_lvds = 1,
>> +	.dpll_ch =  BIT(1),
>> +};
>> +
>>  static const struct rcar_du_device_info rcar_du_r8a77970_info = {
>>  	.gen = 3,
>>  	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
>> @@ -277,6 +305,7 @@ static const struct of_device_id rcar_du_of_table[] = {
>>  	{ .compatible = "renesas,du-r8a7794", .data = &rcar_du_r8a7794_info },
>>  	{ .compatible = "renesas,du-r8a7795", .data = &rcar_du_r8a7795_info },
>>  	{ .compatible = "renesas,du-r8a7796", .data = &rcar_du_r8a7796_info },
>> +	{ .compatible = "renesas,du-r8a77965", .data = &rcar_du_r8a77965_info },
>>  	{ .compatible = "renesas,du-r8a77970", .data = &rcar_du_r8a77970_info },
>>  	{ }
>>  };
> 
