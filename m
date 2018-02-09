Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbeBIFEn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 00:04:43 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38105 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeBIFEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 00:04:42 -0500
X-Google-Smtp-Source: AH8x224N3IJwfgGNcgyRN8U+zoIrDOmA+0lPFe/if5+HTZy7fKRi62SW1E/Up+8LO+ya+MUjJZfNxw==
Date: Fri, 9 Feb 2018 14:04:36 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 1/2] zsmalloc: introduce zs_huge_object() function
Message-ID: <20180209050436.GB689@jagdpanzerIV>
References: <20180207092919.19696-1-sergey.senozhatsky@gmail.com>
 <20180207092919.19696-2-sergey.senozhatsky@gmail.com>
 <20180208163006.GB17354@rapoport-lnx>
 <20180209025520.GA3423@jagdpanzerIV>
 <20180209041046.GB23828@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209041046.GB23828@bombadil.infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/08/18 20:10), Matthew Wilcox wrote:
> > > > +/*
> > > > + * Check if the object's size falls into huge_class area. We must take
> > > > + * ZS_HANDLE_SIZE into account and test the actual size we are going to
> > > > + * use up. zs_malloc() unconditionally adds handle size before it performs
> > > > + * size_class lookup, so we may endup in a huge class yet zs_huge_object()
> > > > + * returned 'false'.
> > > > + */
> > > 
> > > Can you please reformat this comment as kernel-doc?
> > 
> > Is this - Documentation/doc-guide/kernel-doc.rst - the right thing
> > to use as a reference?
> 
> Yes.  I just sent a revision to it that makes it (I think) a little
> easier to read.  Try this version:

That's helpful, thanks! Will take a look and re-spin the patch.

	-ss
