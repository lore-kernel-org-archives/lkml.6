Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeEPJnn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:43:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33040 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeEPJnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:43:42 -0400
X-Google-Smtp-Source: AB8JxZqaNN01hdfbgJwiXKY2kCzsXeN+z6kpct+gWrHeaozSuWGveuvvjwlJoPLVRkyr7k42HeO9tw==
Date: Wed, 16 May 2018 11:43:38 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: checkpatch strict minor updates
Message-ID: <20180516094338.GE3438@phenom.ffwll.local>
Mail-Followup-To: Philippe Cornu <philippe.cornu@st.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180515203736.9224-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515203736.9224-1-philippe.cornu@st.com>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 10:37:36PM +0200, Philippe Cornu wrote:
> Minor fixes detected with "scripts/checkpatch.pl --strict"
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
> Detected when merging "drm: clarify adjusted_mode documentation for bridges"

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
>  include/drm/drm_bridge.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 9917651a7fdd..70131ab57e8f 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -97,7 +97,7 @@ struct drm_bridge_funcs {
>  	/**
>  	 * @mode_fixup:
>  	 *
> -	 * This callback is used to validate and adjust a mode. The paramater
> +	 * This callback is used to validate and adjust a mode. The parameter
>  	 * mode is the display mode that should be fed to the next element in
>  	 * the display chain, either the final &drm_connector or the next
>  	 * &drm_bridge. The parameter adjusted_mode is the input mode the bridge
> @@ -301,15 +301,15 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  		      struct drm_bridge *previous);
>  
>  bool drm_bridge_mode_fixup(struct drm_bridge *bridge,
> -			const struct drm_display_mode *mode,
> -			struct drm_display_mode *adjusted_mode);
> +			   const struct drm_display_mode *mode,
> +			   struct drm_display_mode *adjusted_mode);
>  enum drm_mode_status drm_bridge_mode_valid(struct drm_bridge *bridge,
>  					   const struct drm_display_mode *mode);
>  void drm_bridge_disable(struct drm_bridge *bridge);
>  void drm_bridge_post_disable(struct drm_bridge *bridge);
>  void drm_bridge_mode_set(struct drm_bridge *bridge,
> -			struct drm_display_mode *mode,
> -			struct drm_display_mode *adjusted_mode);
> +			 struct drm_display_mode *mode,
> +			 struct drm_display_mode *adjusted_mode);
>  void drm_bridge_pre_enable(struct drm_bridge *bridge);
>  void drm_bridge_enable(struct drm_bridge *bridge);
>  
> -- 
> 2.15.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
