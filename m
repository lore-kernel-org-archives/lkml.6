Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeCPTLq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 15:11:46 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38079 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752742AbeCPTLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 15:11:43 -0400
X-Google-Smtp-Source: AG47ELsNnpfkab9SL98oBiNOG0xycnjNplKPIO3DyJrXJvVs7NdPrSUhPWEIIJ8o7L65K6JuDMo8mg==
Date: Fri, 16 Mar 2018 15:11:41 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v9 12/61] xarray: Define struct xa_node
Message-ID: <20180316191140.gscdlmgnhnzjssdo@destiny>
References: <20180313132639.17387-1-willy@infradead.org>
 <20180313132639.17387-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313132639.17387-13-willy@infradead.org>
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 06:25:50AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> This is a direct replacement for struct radix_tree_node.  A couple of
> struct members have changed name, so convert those.  Use a #define so
> that radix tree users continue to work without change.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Reviewed-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
