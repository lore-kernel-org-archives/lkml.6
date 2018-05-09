Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965888AbeEITtJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:49:09 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45554 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965567AbeEITtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:49:07 -0400
X-Google-Smtp-Source: AB8JxZr9wt/toxuYs5COrbn0n679GyHeBgyIHKSBsfdQEYknj8H3648wB6MT0fgAfR72Y5G5G7O6hrkHpLfkj+hlBpI=
MIME-Version: 1.0
In-Reply-To: <20180428222155.20242-1-colin.king@canonical.com>
References: <20180428222155.20242-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 May 2018 15:49:05 -0400
Message-ID: <CADnq5_MUEPZpZswjr+0B8M5NSfWJdqCAgKZ1qgrT2aD98FPsCA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix spelling mistake: "contruct" -> "construct"
To: Colin King <colin.king@canonical.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Rex Zhu <Rex.Zhu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 6:21 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in PP_ASSERT_WITH_CODE message text
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index 26fbeafc3c96..726994cf03ea 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -1229,7 +1229,7 @@ static int smu7_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
>
>                 tmp_result = smu7_construct_voltage_tables(hwmgr);
>                 PP_ASSERT_WITH_CODE((0 == tmp_result),
> -                               "Failed to contruct voltage tables!",
> +                               "Failed to construct voltage tables!",
>                                 result = tmp_result);
>         }
>         smum_initialize_mc_reg_table(hwmgr);
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index 7cbb56ba6fab..ced1c2aab7a9 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -2829,7 +2829,7 @@ static int vega10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
>
>         tmp_result = vega10_construct_voltage_tables(hwmgr);
>         PP_ASSERT_WITH_CODE(!tmp_result,
> -                       "Failed to contruct voltage tables!",
> +                       "Failed to construct voltage tables!",
>                         result = tmp_result);
>
>         tmp_result = vega10_init_smc_table(hwmgr);
> --
> 2.17.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
