Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeBHQ1k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:27:40 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:37147 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHQ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:27:39 -0500
X-Google-Smtp-Source: AH8x225viAHPbeqKTGR+ssjBOKGxuAobMYrzegaZGMH1r2Ueu4BG7810MtW4TKAUUK9rPhjCzmtQpAG+yVexgT5Qc90=
MIME-Version: 1.0
In-Reply-To: <20180208094601.26215-1-kai.heng.feng@canonical.com>
References: <20180208094601.26215-1-kai.heng.feng@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Feb 2018 11:27:37 -0500
Message-ID: <CADnq5_NG3zpRXk-s3jdUWif01rzwrV92eFEx=J_NqnEHraxY_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add new device to use atpx quirk
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 4:46 AM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> The affected system (0x0813) is pretty similar to another one (0x0812),
> it also needs to use ATPX power control.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index e2c3c5ec42d1..c53095b3b0fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -568,6 +568,7 @@ static const struct amdgpu_px_quirk amdgpu_px_quirk_list[] = {
>         /* HG _PR3 doesn't seem to work on this A+A weston board */
>         { 0x1002, 0x6900, 0x1002, 0x0124, AMDGPU_PX_QUIRK_FORCE_ATPX },
>         { 0x1002, 0x6900, 0x1028, 0x0812, AMDGPU_PX_QUIRK_FORCE_ATPX },
> +       { 0x1002, 0x6900, 0x1028, 0x0813, AMDGPU_PX_QUIRK_FORCE_ATPX },
>         { 0, 0, 0, 0, 0 },
>  };
>
> --
> 2.15.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
