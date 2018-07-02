Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B400C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23C625059
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23C625059
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeGBRc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:32:58 -0400
Received: from ms.lwn.net ([45.79.88.28]:47924 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752576AbeGBRc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:32:57 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DE0CB2E3;
        Mon,  2 Jul 2018 17:32:56 +0000 (UTC)
Date:   Mon, 2 Jul 2018 11:32:55 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] docs/mm: add boot time memory management docs
Message-ID: <20180702113255.1f7504e2@lwn.net>
In-Reply-To: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018 17:54:55 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> Both bootmem and memblock have pretty good documentation coverage. With
> some fixups and additions we get a nice overall description.
> 
> v2 changes:
> * address Randy's comments
> 
> Mike Rapoport (11):
>   mm/bootmem: drop duplicated kernel-doc comments
>   docs/mm: nobootmem: fixup kernel-doc comments
>   docs/mm: bootmem: fix kernel-doc warnings
>   docs/mm: bootmem: add kernel-doc description of 'struct bootmem_data'
>   docs/mm: bootmem: add overview documentation
>   mm/memblock: add a name for memblock flags enumeration
>   docs/mm: memblock: update kernel-doc comments
>   docs/mm: memblock: add kernel-doc comments for memblock_add[_node]
>   docs/mm: memblock: add kernel-doc description for memblock types
>   docs/mm: memblock: add overview documentation
>   docs/mm: add description of boot time memory management

So this seems like good stuff overall.  It digs pretty deeply into the mm
code, though, so I'm a little reluctant to apply it without an ack from an
mm developer.  Alternatively, I'm happy to step back if Andrew wants to
pick the set up.

Thanks,

jon
