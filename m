Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754784AbeDCJg2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:36:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:39701 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753131AbeDCJg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:36:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,400,1517904000";
   d="scan'208";a="43588404"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: fix spelling mistake: "Usupported" -> "Unsupported"
In-Reply-To: <20180330160047.7368-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180330160047.7368-1-colin.king@canonical.com>
Date: Tue, 03 Apr 2018 12:37:14 +0300
Message-ID: <87tvssaawl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in DRM_ERROR error message text

Thanks for the patch.

Please do consider limiting the distribution in the future,
though. There's no need to include lkml or even dri-devel for trivial
patches like this.

Thanks,
Jani.

>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e42a28e3adc5..1df1c91b6ae5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1521,7 +1521,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  		break;
>  #endif
>  	default:
> -		DRM_ERROR("Usupported ASIC type: 0x%X\n", adev->asic_type);
> +		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
>  		goto fail;
>  	}
>  
> @@ -1715,7 +1715,7 @@ static int dm_early_init(void *handle)
>  		break;
>  #endif
>  	default:
> -		DRM_ERROR("Usupported ASIC type: 0x%X\n", adev->asic_type);
> +		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
>  		return -EINVAL;
>  	}

-- 
Jani Nikula, Intel Open Source Technology Center
