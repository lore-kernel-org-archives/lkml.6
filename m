Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A225ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42579204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42579204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeKIFBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:01:30 -0500
Received: from ms.lwn.net ([45.79.88.28]:60186 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeKIFBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:01:30 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 37D1D6EC;
        Thu,  8 Nov 2018 19:24:36 +0000 (UTC)
Date:   Thu, 8 Nov 2018 12:24:35 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz,
        peterz@infradead.org, dhaval.giani@oracle.com
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Message-ID: <20181108122435.65eceefe@lwn.net>
In-Reply-To: <20181108191553.nu7yn2akmcql2vje@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
        <20181105165558.11698-2-daniel.m.jordan@oracle.com>
        <20181108102638.3415ae0b@lwn.net>
        <20181108191553.nu7yn2akmcql2vje@ca-dmjordan1.us.oracle.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 11:15:53 -0800
Daniel Jordan <daniel.m.jordan@oracle.com> wrote:

> > - You have kerneldoc comments for the API functions, but you don't pull
> >   those into the documentation itself.  Adding some kernel-doc directives
> >   could help to fill things out nicely with little effort.  
> 
> I thought this part of ktask.rst handled that, or am I not doing it right?
> 
>     Interface
>     =========
>     
>     .. kernel-doc:: include/linux/ktask.h

Sigh, no, you're doing it just fine, and I clearly wasn't sufficiently
caffeinated.  Apologies for the noise.

jon
