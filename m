Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B13C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975A821566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975A821566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeI0GR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:17:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbeI0GR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:17:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEBE681DF0;
        Thu, 27 Sep 2018 00:02:32 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D01175D73F;
        Thu, 27 Sep 2018 00:02:31 +0000 (UTC)
Date:   Thu, 27 Sep 2018 08:02:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        x86@kernel.org, thgarnie@google.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 0/3] x86/mm/doc: Clean up mm.txt
Message-ID: <20180927000228.GG2555@MiWiFi-R3L-srv>
References: <20180921020550.13095-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921020550.13095-1-bhe@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 27 Sep 2018 00:02:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/18 at 10:05am, Baoquan He wrote:
> This clean up is suggested by Ingo.

This series is messy, have sent v2. So NACK this v1 series.

> 
> It firstly fix the confusions in mm layout tables by unifying
> each memory region description in the consistent style.
> 
> Secondly take the KASLR words out of the mm layout tables to make
> it as a separate section to only list mm layout in non-KASLR case.
> Then add KASLR document at the end of mm.txt.
> 
> Meanwhile update document about KERNEL_IMAGE_SIZE in
> arch/x86/include/asm/page_64_types.h .
> 
> Baoquan He (3):
>   x86/KASLR: Update document about KERNEL_IMAGE_SIZE
>   x86/mm/doc: Clean up the memory region layout descriptions
>   x86/doc/kaslr.txt: Create a separate part of document abourt KASLR at
>     the end of file
> 
>  Documentation/x86/x86_64/mm.txt      | 138 +++++++++++++++++++++++------------
>  arch/x86/include/asm/page_64_types.h |   7 +-
>  2 files changed, 96 insertions(+), 49 deletions(-)
> 
> -- 
> 2.13.6
> 
