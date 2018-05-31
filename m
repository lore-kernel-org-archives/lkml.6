Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeEaJgw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:36:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:25949 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754092AbeEaJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:36:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="233222040"
Subject: Re: [PATCH v2 1/2] drm/blend: Add per-plane pixel blend mode property
To: Lowry Li <lowry.li@arm.com>, liviu.dudau@arm.com
Cc: gustavo@padovan.org, daniel.vetter@intel.com,
        jani.nikula@linux.intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, nd@arm.com
References: <1527679434-13228-1-git-send-email-lowry.li@arm.com>
 <1527679434-13228-2-git-send-email-lowry.li@arm.com>
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <b249fdf2-1a72-5d0c-6fea-a92370cae9a5@linux.intel.com>
Date: Thu, 31 May 2018 11:36:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527679434-13228-2-git-send-email-lowry.li@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Op 30-05-18 om 13:23 schreef Lowry Li:
> Pixel blend modes represent the alpha blending equation
> selection, describing how the pixels from the current
> plane are composited with the background.
>
> Add a pixel_blend_mode to drm_plane_state and a
> blend_mode_property to drm_plane, and related support
> functions.
>
> Defines three blend modes in drm_blend.h.
>
> Signed-off-by: Lowry Li <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/drm_atomic.c        |   4 ++
>  drivers/gpu/drm/drm_atomic_helper.c |   1 +
>  drivers/gpu/drm/drm_blend.c         | 110 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_blend.h             |   6 ++
>  include/drm/drm_plane.h             |   6 ++
>  5 files changed, 127 insertions(+)
Can you rebase this on top of a kernel with alpha property support? Getting some nasty conflicts otherwise..

~Maarten
