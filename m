Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbeDTLPU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:15:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754549AbeDTLPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:15:18 -0400
Date: Fri, 20 Apr 2018 04:15:10 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Stefan Agner <stefan@agner.ch>
Cc: akpm@linux-foundation.org, mhocko@suse.com, catalin.marinas@arm.com,
        torvalds@linux-foundation.org, pasha.tatashin@oracle.com,
        ard.biesheuvel@linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] treewide: use PHYS_ADDR_MAX to avoid type casting
 ULLONG_MAX
Message-ID: <20180420111510.GA10788@bombadil.infradead.org>
References: <20180419214204.19322-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419214204.19322-1-stefan@agner.ch>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 11:42:04PM +0200, Stefan Agner wrote:
> With PHYS_ADDR_MAX there is now a type safe variant for all
> bits set. Make use of it.

There is?  I don't see it in linux-next.
