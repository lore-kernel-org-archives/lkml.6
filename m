Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeCWPwv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:52:51 -0400
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:46162 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750789AbeCWPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:52:50 -0400
Date: Fri, 23 Mar 2018 10:52:48 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Mikulas Patocka <mpatocka@redhat.com>
cc: Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab_common: remove test if cache name is accessible
In-Reply-To: <alpine.LRH.2.02.1803231133310.22626@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.DEB.2.20.1803231052220.5289@nuc-kabylake>
References: <alpine.LRH.2.02.1803231133310.22626@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfDDGSPFdk8exYN89vMX+xpn+C+YGpsAVGdBnlKyQtOfPxXr04CM16scq/LSlXCJJ4QKKasSrG6jsaF3TeSKd152ipWxhj5rSrebIw+8m5jo/WKdShsWK
 QjfcSWAJKjrmqwIMpAFLTK2Ac9Hcs0LQZqNi8ZyrM1/5PRynITMvPOeCk7J+DX+jkmGWiVqClTRtVGBg9KAx0Uq+ZWGgZZ+DRShSl56tKSELFUYmvpca/vp1
 mQUlPPkWAmgXQGKRUTNsLgUZl/+rVvUm7ePL8VWXahXzJpepko10Zv/CzQ91pFyKtka89MigUgpMUaTPr7aJzAokE9vwb35yVJc0RfoIy5u1dpdaWrsQmzX8
 8Id609Q4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, Mikulas Patocka wrote:

> Since the commit db265eca7700 ("mm/sl[aou]b: Move duping of slab name to
> slab_common.c"), the kernel always duplicates the slab cache name when
> creating a slab cache, so the test if the slab name is accessible is
> useless.

Acked-by: Christoph Lameter <cl@linux.com>
