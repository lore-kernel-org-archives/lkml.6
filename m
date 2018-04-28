Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933205AbeD1A54 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:57:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39754 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933018AbeD1A5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:57:53 -0400
X-Google-Smtp-Source: AB8JxZqBpDXDNPOgcuC4+zHnO6xI6AAw+A8lt40Fne+JFSVDXlRg1Xxt79rNIzZmSwOtejDQOACW3Q==
Subject: Re: [PATCH] MAINTAINERS: add keyword for devicetree overlay notifiers
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <1524876619-26283-1-git-send-email-frowand.list@gmail.com>
Message-ID: <0fc405e3-dd6b-3891-3d6b-0026c59a4d74@gmail.com>
Date: Fri, 27 Apr 2018 17:57:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524876619-26283-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I'm not sure how the extra "From:" of sony.com got into
this email.  I'll have to dig into my scripts and/or
git configs to figure that out.  The real "From:" is
the gmail.com one.

-Frank

On 04/27/18 17:50, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> From: Frank Rowand <frowand.list@gmail.com>
> 
> Devicetree overlay notifiers have a chance to potentially get
> pointers into the overlay unflattened devicetree and overlay FDT.
> The only protection against these pointers being accessed after
> the underlying data has been released by kfree() is by source
> code review of patches.  Add a keyword line to the devicetree
> overlay maintainers entry to try to catch overlay notifier
> related patches.
> 
> The keyword line is added to the devicetree overlay entry instead
> of the devicetree entry so that not all maintainers will receive
> the additional review traffic.  Add Frank Rowand (already a
> maintainer in the devicetree entry) so that he will receive
> the additional review traffic.
> 
> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92be777d060a..aca3956694f8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10422,12 +10422,14 @@ F:	drivers/infiniband/ulp/opa_vnic
>  
>  OPEN FIRMWARE AND DEVICE TREE OVERLAYS
>  M:	Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> +M:	Frank Rowand <frowand.list@gmail.com>
>  L:	devicetree@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/dynamic-resolution-notes.txt
>  F:	Documentation/devicetree/overlay-notes.txt
>  F:	drivers/of/overlay.c
>  F:	drivers/of/resolver.c
> +K:	of_overlay_notifier_
>  
>  OPEN FIRMWARE AND FLATTENED DEVICE TREE
>  M:	Rob Herring <robh+dt@kernel.org>
> 
