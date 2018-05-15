Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbeEOJMI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:12:08 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37141 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEOJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:12:06 -0400
X-Google-Smtp-Source: AB8JxZolmhxeGeH+g7iW73PPjDXV4H39RWprMUZ7xKCU14zS6AfeOvWIZYwJabmfEgQ34DhvlGCKLQ==
Subject: Re: [PATCH][next] drm/xen-front: fix spelling mistake: "conector" ->
 "connector"
To: Colin King <colin.king@canonical.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xen.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180515085433.8245-1-colin.king@canonical.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <3d506835-80af-e18d-bf53-b159caa8c0a3@gmail.com>
Date: Tue, 15 May 2018 12:12:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515085433.8245-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 11:54 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in DRM_INFO message.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thank you,
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Will apply to drm-misc-next
> ---
>   drivers/gpu/drm/xen/xen_drm_front.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
> index 0e486cb1c10c..3725de4c4da8 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
> @@ -623,7 +623,7 @@ static int displback_initwait(struct xen_drm_front_info *front_info)
>   	if (ret < 0)
>   		return ret;
>   
> -	DRM_INFO("Have %d conector(s)\n", cfg->num_connectors);
> +	DRM_INFO("Have %d connector(s)\n", cfg->num_connectors);
>   	/* Create event channels for all connectors and publish */
>   	ret = xen_drm_front_evtchnl_create_all(front_info);
>   	if (ret < 0)
