Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E1FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267BA20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b+gsCJlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfBAWVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:21:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfBAWVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eFb+ufzu9Crvqn+Dy45M5KCHNYiMlOpScNGlX7vd+Pc=; b=b+gsCJlI/HN+bv5Be+W6KqEc7
        v/ki0XKrJmCmkijBDdlYK6g1U6TB2DKSa5oHGU+LhTplg+Ah4ai+x+5dyUqhH7jIjVJ3WYeyzw1bF
        4j9p5eLxv7JbjQNchCe6yhx/aHJQ1qSqphzOerG/IljDYfupiquos0lX5GHeUZ131gpZSwVjTHP+C
        lp+tlGNtNVaE/db3kCe7NkJEPlMCYj3RPFhuhilp88cIKL+N+pS/Lq7NltVj0WdnUZ3zCGtJ7cz0/
        Ew1g9reuc+TCsAUN8amkYf0sSlRDb4UKsqY2Rt2xjtzNSso1zh5GmTHSskozqvkMP4vHwlWbDEAH1
        iVeRpznfg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gphBQ-0007A7-I3; Fri, 01 Feb 2019 22:21:12 +0000
Date:   Fri, 1 Feb 2019 14:21:11 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Add Andy and Darren as arch/x86/platform/
 reviewers
Message-ID: <20190201222111.GB105752@fedora.eng.vmware.com>
References: <20190128113619.19025-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128113619.19025-1-bp@alien8.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 12:36:19PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... so that they can get CCed on platform patches.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: x86@kernel.org


Acked-by: Darren Hart (VMware) <dvhart@infradead.org>

-- 
Darren Hart
VMware Open Source Technology Center
