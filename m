Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeEJUGa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:06:30 -0400
Received: from ms.lwn.net ([45.79.88.28]:59074 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbeEJUG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:06:28 -0400
Date: Thu, 10 May 2018 14:06:24 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH -mm] mm, THP, doc: Add document for
 thp_swpout/thp_swpout_fallback
Message-ID: <20180510140624.6de120e8@lwn.net>
In-Reply-To: <20180509082341.13953-1-ying.huang@intel.com>
References: <20180509082341.13953-1-ying.huang@intel.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 May 2018 16:23:41 +0800
"Huang, Ying" <ying.huang@intel.com> wrote:

> From: Huang Ying <ying.huang@intel.com>
> 
> Add document for newly added thp_swpout, thp_swpout_fallback fields in
> /proc/vmstat.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>

Applied, thanks.

jon
