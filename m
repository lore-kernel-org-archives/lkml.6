Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbeDRPLK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:11:10 -0400
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:54486 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752744AbeDRPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:11:09 -0400
Date: Wed, 18 Apr 2018 10:11:06 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Mikulas Patocka <mpatocka@redhat.com>
cc: Vlastimil Babka <vbabka@suse.cz>, Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLUB: Do not fallback to mininum order if __GFP_NORETRY
 is set
In-Reply-To: <alpine.LRH.2.02.1804181102490.13213@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.DEB.2.20.1804181010320.1530@nuc-kabylake>
References: <alpine.DEB.2.20.1804180944180.1062@nuc-kabylake> <alpine.LRH.2.02.1804181102490.13213@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfJzpnjc7gtd8bV9Q1GjJ2pMyybECbTKSADxaiiGP6dBXum4RLZl2i7IzbqDb3n4MvUHdovXteN5KV80xMhE/0xMF3QtFBny4DDxjhYJhU3K0U4UjOyDf
 fNIfwcbfEgEcwxtqMWEGzMTEciRkk6gD7K9EtYsxuDygUM05WUgXc/VhbKY4Sscb4RG5itMiYl99l/kG+1HgIgK4uCtoj9NOf0RK3j8+PY1vxNlHlE39Cwer
 3wyp9hr9BumvgUvGvuJo6bNQvGXOGh/+zzxueXTG9D+NntiEP/cH+Ea5cqCk0JdHMAiYBGD329DuH2n47ZBfcuWd1w6FysTBwUvrph1EFEPziLCUW1QnvvAy
 qe6k91azntiTvkjlOI/H+s4su9ZeqfpzoMXnKMFh8Age7pfy/pEomQ2EmzBKe0aD49xkL8nux3KOFJ8MB2ABKx592mGXgou1cXwuHHgpL559jNt4II4jhn+y
 s3nFw9O3YWElpGZw
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018, Mikulas Patocka wrote:

> No, this would hit NULL pointer dereference if page is NULL and
> __GFP_NORETRY is set. You want this:

You are right

Acked-by: Christoph Lameter <cl@linux.com>
