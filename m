Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756448AbeDYTnS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 15:43:18 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45846 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeDYTnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 15:43:14 -0400
X-Google-Smtp-Source: AIpwx496QXyiN/AL9dp7u6FNB0mwHmc62krlZRsih3XEw6EoM+0GdPrE4jZLWvUEZqogY9EYlnKFUQ==
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Daniel Vetter'" <daniel.vetter@ffwll.ch>,
        "'DRI Development'" <dri-devel@lists.freedesktop.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>
Cc: "'Lee Jones'" <lee.jones@linaro.org>,
        "'Daniel Thompson'" <daniel.thompson@linaro.org>,
        "'Daniel Vetter'" <daniel.vetter@intel.com>
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch> <20180425174253.4616-6-daniel.vetter@ffwll.ch>
In-Reply-To: <20180425174253.4616-6-daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 6/6] MAINTAINERS: add dri-devel for backlight subsystem patches
Date: Wed, 25 Apr 2018 15:43:12 -0400
Message-ID: <000101d3dccd$a5a47020$f0ed5060$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-language: en-us
Thread-Index: AQKYOvWw68i4qsBoV9wH2Dzil6RYcgHwz46EonmerFA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 25, 2018 1:43 PM, Daniel Vetter wrote:
> 
> For the same reasons we've added dri-devel for all fbdev patches: Most
> of the actively developed drivers using this infrastructure are in
> drivers/gpu/. It just makes sense to cross-post patches and keep
> aligned. And total activity in the backlight subsystem is miniscule
> compared to drm overall.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa72c117bcd5..0f902399a348 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2589,6 +2589,7 @@ BACKLIGHT CLASS/SUBSYSTEM
>  M:	Lee Jones <lee.jones@linaro.org>
>  M:	Daniel Thompson <daniel.thompson@linaro.org>
>  M:	Jingoo Han <jingoohan1@gmail.com>
> +L:	dri-devel@lists.freedesktop.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
>  S:	Maintained
>  F:	drivers/video/backlight/
> --
> 2.17.0
