Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753546AbeEHARD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:17:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46954 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbeEHARB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:17:01 -0400
X-Google-Smtp-Source: AB8JxZrWHxMxXdaQS4jLVjz+LWeaBg89Hr2a7PnY47YQWwQ7oGhH1es4qXbNSnQfXNeBOQJZLqY6Vw==
Subject: Re: [PATCH v2] MAINTAINERS: add keyword for devicetree overlay
 notifiers
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <1524879080-27111-1-git-send-email-frowand.list@gmail.com>
Message-ID: <0d6a7e46-f659-ae6d-c25d-978f17aa2e63@gmail.com>
Date: Mon, 7 May 2018 17:16:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524879080-27111-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Do you want to take this or should I route it through Andrew?

-Frank


On 04/27/18 18:31, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
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
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> changes from version 1:
>    - removed extraneous "From:" tags at top of patch description
> 
> 
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
