Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68561C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4622245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4622245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeKMUTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:19:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44024 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbeKMUTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:19:32 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1E2A720714; Tue, 13 Nov 2018 11:22:05 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id E5DD22039F;
        Tue, 13 Nov 2018 11:22:04 +0100 (CET)
Date:   Tue, 13 Nov 2018 11:22:04 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 1/4] drm/v3d: Fix whitespace inconsistency in the
 header.
Message-ID: <20181113112204.128164d0@bbrezillon>
In-Reply-To: <20181108161654.19888-2-eric@anholt.net>
References: <20181108161654.19888-1-eric@anholt.net>
        <20181108161654.19888-2-eric@anholt.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 08:16:51 -0800
Eric Anholt <eric@anholt.net> wrote:

Maybe you could add a short description here to avoid having an empty
commit message.

> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  include/uapi/drm/v3d_drm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
> index f446656d00b1..b1e5de076b0f 100644
> --- a/include/uapi/drm/v3d_drm.h
> +++ b/include/uapi/drm/v3d_drm.h
> @@ -66,7 +66,7 @@ struct drm_v3d_submit_cl {
>  	 */
>  	__u32 bcl_start;
>  
> -	 /** End address of the BCL (first byte after the BCL) */
> +	/** End address of the BCL (first byte after the BCL) */
>  	__u32 bcl_end;
>  
>  	/* Offset of the render command list.
> @@ -82,7 +82,7 @@ struct drm_v3d_submit_cl {
>  	 */
>  	__u32 rcl_start;
>  
> -	 /** End address of the RCL (first byte after the RCL) */
> +	/** End address of the RCL (first byte after the RCL) */
>  	__u32 rcl_end;
>  
>  	/** An optional sync object to wait on before starting the BCL. */

