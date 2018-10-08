Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F27C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B602075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B602075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJHVob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:44:31 -0400
Received: from ms.lwn.net ([45.79.88.28]:41264 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJHVob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:44:31 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D8BB76EC;
        Mon,  8 Oct 2018 14:32:29 +0000 (UTC)
Date:   Mon, 8 Oct 2018 08:32:28 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm tree with the jc_docs tree
Message-ID: <20181008083228.33ec7c1d@lwn.net>
In-Reply-To: <6ab76538-b836-3b22-cb29-102c613091cf@redhat.com>
References: <20181008183840.70ebfe94@canb.auug.org.au>
        <20181008081315.GB6772@rapoport-lnx>
        <6ab76538-b836-3b22-cb29-102c613091cf@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 10:38:29 +0200
David Hildenbrand <david@redhat.com> wrote:

> > I can do the renaming and add the patch
> > 
> >   "memory-hotplug.txt: add some details about locking internals"
> > 
> > on top of the jc_docs tree.
> > 
> > Does it sound Ok?
> >   
> 
> Fine with me.

Works for me too.

Andrew, what is your preference for mm docs patches going forward?  It
seems we should try to focus them on one tree or the other.  My preference
would be to keep carrying them to avoid conflicts elsewhere, but I can
certainly direct them youward if you'd rather they went that way.

Thanks,

jon
