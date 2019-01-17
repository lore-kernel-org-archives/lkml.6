Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A8EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E8620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gxR3fEsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfAQKJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:09:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49230 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfAQKJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:09:22 -0500
Received: from zn.tnic (p200300EC2BCAA9000C37F56F6D862BD9.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:a900:c37:f56f:6d86:2bd9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4AD21EC06FB;
        Thu, 17 Jan 2019 11:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547719761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pipPEiFP+POMH/WKhMKbgS62LLBjKd2qmMlbbS2HLoQ=;
        b=gxR3fEsHJmXUK2DMUk0y5+LbOldIdyirS7uolbPNsFEIqPVNqIcetQv2SQUFd+zNeLUJQV
        4hDBpaYeWrI0X3CG/1ZItZJ3QX9Sdk1Qi3Lx9c0e4YcNtyWO90dqIFm7nwe21fpymsEOZi
        U6L6rzUDO0XrPF/wbAdqDwVWsSC3bws=
Date:   Thu, 17 Jan 2019 11:09:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/mce/amd: carve out MC4_MISC thresholding quirk
Message-ID: <20190117100915.GA5023@zn.tnic>
References: <1547651417-23583-1-git-send-email-shirish.s@amd.com>
 <1547651417-23583-3-git-send-email-shirish.s@amd.com>
 <20190116192502.GJ15409@zn.tnic>
 <e65fd961-529e-d479-a269-10267596ec86@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e65fd961-529e-d479-a269-10267596ec86@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 06:06:06AM +0000, S wrote:
> Thanks for the support, i shall follow the practice from next patch onwards.

Ok, but this mail is still broken. I see:

From: S
To: Borislav Petkov <bp@alien8.de>, "S, Shirish" <Shirish.S@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,

So I leave it up to you to pay attention to it and to fix it - I think
I've pointed it to you enough times already.

In case you're wondering why you're not getting replies to your mails,
you'll know why.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
