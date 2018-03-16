Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbeCPTMm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 15:12:42 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:45777 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeCPTMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 15:12:40 -0400
X-Google-Smtp-Source: AG47ELsviQm0BCgTtmDDAFiALwls36i7t8nH2jBBTYsdKKmnd+dTuGS2KLJznoYGArHRDxBjG6LGNA==
Date: Fri, 16 Mar 2018 15:12:37 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v9 13/61] xarray: Add documentation
Message-ID: <20180316191236.jsmlnwgy76htz5fi@destiny>
References: <20180313132639.17387-1-willy@infradead.org>
 <20180313132639.17387-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313132639.17387-14-willy@infradead.org>
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 06:25:51AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> This is documentation on how to use the XArray, not details about its
> internal implementation.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

I'm just going to assume you know what you are talking about here

Acked-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
