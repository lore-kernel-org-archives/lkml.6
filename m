Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867D5C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5995721479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfACWLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:11:18 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:53262 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfACWLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:11:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 647F82A185;
        Thu,  3 Jan 2019 17:11:15 -0500 (EST)
Date:   Fri, 4 Jan 2019 09:11:16 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 22/25] powerpc: Remove CONFIG_GENERIC_NVRAM and adopt
 CONFIG_HAVE_ARCH_NVRAM_OPS
In-Reply-To: <20190103080514.GC11147@infradead.org>
Message-ID: <alpine.LNX.2.21.1901040909020.658@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <22b3299016531a7a05c9c45b36d43565c794e67d.1545784679.git.fthain@telegraphics.com.au> <20190103080514.GC11147@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019, Christoph Hellwig wrote:

> >  # All PPC32s use generic nvram driver through ppc_md
> > -config GENERIC_NVRAM
> > +config HAVE_ARCH_NVRAM_OPS
> >  	bool
> >  	default y if PPC32
> 
> Symbols like this really should be defined in common code, and then
> just selected by the users.
> 

I'll move it to arch/Kconfig.

Thanks.

-- 
