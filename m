Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeESNZF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 09:25:05 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:39804 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeESNZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 09:25:03 -0400
Subject: Re: [PATCH 1/3] MAINTAINERS: fix path to ilitek,ili9225 device tree
 bindings
To: David Lechner <david@lechnology.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        limor@ladyada.net, Nitin Patil <nitin@mindsensors.com>,
        linux-kernel@vger.kernel.org
References: <20180515014349.26226-1-david@lechnology.com>
 <20180515014349.26226-2-david@lechnology.com>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <7582e869-c86b-5cc0-7d2d-7304d7b52026@tronnes.org>
Date: Sat, 19 May 2018 15:24:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515014349.26226-2-david@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 15.05.2018 03.43, skrev David Lechner:
> This fixes the path to the ilitek,ili9225 device tree binding file.
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 334a00350922..bc219de9cbee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4478,7 +4478,7 @@ DRM DRIVER FOR ILITEK ILI9225 PANELS
>   M:	David Lechner <david@lechnology.com>
>   S:	Maintained
>   F:	drivers/gpu/drm/tinydrm/ili9225.c
> -F:	Documentation/devicetree/bindings/display/ili9225.txt
> +F:	Documentation/devicetree/bindings/display/ilitek,ili9225.txt
>   
>   DRM DRIVER FOR INTEL I810 VIDEO CARDS
>   S:	Orphan / Obsolete
