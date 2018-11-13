Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201F6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C8820684
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C8820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbeKMUUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:20:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44042 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbeKMUT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:19:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 58CEA2039F; Tue, 13 Nov 2018 11:22:32 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 23DBF2039F;
        Tue, 13 Nov 2018 11:22:32 +0100 (CET)
Date:   Tue, 13 Nov 2018 11:22:32 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 2/4] drm/v3d: Update a comment about what uses
 v3d_job_dependency().
Message-ID: <20181113112232.1cf24f00@bbrezillon>
In-Reply-To: <20181108161654.19888-3-eric@anholt.net>
References: <20181108161654.19888-1-eric@anholt.net>
        <20181108161654.19888-3-eric@anholt.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 08:16:52 -0800
Eric Anholt <eric@anholt.net> wrote:

> I merged bin and render's paths in a late refactoring.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/gpu/drm/v3d/v3d_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 9243dea6e6ad..e1f2aab0717b 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -39,7 +39,7 @@ v3d_job_free(struct drm_sched_job *sched_job)
>  }
>  
>  /**
> - * Returns the fences that the bin job depends on, one by one.
> + * Returns the fences that the bin or render job depends on, one by one.
>   * v3d_job_run() won't be called until all of them have been signaled.
>   */
>  static struct dma_fence *

