Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01B221B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="elhOZpOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbfBKRhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:37:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36277 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbfBKRhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:37:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id q11so8441521lfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 09:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPID5s6CQl5J4CQI5P8LG5ZDMHHRg4P7OH+iq3YZsJ4=;
        b=elhOZpOYZikdUmUYEfTqdhi+mhvr5gHN2ZcwC8WME8oaYZ+d/Qc/8xxVrqoxU/VK3h
         4AlCyyqps7Iw3IEg2ZK27JYNvenjkayiq3PeQCw0XCpu1bRzVxLcauC5AABafbteMKZ/
         a98prJxxyKX7kWHVxMSpnlvdeHcqFpiFUHjAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPID5s6CQl5J4CQI5P8LG5ZDMHHRg4P7OH+iq3YZsJ4=;
        b=qJ9E7+SUOAgH9SUuK1k0/M4X2XIzuslPkknfdBxktGUayT34j/8kFNdmxAgoE4Zvdf
         16BwuIb167SWX0nlIIdOFtHZAdzopM1YJFGTOfUiNjTYi9hbYSFTuydBQJ5x/CZ5StA5
         xo1NVKnDwXmcafGNkhv8tdF4SLAjeAqlxSXKUCoSEb+wifjsepw2jeTAbyZsVHg9aJLl
         M/IcU4Tc4M6iB4B+fdkaCFJNDFUlJZWE6ldfux4432d8i7EARLuKmUkm3nM527WvZkdD
         3/Dz5YMckKRd3DrnkolwHWvZa9F8xbo6Zjl0fvqRw9u5IBw2P4P0+FM41ZSSUwr0+Mys
         NApg==
X-Gm-Message-State: AHQUAuZHgkJCfdFxeMj/ABGUbTiv7MlDGFec2A2eXI7ZxjsEyhmo6ql6
        MSHLMH976qQxA1u6X79rJ7gLGrwnhrJI4kz5rUu/cA==
X-Google-Smtp-Source: AHgI3IZoVSQYVkfeS6gOx4wEQUkXsE2A+fjssI4hrNXy7RfFllKnUb14TARHZ3vQtPvdYXmIOxDe0085gctpkPwUuh0=
X-Received: by 2002:a19:915d:: with SMTP id y29mr9655054lfj.92.1549906627571;
 Mon, 11 Feb 2019 09:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20190207201001.5730-1-eric@anholt.net>
In-Reply-To: <20190207201001.5730-1-eric@anholt.net>
From:   Thomas Spurden <thomas.spurden@broadcom.com>
Date:   Mon, 11 Feb 2019 17:36:56 +0000
Message-ID: <CANFymN1Hp1a0U8A0MhYe0bL0y+0Bc-FXk8Ra6JFAf5QM7za4rg@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/v3d: Update top-level kerneldoc for the addition
 of TFU.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dave Emett <david.emett@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 20:10, Eric Anholt <eric@anholt.net> wrote:
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Thomas Spurden <thomas.spurden@broadcom.com>

> ---
>  drivers/gpu/drm/v3d/v3d_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index 22fff0d3aecd..1f22ce542a04 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -7,9 +7,9 @@
>   * This driver supports the Broadcom V3D 3.3 and 4.1 OpenGL ES GPUs.
>   * For V3D 2.x support, see the VC4 driver.
>   *
> - * Currently only single-core rendering using the binner and renderer
> - * is supported.  The TFU (texture formatting unit) and V3D 4.x's CSD
> - * (compute shader dispatch) are not yet supported.
> + * Currently only single-core rendering using the binner and renderer,
> + * along with TFU (texture formatting unit) rendering is supported.
> + * V3D 4.x's CSD (compute shader dispatch) is not yet supported.
>   */
>
>  #include <linux/clk.h>
> --
> 2.20.0.rc1
>


-- 
Thomas Spurden
