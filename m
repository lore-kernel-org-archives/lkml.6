Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeBICz0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 21:55:26 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34708 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbeBICzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 21:55:24 -0500
X-Google-Smtp-Source: AH8x2241bJ/swTF+1dIn4bCH4TbLcG+2byVVia1oG4S1yaoD65PsAo0isE0FutFn1VRh087zxF+QOQ==
Date: Fri, 9 Feb 2018 11:55:20 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 1/2] zsmalloc: introduce zs_huge_object() function
Message-ID: <20180209025520.GA3423@jagdpanzerIV>
References: <20180207092919.19696-1-sergey.senozhatsky@gmail.com>
 <20180207092919.19696-2-sergey.senozhatsky@gmail.com>
 <20180208163006.GB17354@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208163006.GB17354@rapoport-lnx>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/08/18 18:30), Mike Rapoport wrote:
[..]
> > 
> > +/*
> > + * Check if the object's size falls into huge_class area. We must take
> > + * ZS_HANDLE_SIZE into account and test the actual size we are going to
> > + * use up. zs_malloc() unconditionally adds handle size before it performs
> > + * size_class lookup, so we may endup in a huge class yet zs_huge_object()
> > + * returned 'false'.
> > + */
> 
> Can you please reformat this comment as kernel-doc?

Is this - Documentation/doc-guide/kernel-doc.rst - the right thing
to use as a reference?

	-ss
