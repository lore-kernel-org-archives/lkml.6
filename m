Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEDDC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B425E20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B425E20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeLACWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:22:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39049 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeLACWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:22:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id n21so6226416qtl.6;
        Fri, 30 Nov 2018 07:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGQiLtJNLrSmsTK5xnToCcWEgBFrOxd4w8TFexkH4H8=;
        b=l1RrZg6GaF/drTdBKgSbl+HT5WJeJje8cZ5jN0QIX6q9WHUST1FliCgAAjviRRedDU
         3JXcqK2W+0DZrEUCjy4NkcQeX5pR0Ek+eRN5e9wwjisE3e6iUnqvfvZAE1em/gV1VdFW
         +P5umtIT09YcSsN4gKXh351U+5YFerJt7u45B/i6kIPtqkvYOQqssMt806KpGxNioeEA
         5f2o7TaKL7OyJ2npw+1Qc64BROgtKyyE37FFfHUp0kBGIqYEc1v0HwfBhBMSMop84rfH
         OW6SYgiIuwb4zhpThAuX5eptJlPeq4M4AOLVFWSCnt4XBSRCnNb0MFfEwI+wpW0IO+R1
         Wp4A==
X-Gm-Message-State: AA+aEWb4bUPgbDq6QUHWCNK0XuScjNnGppw8nF6+oUF0nAUl1Cm5udDQ
        xrBVFD2lpdM5Pq46syjSfaHpNSqTxoKSx4Ormcw=
X-Google-Smtp-Source: AFSGD/V0o5LB1+tR9QdFo9SBDzf4D2+dk3avrEaylYktuiYc5jqP9T49/MsIb32P8aL9IcTkVRWCA2Hm4MxM4GGKEPE=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr5808500qvm.149.1543590756058;
 Fri, 30 Nov 2018 07:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20181130150050.13762-1-robdclark@gmail.com> <20181130150050.13762-5-robdclark@gmail.com>
In-Reply-To: <20181130150050.13762-5-robdclark@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 16:12:18 +0100
Message-ID: <CAK8P3a07rtXfq1PApR7Nsa5mch9hcZHx3dT_u2y2ARuNpCUz9w@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/msm: bump UAPI version
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 4:02 PM Rob Clark <robdclark@gmail.com> wrote:
>
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 6ebbd5010722..782cc33916d6 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -36,9 +36,11 @@
>   * - 1.3.0 - adds GMEM_BASE + NR_RINGS params, SUBMITQUEUE_NEW +
>   *           SUBMITQUEUE_CLOSE ioctls, and MSM_INFO_IOVA flag for
>   *           MSM_GEM_INFO ioctl.
> + * - 1.4.0 - softpin, MSM_RELOC_BO_DUMP, and GEM_INFO support to set/get
> + *           GEM object's debug name
>   */
>  #define MSM_VERSION_MAJOR      1
> -#define MSM_VERSION_MINOR      3
> +#define MSM_VERSION_MINOR      4
>  #define MSM_VERSION_PATCHLEVEL 0
>

I don't know the background here, but generally speaking we don't have
version numbers for ioctls in kernel drivers. Instead, the old ioctls
need to remain functional, but you can add new ioctl commands
in addition.

Is there something that makes this driver special?

      Arnd
