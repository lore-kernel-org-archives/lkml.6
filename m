Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58173C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1603320BED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1603320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeHTKcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:32:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:34382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbeHTKcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:32:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26AF0AEB6;
        Mon, 20 Aug 2018 07:17:33 +0000 (UTC)
Date:   Mon, 20 Aug 2018 09:17:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 00/11] hugetlb: Factorize hugetlb architecture
 primitives
Message-ID: <20180820071730.GC29735@dhcp22.suse.cz>
References: <20180806175711.24438-1-alex@ghiti.fr>
 <81078a7f-09cf-7f19-f6bb-8a1f4968d6fb@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81078a7f-09cf-7f19-f6bb-8a1f4968d6fb@ghiti.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-08-18 08:45:10, Alexandre Ghiti wrote:
> Hi Michal,
> 
> This patchset got acked, tested and reviewed by quite a few people, and it
> has been suggested
> that it should be included in -mm tree: could you tell me if something else
> needs to be done for
> its inclusion ?
> 
> Thanks for your time,

I didn't really get to look at the series but seeing an Ack from Mike
and arch maintainers should be good enough for it to go. This email
doesn't have Andrew Morton in the CC list so you should add him if you
want the series to land into the mm tree.
-- 
Michal Hocko
SUSE Labs
