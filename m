Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbeBIFsQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 00:48:16 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:39277 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeBIFsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 00:48:14 -0500
X-Google-Smtp-Source: AH8x226d6ac27tvx4KR91WK0CrkwXbFjqE7qM7iArymud4+YS4z5EozkTs77CosnQSNc/7ERgGhOHw==
Date: Fri, 9 Feb 2018 14:48:10 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 1/2] zsmalloc: introduce zs_huge_object() function
Message-ID: <20180209054810.GD689@jagdpanzerIV>
References: <20180207092919.19696-1-sergey.senozhatsky@gmail.com>
 <20180207092919.19696-2-sergey.senozhatsky@gmail.com>
 <20180208163006.GB17354@rapoport-lnx>
 <20180209025520.GA3423@jagdpanzerIV>
 <20180209041046.GB23828@bombadil.infradead.org>
 <20180209053630.GC689@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209053630.GC689@jagdpanzerIV>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/09/18 14:36), Sergey Senozhatsky wrote:
> +/**
> + * zs_huge_object() - Test if a compressed object's size is too big for normal
> + *                    zspool classes and it will be stored in a huge class.
> + * @sz: Size in bytes of the compressed object.
> + *
> + * The functions checks if the object's size falls into huge_class area.
> + * We must take ZS_HANDLE_SIZE into account and test the actual size we
> + * are going to use up, because zs_malloc() unconditionally adds the
> + * handle size before it performs size_class lookup.
> + *
> + * Context: Any context.
> + *
> + * Return:
> + * * true  - The object's size is too big, it will be stored in a huge class.
> + * * false - The object will be store in normal zspool classes.
> + */
> ---
> 
> looks OK?

Modulo silly typos... and broken English.

	-ss
