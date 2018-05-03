Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeECOcn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:32:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42589 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeECOcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:32:42 -0400
X-Google-Smtp-Source: AB8JxZpKbvlhaZRNcPPR08vyhDJe6iY8dzOLThnCrx67lXAv9Mpx8cFBepJ0ZcMenEh/ECb2jMfTeQ==
Date: Thu, 3 May 2018 15:32:38 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] backlight: remove obsolete comment for ->state
Message-ID: <20180503143238.lfxacqos7t6xuays@holly.lan>
References: <20180503141517.28207-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503141517.28207-1-daniel.vetter@ffwll.ch>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 04:15:17PM +0200, Daniel Vetter wrote:
> Jani spotted this when reviewing my earlier patch to remove the driver
> internal usage of this field in
> 
> commit 3cf91adaa594e8933af1727942ac560e5c7bc70e
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Wed Apr 25 19:42:52 2018 +0200
> 
>     backlight: Nuke BL_CORE_DRIVER1
> 
> Cc: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  include/linux/backlight.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 7fbf0539e14a..0b5897446dca 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -79,7 +79,6 @@ struct backlight_properties {
>  	/* Backlight type */
>  	enum backlight_type type;
>  	/* Flags used to signal drivers of state changes */
> -	/* Upper 4 bits are reserved for driver internal use */
>  	unsigned int state;
>  
>  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
> -- 
> 2.17.0
> 
