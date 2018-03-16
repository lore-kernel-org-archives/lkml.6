Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeCPTAK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 15:00:10 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45430 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbeCPTAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 15:00:05 -0400
X-Google-Smtp-Source: AG47ELuhJGPb9AlTqP1kM9yuStXMSdZHq97hcUwvQGoTmbwEmhc3yoh8eF9ha/5jaxlFihKY4WzvQQ==
Date: Fri, 16 Mar 2018 15:00:02 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v9 10/61] xarray: Change definition of sibling entries
Message-ID: <20180316190001.56clqrub6gy6lzh5@destiny>
References: <20180313132639.17387-1-willy@infradead.org>
 <20180313132639.17387-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313132639.17387-11-willy@infradead.org>
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 06:25:48AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Instead of storing a pointer to the slot containing the canonical entry,
> store the offset of the slot.  Produces slightly more efficient code
> (~300 bytes) and simplifies the implementation.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  include/linux/xarray.h | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/radix-tree.c       | 66 +++++++++++------------------------
>  2 files changed, 112 insertions(+), 47 deletions(-)
> 

Reviewed-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
