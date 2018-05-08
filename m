Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933301AbeEHIis (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:38:48 -0400
Received: from verein.lst.de ([213.95.11.211]:36351 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932287AbeEHIio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:38:44 -0400
Date: Tue, 8 May 2018 10:38:32 +0200
From: Torsten Duwe <duwe@lst.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] ppc64le livepatch: implement reliable stacktrace for
 newer consistency models
Message-ID: <20180508103832.085378b9@blackhole.lan>
In-Reply-To: <20180507154208.jo4s43olrf5a3hw4@treble>
References: <20180305164928.GA17953@lst.de>
        <20180308162616.yhbymodggnfzpskx@treble>
        <20180309174718.2700b29e@blackhole.lan>
        <20180312153536.7avozx64ku4lvd3e@treble>
        <20180504123834.GA16581@lst.de>
        <20180507154208.jo4s43olrf5a3hw4@treble>
Organization: LST e.V.
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2018 10:42:08 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> The subject doesn't actively describe what the patch does, maybe
> change it to something like:
> 
>   powerpc: Add support for HAVE_RELIABLE_STACKTRACE
> 
> or maybe
> 
>   powerpc: Add support for livepatch consistency model

Maybe $SUBJECT? You're absolutely right, the old subject was just a
leftover of my original attempt to just set the flag, before Miroslav
corrected me. I just kept on copying it without a second thought. Thanks
for noting.

> Otherwise it looks great to me.
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
Thanks.

	Torsten
