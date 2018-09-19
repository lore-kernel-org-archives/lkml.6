Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BA8ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683A720877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683A720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbeITDHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:07:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36110 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeITDHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:07:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id r69-v6so6461537oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWHd16WLhSAAVLkioyXOAwpXtJN3NGfrME9lmYxcAmg=;
        b=d40gX/YieCw3KRhqZchOrM+Ba6NaZpuJ09WxxvI5HtYzBhoVexmVvYm882/1V7N/Du
         0c513xYJM3YdxzUZFSYXgW62KN30J886SH5txxxlvWid3LGM0Ch8LAWDHgiA4FrloySg
         sxMOf6EzFhaRfh6dNAXUEsstzqRul8P6Nx3RpIWUxyZmc/2hFBgmmIPTSx+ywp5E/dAG
         HXUS07dxiPI28Hwi/bm1LRxusXkOboPYDym0KuiR7bu5VYP5/rNZ1T0QfyUpJ8IHTPoW
         R7DF/fU594lWxZ441KOHOpirj1F81oCBMIqOJ+mye9N6uL3mTIbdo63pAgJLUZXZNGbI
         ZazA==
X-Gm-Message-State: APzg51A06BgLsoJOSIBK5D+9q4Sd5ilqMeL5HC1dPb61p2nAXcSJecLz
        DtyjLYX/SO2xR9B6PCL5RZ3QnQGqJmKJKiNy40OZdw==
X-Google-Smtp-Source: ANB0VdZwncRlJgFFJ4v2z9w9ssD77XjHdPX7LCrWZsuIyF4V3KqRYdZUU+4dDSt8jb8+dRxWxd34+ML2vNeo5Y+iGGU=
X-Received: by 2002:aca:1719:: with SMTP id j25-v6mr3045665oii.138.1537392471718;
 Wed, 19 Sep 2018 14:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180919204026.3217-1-sean@poorly.run>
In-Reply-To: <20180919204026.3217-1-sean@poorly.run>
From:   David Airlie <airlied@redhat.com>
Date:   Thu, 20 Sep 2018 07:27:39 +1000
Message-ID: <CAMwc25rA_yB3U=FnZ62-UeqO=5XFG2uZLgdqe9MXeyKDX365NA@mail.gmail.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Move udl drm driver to drm-misc tree
To:     sean@poorly.run
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        seanpaul@chromium.org, airlied <airlied@linux.ie>,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 6:40 AM Sean Paul <sean@poorly.run> wrote:
>
> From: Sean Paul <seanpaul@chromium.org>
>
> Move udl maintenance into drm-misc tree. I've also signed up to be a
> reviewer, but have kept it at "Odd Fixes" level of support.
>
> Cc: Dave Airlie <airlied@redhat.com>

Acked-by: Dave Airlie <airlied@redhat.com>

> Cc: David Airlie <airlied@linux.ie>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d9068ed4ee5..ba1dbb8735b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4720,8 +4720,11 @@ F:       drivers/gpu/drm/tdfx/
>
>  DRM DRIVER FOR USB DISPLAYLINK VIDEO ADAPTERS
>  M:     Dave Airlie <airlied@redhat.com>
> +R:     Sean Paul <sean@poorly.run>
> +L:     dri-devel@lists.freedesktop.org
>  S:     Odd Fixes
>  F:     drivers/gpu/drm/udl/
> +T:     git git://anongit.freedesktop.org/drm/drm-misc
>
>  DRM DRIVER FOR VMWARE VIRTUAL GPU
>  M:     "VMware Graphics" <linux-graphics-maintainer@vmware.com>
> --
> Sean Paul, Software Engineer, Google / Chromium OS
>
