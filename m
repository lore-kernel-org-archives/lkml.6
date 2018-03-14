Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933092AbeCNA4l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:56:41 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38977 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932732AbeCNA4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:56:39 -0400
X-Google-Smtp-Source: AG47ELtggM9F42At9LGwMx6rUWLrX/FFS0TErcfxBJ4AIINzScUfP8tfl4+CF4sSjpS3LhIYusbQMw==
Date: Wed, 14 Mar 2018 10:56:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, mhocko@suse.com,
        catalin.marinas@arm.com, pasha.tatashin@oracle.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        baiyaowei@cmss.chinamobile.com, bob.picco@oracle.com,
        ard.biesheuvel@linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: OK to merge via powerpc? (was Re: [PATCH 05/14] mm: make
 memblock_alloc_base_nid non-static)
Message-ID: <20180314105620.5d98ff9f@roar.ozlabs.ibm.com>
In-Reply-To: <20180313124128.875efd39a5d3ce9a9bb37e63@linux-foundation.org>
References: <20180213150824.27689-1-npiggin@gmail.com>
        <20180213150824.27689-6-npiggin@gmail.com>
        <873714goxg.fsf@concordia.ellerman.id.au>
        <20180313124128.875efd39a5d3ce9a9bb37e63@linux-foundation.org>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 12:41:28 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 13 Mar 2018 23:06:35 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Anyone object to us merging the following patch via the powerpc tree?
> > 
> > Full series is here if anyone's interested:
> >   http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=28377&state=*
> >   
> 
> Yup, please go ahead.
> 
> I assume the change to the memblock_alloc_range() declaration was an
> unrelated, unchangelogged cleanup.
> 

It is. I'm trying to get better at that. Michael might drop that bit if
he's not already sick of fixing up my patches...

Thanks,
Nick
