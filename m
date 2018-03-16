Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeCPTFh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 15:05:37 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:37488 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbeCPTFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 15:05:35 -0400
X-Google-Smtp-Source: AG47ELtoTyn4fWKtL0owJmrf7fHJtzQaflb9GnBT8/WIJmBv+pm+cpj+muGO4dV7w6/fx2ZQB5XZeg==
Date: Fri, 16 Mar 2018 15:05:33 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v9 11/61] xarray: Add definition of struct xarray
Message-ID: <20180316190531.kpepu5eaimnnixf5@destiny>
References: <20180313132639.17387-1-willy@infradead.org>
 <20180313132639.17387-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313132639.17387-12-willy@infradead.org>
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 06:25:49AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> This is a direct replacement for struct radix_tree_root.  Some of the
> struct members have changed name; convert those, and use a #define so
> that radix_tree users continue to work without change.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Reviewed-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
