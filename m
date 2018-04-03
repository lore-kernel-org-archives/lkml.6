Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754794AbeDCJlN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:41:13 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:18160
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752486AbeDCJlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:41:11 -0400
X-IronPort-AV: E=Sophos;i="5.48,400,1517871600";
   d="scan'208";a="260683288"
Date: Tue, 3 Apr 2018 11:41:05 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Jani Nikula <jani.nikula@linux.intel.com>
cc: Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: fix spelling mistake: "Usupported" ->
 "Unsupported"
In-Reply-To: <87tvssaawl.fsf@intel.com>
Message-ID: <alpine.DEB.2.20.1804031139110.3630@hadrien>
References: <20180330160047.7368-1-colin.king@canonical.com> <87tvssaawl.fsf@intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Apr 2018, Jani Nikula wrote:

> On Fri, 30 Mar 2018, Colin King <colin.king@canonical.com> wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Trivial fix to spelling mistake in DRM_ERROR error message text
>
> Thanks for the patch.
>
> Please do consider limiting the distribution in the future,
> though. There's no need to include lkml or even dri-devel for trivial
> patches like this.

It's complex to have to remember the preferences for every subsystem.
Preferences should be expressed in the MAINTAINERS file in some way.
Also, since no one reads lkml, does it hurt to have even trivial patches?

julia

>
> Thanks,
> Jani.
>
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index e42a28e3adc5..1df1c91b6ae5 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -1521,7 +1521,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
> >  		break;
> >  #endif
> >  	default:
> > -		DRM_ERROR("Usupported ASIC type: 0x%X\n", adev->asic_type);
> > +		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
> >  		goto fail;
> >  	}
> >
> > @@ -1715,7 +1715,7 @@ static int dm_early_init(void *handle)
> >  		break;
> >  #endif
> >  	default:
> > -		DRM_ERROR("Usupported ASIC type: 0x%X\n", adev->asic_type);
> > +		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
> >  		return -EINVAL;
> >  	}
>
> --
> Jani Nikula, Intel Open Source Technology Center
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
