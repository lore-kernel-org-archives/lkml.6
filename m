Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EDAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702D8208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeL1HRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 02:17:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:46516 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728488AbeL1HRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 02:17:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 23:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,408,1539673200"; 
   d="scan'208";a="133389244"
Received: from dlipka-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.42.217])
  by fmsmga001.fm.intel.com with ESMTP; 27 Dec 2018 23:17:39 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: Re: [PATCH] drm/intel_dsi_vbt: Remove duplicate header
In-Reply-To: <20181225133055.GA2628@hp-pavilion-15-notebook-pc-brajeswar>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181225133055.GA2628@hp-pavilion-15-notebook-pc-brajeswar>
Date:   Fri, 28 Dec 2018 09:18:07 +0200
Message-ID: <87a7kqw24w.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Dec 2018, Brajeswar Ghosh <brajeswar.linux@gmail.com> wrote:
> Remove video/mipi_display.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Pushed to drm-intel-next-queued, thanks for the patch.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/intel_dsi_vbt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_dsi_vbt.c b/drivers/gpu/drm/i915/intel_dsi_vbt.c
> index ac83d6b89ae0..40a5efa33c3d 100644
> --- a/drivers/gpu/drm/i915/intel_dsi_vbt.c
> +++ b/drivers/gpu/drm/i915/intel_dsi_vbt.c
> @@ -32,7 +32,6 @@
>  #include <linux/slab.h>
>  #include <video/mipi_display.h>
>  #include <asm/intel-mid.h>
> -#include <video/mipi_display.h>
>  #include "i915_drv.h"
>  #include "intel_drv.h"
>  #include "intel_dsi.h"

-- 
Jani Nikula, Intel Open Source Graphics Center
