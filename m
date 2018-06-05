Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeFEREX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:04:23 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:59586 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752880AbeFEREU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:04:20 -0400
Date: Tue, 5 Jun 2018 17:04:17 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Baoquan He <bhe@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Subject: Re: [PATCH] slab: Clean up the code comment in slab kmem_cache
 struct
In-Reply-To: <20180603032402.27526-1-bhe@redhat.com>
Message-ID: <01000163d0e8083c-096b06d6-7202-4ce2-b41c-0f33784afcda-000000@email.amazonses.com>
References: <20180603032402.27526-1-bhe@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.06.05-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jun 2018, Baoquan He wrote:

> diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> index d9228e4d0320..3485c58cfd1c 100644
> --- a/include/linux/slab_def.h
> +++ b/include/linux/slab_def.h
> @@ -67,9 +67,10 @@ struct kmem_cache {
>
>  	/*
>  	 * If debugging is enabled, then the allocator can add additional
> -	 * fields and/or padding to every object. size contains the total
> -	 * object size including these internal fields, the following two
> -	 * variables contain the offset to the user object and its size.
> +	 * fields and/or padding to every object. 'size' contains the total
> +	 * object size including these internal fields, while 'obj_offset'
> +	 * and 'object_size' contain the offset to the user object and its
> +	 * size.
>  	 */
>  	int obj_offset;
>  #endif /* CONFIG_DEBUG_SLAB */
>

Wish we had some more consistent naming. object_size and obj_offset??? And
the fields better be as close together as possible.


Acked-by: Christoph Lameter <cl@linux.com>
