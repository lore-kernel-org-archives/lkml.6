Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEBLKM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:10:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36817 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeEBLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:10:06 -0400
X-Google-Smtp-Source: AB8JxZpP3+XddyAF79G8xlbG7URBwzhOvVnihF4vgBhnVKVjaNe+e+hOACnR8Whqwhji9yjLfGrxIQ==
Date: Wed, 2 May 2018 13:10:02 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Colin King <colin.king@canonical.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: drm: sti: fix spelling mistake: "initialze" ->
 "initialize"
Message-ID: <20180502111002.GB12521@phenom.ffwll.local>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180502101048.8442-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502101048.8442-1-colin.king@canonical.com>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 11:10:48AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in DRM_ERROR error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to drm-misc-next, thanks.
-Daniel

> ---
>  drivers/gpu/drm/sti/sti_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crtc.c
> index 21e50d7b1f86..5824e6aca8f4 100644
> --- a/drivers/gpu/drm/sti/sti_crtc.c
> +++ b/drivers/gpu/drm/sti/sti_crtc.c
> @@ -357,7 +357,7 @@ int sti_crtc_init(struct drm_device *drm_dev, struct sti_mixer *mixer,
>  	res = drm_crtc_init_with_planes(drm_dev, crtc, primary, cursor,
>  					&sti_crtc_funcs, NULL);
>  	if (res) {
> -		DRM_ERROR("Can't initialze CRTC\n");
> +		DRM_ERROR("Can't initialize CRTC\n");
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.17.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
