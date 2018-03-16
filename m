Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753078AbeCPSGk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:06:40 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37393 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeCPSGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:06:37 -0400
X-Google-Smtp-Source: AG47ELsN2vv1Q7J+grq3lPJ4S3LdSG3w6CimLOgZUH/37AIlmEi4j4+ceuhfAutI55s7fRfPkt5Cxw==
Date: Fri, 16 Mar 2018 14:06:35 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v9 08/61] page cache: Use xa_lock
Message-ID: <20180316180633.e755emgeeovo4ddq@destiny>
References: <20180313132639.17387-1-willy@infradead.org>
 <20180313132639.17387-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313132639.17387-9-willy@infradead.org>
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 06:25:46AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Remove the address_space ->tree_lock and use the xa_lock newly added to
> the radix_tree_root.  Rename the address_space ->page_tree to ->i_pages,
> since we don't really care that it's a tree.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Acked-by: Jeff Layton <jlayton@redhat.com>

Man my eyes started to glaze over about halfway through this one

Reviewed-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
