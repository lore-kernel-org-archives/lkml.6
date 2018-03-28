Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeC1QSg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:18:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751135AbeC1QSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:18:34 -0400
Subject: Re: [PATCH] MAINTAINERS: vfio/platform: Update sub-maintainer
To: Alex Williamson <alex.williamson@redhat.com>
References: <20180326194121.10256.27009.stgit@gimli.home>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        a.rigo@virtualopensystems.com
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6523cfca-f066-5287-9290-ca0033418efd@redhat.com>
Date: Wed, 28 Mar 2018 18:18:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180326194121.10256.27009.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 26/03/18 21:42, Alex Williamson wrote:
> Baptiste has changed positions and has not been active with
> vfio-platform, replace with the current, de-facto sub-maintainer
> Eric Auger.  Also add Alvise Rigo as a designated reviewer.
> 
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alvise Rigo <a.rigo@virtualopensystems.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  MAINTAINERS |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 205c8fc12a9c..c6680c189f2b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14687,7 +14687,8 @@ F:	include/linux/mdev.h
>  F:	samples/vfio-mdev/
>  
>  VFIO PLATFORM DRIVER
> -M:	Baptiste Reynal <b.reynal@virtualopensystems.com>
> +M:	Eric Auger <eric.auger@redhat.com>
> +R:	Alvise Rigo <a.rigo@virtualopensystems.com>
>  L:	kvm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/vfio/platform/
> 
