Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185D0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC9620827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="sfrr11Qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfAHNbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:31:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51704 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbfAHNbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:31:04 -0500
Received: from zn.tnic (p200300EC2BD06500DD9D1E1F74EBF253.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:6500:dd9d:1e1f:74eb:f253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5837F1EC014B;
        Tue,  8 Jan 2019 14:31:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1546954262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9A952GofYkzaHPsu6VKG634IJfaBIWfdO0JezNxsPyU=;
        b=sfrr11QushHCX8iYtY6jW2VA/ylW45reAKbvnKtdaE1qTF2ZVgTzUYZ+n/TJHeNChhmFjc
        WlDa/4YhIkLb+TsDYzM0vypclNdnnxdY/iBGD20Euh/sW3tzAqyILvk9jJN1OuMyUOkmOY
        3tr28nPJNbOPzOo+uxGdmUhxUSTKK1o=
Date:   Tue, 8 Jan 2019 14:30:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, pavel.tatashin@microsoft.com, joe@perches.com,
        jschoenh@amazon.de, m.mizuma@jp.fujitsu.com,
        n-horiguchi@ah.jp.nec.com, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, "huang.zijiang" <huang.zijiang@zte.com.cn>
Subject: Re: [PATCH] x86:kernel:e820c:kmemdup instead of duplicating its
 function
Message-ID: <20190108133048.GC14243@zn.tnic>
References: <1546926137-32136-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546926137-32136-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: Re: [PATCH] x86:kernel:e820c:kmemdup instead of duplicating its function

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

The condensed patch description in the subject line should start with a
uppercase letter and should be written in imperative tone.

On Tue, Jan 08, 2019 at 01:42:17PM +0800, Yi Wang wrote:
> From: "huang.zijiang" <huang.zijiang@zte.com.cn>
	^^^^^^^^^^^^^^

I'm guessing your name is "Huang Zijiang" and you'd like to have it this
way in git history, instead with small letters and with a dot inbetween?

> kmemdup has implemented the function that kmalloc() and memcpy().

This is not a correct english sentence. Please try again.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
