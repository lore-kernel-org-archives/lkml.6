Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeCWT7y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49821 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbeCWT7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:59:52 -0400
Date: Fri, 23 Mar 2018 13:59:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alvise Rigo <a.rigo@virtualopensystems.com>
Cc: kvm@vger.kernel.org, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: vfio-platform: Update sub-maintainers
Message-ID: <20180323135944.54bb75c1@t450s.home>
In-Reply-To: <20180323175929.15319-1-a.rigo@virtualopensystems.com>
References: <20180323175929.15319-1-a.rigo@virtualopensystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 18:59:29 +0100
Alvise Rigo <a.rigo@virtualopensystems.com> wrote:

> Update the sub-maintainer entry as Baptiste has moved.
> 
> Add me and Eric Auger as sub-maintainers of the VFIO plaform driver.
> 
> Signed-off-by: Alvise Rigo <a.rigo@virtualopensystems.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73c0cdabf755..9619c41c2316 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14688,7 +14688,8 @@ F:	include/linux/mdev.h
>  F:	samples/vfio-mdev/
>  
>  VFIO PLATFORM DRIVER
> -M:	Baptiste Reynal <b.reynal@virtualopensystems.com>
> +M:	Alvise Rigo <a.rigo@virtualopensystems.com>
> +M:	Eric Auger <eric.auger@redhat.com>
>  L:	kvm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/vfio/platform/

Hi Alvise,

Thanks for updating this file, I haven't heard from Baptiste for a long
time and I already look to Eric as the de-facto sub-maintainer of vfio
platform.  However, I don't have any experience with your reviews, nor
do I see any commits in vfio platform or elsewhere in the kernel
attributed to you.  I certainly welcome you on as a designated reviewer
(ie. R:), but I would probably only consider Eric to be the
sub-maintainer at this point.  Any objection, Eric?  Thanks,

Alex
