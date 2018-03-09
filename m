Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeCIHDM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 02:03:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:44641 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbeCIHDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 02:03:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,444,1515484800";
   d="scan'208";a="23116945"
Date: Thu, 8 Mar 2018 22:59:22 -0800
From: Manasi Navare <manasi.d.navare@intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 1/6] drm/i915: Remove unused DP_LINK_CHECK_TIMEOUT
Message-ID: <20180309065921.GA2374@intel.com>
References: <20180308232421.14049-1-lyude@redhat.com>
 <20180308232421.14049-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308232421.14049-2-lyude@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 06:24:15PM -0500, Lyude Paul wrote:
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Manasi Navare <manasi.d.navare@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>

Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>

> ---
>  drivers/gpu/drm/i915/intel_dp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
> index 9a4a51e79fa1..4dd1b2287dd6 100644
> --- a/drivers/gpu/drm/i915/intel_dp.c
> +++ b/drivers/gpu/drm/i915/intel_dp.c
> @@ -43,7 +43,6 @@
>  #include <drm/i915_drm.h>
>  #include "i915_drv.h"
>  
> -#define DP_LINK_CHECK_TIMEOUT	(10 * 1000)
>  #define DP_DPRX_ESI_LEN 14
>  
>  /* Compliance test status bits  */
> -- 
> 2.14.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
