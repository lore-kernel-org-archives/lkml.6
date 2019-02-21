Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A88C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601C52080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZjDZHeMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfBUVLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:11:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48664 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfBUVLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:11:09 -0500
Received: from zn.tnic (p200300EC2BCBF80051F03EA347F7F3C5.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:f800:51f0:3ea3:47f7:f3c5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 126AD1EC0324;
        Thu, 21 Feb 2019 22:11:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550783468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aDs35AmZWCByC8o+YmXsV+Bypq3X1LhSHfzXdT0MKIw=;
        b=ZjDZHeMtJSYnEiCgFW8c56IvcG+YqgEgwwKiMUu3mMFjji2hsTvzCwvkSPoWtnuBh/PRN0
        rBcRxa8RABWJeX5aaAFbTFAjgUfrTz/7bzSTsddjbGTsPbcYoUpd6hobyptY532cj2z84e
        98VvLVtILPF7EstOoeWgN92MP/7WYiQ=
Date:   Thu, 21 Feb 2019 22:10:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org, graysky@archlinux.us
Subject: Re: [PATCH RFC 0/1] x86: adds additional CPU options
Message-ID: <20190221211057.GE12997@zn.tnic>
References: <20190221203209.16224-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221203209.16224-1-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:32:08PM +0100, Corentin Labbe wrote:
> Hello
> 
> This patchset is a try to mainline a patch that lay around in
> gentoo-kernel for at least 4 years.

And every couple of months someone sends some variant of this patch and
every time we say no. Just don't bother.

https://lore.kernel.org/lkml/1386518000.90452.YahooMailNeo@web140004.mail.bf1.yahoo.com/

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
