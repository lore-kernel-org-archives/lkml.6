Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeA3TXm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:23:42 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38629 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbeA3TXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:23:31 -0500
X-Google-Smtp-Source: AH8x225Evhmh2wTVPYKPUkq7wvJHT8QTxON9aAlS2DUciEkyuZUPeJrGj6MsmditMN7gqHDNykPliyzTih5WIcFrQY8=
MIME-Version: 1.0
In-Reply-To: <20180117182241.14688-1-luisbg@kernel.org>
References: <20180117182241.14688-1-luisbg@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Jan 2018 14:23:30 -0500
Message-ID: <CADnq5_NxTYR=09z6UyQ9TqRyfhrLDYCUz8TGoUD3jiqWwOKuLQ@mail.gmail.com>
Subject: Re: [PATCH] drm: Fix trailing semicolon
To: Luis de Bethencourt <luisbg@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andres Rodriguez <andresx7@gmail.com>, Joe Perches <joe@perches.com>,
        Christian Konig <christian.koenig@amd.com>,
        Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2018 at 1:22 PM, Luis de Bethencourt <luisbg@kernel.org> wrote:
> The trailing semicolon is an empty statement that does no operation.
> Removing it since it doesn't do anything.
>
> Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>

Applied.  thanks!

Alex

> ---
>
> Hi,
>
> After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
> suggested I fix it treewide [0].
>
> Best regards
> Luis
>
>
> [0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
> [1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html
>
>  drivers/gpu/drm/scheduler/gpu_scheduler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> index 2c18996d59c5..0d95888ccc3e 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> @@ -461,7 +461,7 @@ void drm_sched_hw_job_reset(struct drm_gpu_scheduler *sched, struct drm_sched_jo
>  {
>         struct drm_sched_job *s_job;
>         struct drm_sched_entity *entity, *tmp;
> -       int i;;
> +       int i;
>
>         spin_lock(&sched->job_list_lock);
>         list_for_each_entry_reverse(s_job, &sched->ring_mirror_list, node) {
> --
> 2.15.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
