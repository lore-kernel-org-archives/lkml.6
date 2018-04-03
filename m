Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeDCNec (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:34:32 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38524 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeDCNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:34:30 -0400
X-Google-Smtp-Source: AIpwx4/KgJpjKJV9VlfJ5N1GFQPWuggSTnxG9BOZ8hy3ytIAiZ/MSMxQlMNaDUA7/JP3KTszdxV3jw==
Subject: Re: [PATCH] MAINTAINERS: Add drm/xen-front maintainer entry
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180403123238.19294-1-andr2000@gmail.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <e829b033-5f7d-c632-4f04-c867c7fb379a@gmail.com>
Date: Tue, 3 Apr 2018 16:34:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403123238.19294-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 03:32 PM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Add myself as drivers/gpu/drm/xen maintainer.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 622f3e4c5efa..6cf1bd5593b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4834,6 +4834,15 @@ S:	Maintained
>   F:	drivers/gpu/drm/tinydrm/
>   F:	include/drm/tinydrm/
>   
> +DRM DRIVERS FOR XEN
> +M:	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +L:	dri-devel@lists.freedesktop.org
> +L:	xen-devel@lists.xen.org
> +S:	Supported
> +F:	drivers/gpu/drm/xen/
> +F:	Documentation/gpu/xen-front.rst
> +
>   DRM TTM SUBSYSTEM
>   M:	Christian Koenig <christian.koenig@amd.com>
>   M:	Roger He <Hongbo.He@amd.com>
Acked-by Daniel on irc,
applied

Thank you,
Oleksandr
