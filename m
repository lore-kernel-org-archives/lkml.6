Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5251CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215EF20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548141414;
	bh=uidiMFP/kRwVGazWHsmm9m3yB5oXAGwbzxuxsX+R83w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=my8uLtrgMx1dYCkh78m3Mpv7g5FE2UAttIw/Ph3olN2BePgAOWujFV27VvHrQpZlk
	 a/u3G8zuJKZyXAjePxroGVukDYeGPHeeZhj8seOUK/N2xHbCfKAkf6o2Sre4Zm3FHm
	 yWfMKqg/h37yxJ9iR4e37DKD43HKt6HISJ/HclqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfAVHQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:16:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:53718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfAVHQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:16:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 548AE205C9;
        Tue, 22 Jan 2019 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548141410;
        bh=uidiMFP/kRwVGazWHsmm9m3yB5oXAGwbzxuxsX+R83w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quwT2hPObeYrF6iHyScowHnF7rRvBqjOJ5lSx5Pj4dKLf4zMrDyJz1EIAMTLs+SsW
         zTCrBLvBRS8JguDdqI5dcsJH+niOY/+OIcaOMApWA/4+ZTXcF090S3cwcweiIhimS8
         XzORQSz1CxZB/dWfbM9NprRwqXhsbl8CJVuCD+RM=
Date:   Tue, 22 Jan 2019 08:16:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Fix license inconsistent
Message-ID: <20190122071648.GC6240@kroah.com>
References: <20190121205857.pmd26boqrkp4pzjv@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121205857.pmd26boqrkp4pzjv@smtp.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 06:58:57PM -0200, Rodrigo Siqueira wrote:
> Fixes license inconsistent related to the VKMS driver and remove the
> redundant boilerplate comment.
> 
> Fixes: 854502fa0a38 ("drm/vkms: Add basic CRTC initialization")
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_crc.c    | 3 ++-
>  drivers/gpu/drm/vkms/vkms_crtc.c   | 8 +-------
>  drivers/gpu/drm/vkms/vkms_drv.c    | 7 +------
>  drivers/gpu/drm/vkms/vkms_drv.h    | 2 ++
>  drivers/gpu/drm/vkms/vkms_gem.c    | 8 +-------
>  drivers/gpu/drm/vkms/vkms_output.c | 8 +-------
>  drivers/gpu/drm/vkms/vkms_plane.c  | 8 +-------
>  7 files changed, 9 insertions(+), 35 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
