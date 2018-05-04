Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeEDLzG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:55:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45559 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeEDLzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:55:04 -0400
X-Google-Smtp-Source: AB8JxZorTpP1kxEom1CFweDMH5QGyeuttRFdpXKz7aILZrwsmcx2CDDMU+uxBKnQHFqFgb7lWC0obQ==
Subject: Re: [PATCH v1 1/3] drm/tegra: dc: Enable plane scaling filters
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180504000844.18661-1-digetx@gmail.com>
 <20180504000844.18661-2-digetx@gmail.com> <20180504111004.GP13459@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <85841227-e008-b129-f1e0-689837877e61@gmail.com>
Date: Fri, 4 May 2018 14:55:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504111004.GP13459@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.2018 14:10, Thierry Reding wrote:
> On Fri, May 04, 2018 at 03:08:42AM +0300, Dmitry Osipenko wrote:
>> Currently resized plane produces a "pixelated" image which doesn't look
>> nice, especially in a case of a video overlay. Enable scaling filters that
>> significantly improve image quality of a scaled overlay.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/tegra/dc.c | 51 ++++++++++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/tegra/dc.h |  7 ++++++
>>  2 files changed, 58 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
>> index 9f83a65b5ea9..2e81142281c3 100644
>> --- a/drivers/gpu/drm/tegra/dc.c
>> +++ b/drivers/gpu/drm/tegra/dc.c
>> @@ -361,6 +361,47 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
>>  	if (window->bottom_up)
>>  		value |= V_DIRECTION;
>>  
>> +	if (!(dc->soc->has_win_a_without_filter && plane->index == 0) &&
>> +	    !(window->src.w == window->dst.w)) {
> 
> I don't know about you, but I get dizzy trying to parse the above. How
> about we move this into helpers:

+1

> 	static bool tegra_plane_has_horizontal_filter(struct tegra_plane *plane)
> 	{
> 		struct tegra_dc *dc = plane->dc;
> 
> 		/* this function should never be called on inactive planes */
> 		if (WARN_ON(!dc))
> 			return false;
> 
> 		if (plane->index == 0 && dc->soc->has_win_a_without_filter)
> 			return false;
> 
> 		return true;
> 	}
> 
> Then the above becomes:
> 
> 	bool scale_x = window->dst.w != window->src.w;
> 
> 	if (scale_x && tegra_plane_has_horizontal_filter(plane)) {
> 
>> +		/*
>> +		 * Enable horizontal 6-tap filter and set filtering
>> +		 * coefficients to the default values defined in TRM.
>> +		 */
>> +		tegra_plane_writel(plane, 0x00008000, DC_WIN_H_FILTER_P(0));
>> +		tegra_plane_writel(plane, 0x3e087ce1, DC_WIN_H_FILTER_P(1));
>> +		tegra_plane_writel(plane, 0x3b117ac1, DC_WIN_H_FILTER_P(2));
>> +		tegra_plane_writel(plane, 0x591b73aa, DC_WIN_H_FILTER_P(3));
>> +		tegra_plane_writel(plane, 0x57256d9a, DC_WIN_H_FILTER_P(4));
>> +		tegra_plane_writel(plane, 0x552f668b, DC_WIN_H_FILTER_P(5));
>> +		tegra_plane_writel(plane, 0x73385e8b, DC_WIN_H_FILTER_P(6));
>> +		tegra_plane_writel(plane, 0x72435583, DC_WIN_H_FILTER_P(7));
>> +		tegra_plane_writel(plane, 0x714c4c8b, DC_WIN_H_FILTER_P(8));
>> +		tegra_plane_writel(plane, 0x70554393, DC_WIN_H_FILTER_P(9));
>> +		tegra_plane_writel(plane, 0x715e389b, DC_WIN_H_FILTER_P(10));
>> +		tegra_plane_writel(plane, 0x71662faa, DC_WIN_H_FILTER_P(11));
>> +		tegra_plane_writel(plane, 0x536d25ba, DC_WIN_H_FILTER_P(12));
>> +		tegra_plane_writel(plane, 0x55731bca, DC_WIN_H_FILTER_P(13));
>> +		tegra_plane_writel(plane, 0x387a11d9, DC_WIN_H_FILTER_P(14));
>> +		tegra_plane_writel(plane, 0x3c7c08f1, DC_WIN_H_FILTER_P(15));
>> +
>> +		value |= H_FILTER;
>> +	}
>> +
>> +	if (!(dc->soc->has_win_a_without_filter && plane->index == 0) &&
>> +	    !(dc->soc->has_win_c_without_vert_filter && plane->index == 2) &&
>> +	    !(window->src.h == window->dst.h)) {
> 
> 	static bool tegra_plane_has_vertical_filter(struct tegra_plane *plane)
> 	{
> 		struct tegra_dc *dc = plane->dc;
> 
> 		/* this function should never be called on inactive planes */
> 		if (WARN_ON(!dc))
> 			return false;
> 
> 		if (plane->index == 0 && dc->soc->has_win_a_without_filter)
> 			return false;
> 
> 		if (plane->index == 2 && dc->soc->has_win_c_without_vert_filter)
> 			return false;
> 
> 		return true;
> 	}
> 
> And the above becomes:
> 
> 	bool scale_y = window->dst.h != window->src.h;
> 
> 	if (scale_y && tegra_plane_has_vertical_filter(plane)) {

I'll adjust this patch, thanks.

Maybe it also worth to factor filtering out into a custom DRM property? For
example in a case of libvdpau-tegra we perform the exact same filtering on
blitting YUV to RGB surface (shown as overlay) by GR2D for displaying video
players interface on top of video, this results in a double filtering that has
no visual effect and probably wastes memory bandwidth a tad.

Though I'm not very keen anymore on trying to add custom plane properties after
being previously NAK'ed. We can wrap filtering into a property later if will be
desired, should be good to just have it enabled by default for now.
