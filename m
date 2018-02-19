Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeBSRD2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:03:28 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38916 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbeBSRD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:03:27 -0500
X-Google-Smtp-Source: AH8x227Ofk2Z3GWkLBqQLVuyRxWbzyKvfAuHYpMv/hvBLDtz9hC0giURLGo5v+x6tAik30/u8VGwtsSp39/18XzurJs=
MIME-Version: 1.0
In-Reply-To: <1518619577-19771-14-git-send-email-clabbe@baylibre.com>
References: <1518619577-19771-1-git-send-email-clabbe@baylibre.com> <1518619577-19771-14-git-send-email-clabbe@baylibre.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Feb 2018 12:03:26 -0500
Message-ID: <CADnq5_NEmXg=xBff9B2zz0vCy1FXxevh-j43opLtdi7xk36MFA@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] drm/amd/powerplay: remove unused headers
To: Corentin Labbe <clabbe@baylibre.com>
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 9:46 AM, Corentin Labbe <clabbe@baylibre.com> wrote:
> All thoses headers are not used by any source files.
> Lets just remove them.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied.  Thanks!

Alex

> ---
>  .../gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h    | 412 ---------------------
>  drivers/gpu/drm/amd/powerplay/inc/pp_feature.h     |  67 ----
>  2 files changed, 479 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h
>  delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/pp_feature.h
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h
> deleted file mode 100644
> index b8f4b73c322e..000000000000
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_feature.h b/drivers/gpu/drm/amd/powerplay/inc/pp_feature.h
> deleted file mode 100644
> index 0faf6a25c18b..000000000000
> --
> 2.13.6
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
