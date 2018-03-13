Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeCMTlb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 15:41:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeCMTla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 15:41:30 -0400
Date: Tue, 13 Mar 2018 12:41:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: mhocko@suse.com, catalin.marinas@arm.com, pasha.tatashin@oracle.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        npiggin@gmail.com, baiyaowei@cmss.chinamobile.com,
        bob.picco@oracle.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: OK to merge via powerpc? (was Re: [PATCH 05/14] mm: make
 memblock_alloc_base_nid non-static)
Message-Id: <20180313124128.875efd39a5d3ce9a9bb37e63@linux-foundation.org>
In-Reply-To: <873714goxg.fsf@concordia.ellerman.id.au>
References: <20180213150824.27689-1-npiggin@gmail.com>
        <20180213150824.27689-6-npiggin@gmail.com>
        <873714goxg.fsf@concordia.ellerman.id.au>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 23:06:35 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:

> Anyone object to us merging the following patch via the powerpc tree?
> 
> Full series is here if anyone's interested:
>   http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=28377&state=*
> 

Yup, please go ahead.

I assume the change to the memblock_alloc_range() declaration was an
unrelated, unchangelogged cleanup.
