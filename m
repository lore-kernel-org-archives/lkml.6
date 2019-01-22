Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A5DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3C020844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="loZvgyKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfAVKIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:08:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38188 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfAVKIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:08:41 -0500
Received: from zn.tnic (p200300EC2BCBD900FDF77747CEA11C98.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:d900:fdf7:7747:cea1:1c98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0218C1EC0A74;
        Tue, 22 Jan 2019 11:08:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548151720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Xo0sGk3C75UXnmkXVlyP7P+lqnBU6fJX918wD+gwH9U=;
        b=loZvgyKklanN6VS/Xw0sOxY6dSCsocwko9nkZidPCt21Cr8ka/MIKxcf+ylDOS7DWiXGch
        mJgoOrg8l7FcqlQTnQNVpvXLHl80NT7IdJFjSK5q1z+TbqjtMvoorE7/xD/0zCrvQv+FgU
        NQ7cfziy2ChjW+7SDSLApyuqWf0zPz4=
Date:   Tue, 22 Jan 2019 11:08:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: arch/x86/include/asm/cmpxchg.h:245:2: error: 'asm' operand has
 impossible constraints
Message-ID: <20190122100815.GA26587@zn.tnic>
References: <201901221204.ZqZgxRnA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201901221204.ZqZgxRnA%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:53:11PM +0800, kbuild test robot wrote:
> Hi Ingo,
> 
> FYI, the error/warning still remains.

Guys,

we already discussed this:

https://lists.01.org/pipermail/kbuild-all/2018-December/056206.html

but you keep reporting it.

You need to fix your reported issues tracking or otherwise no one will
bother anymore.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
