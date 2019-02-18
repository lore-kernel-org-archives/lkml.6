Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EAFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BE02184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MA8SHpY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfBRIaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:30:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43918 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbfBRIaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:30:16 -0500
Received: from zn.tnic (p200300EC2BC7C70041AEC7F500F46BD2.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:c700:41ae:c7f5:f4:6bd2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11B271EC0608;
        Mon, 18 Feb 2019 09:30:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550478615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GXeWNgmUXBhFqSLRAhHMCEYuHk1Oi5dqVrW+9hKXGAI=;
        b=MA8SHpY6pVMaUDL0JEg7JITnMz7U6LCXHjTlXn+3kctCHzQ8wJ+xLJ7fTd5iWbsNVay8oL
        mW1/opMsWLtq3BT9W6yFsYPE1sxreMGeO53pLs3qo6k8n2KKlFk4qnZ5vC5yMLiDh2ytFb
        pYLte4QLMO5sfIfDvpMVnLB8sjacoT8=
Date:   Mon, 18 Feb 2019 09:30:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild: Disable extra debugging info in .s output
Message-ID: <20190218083008.GB4265@zn.tnic>
References: <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
 <20190201103038.GE31854@zn.tnic>
 <20190201103648.GF31854@zn.tnic>
 <CAK7LNAQ4juLxrdMoPumQQ-96fMorf+wfAqkNxq1X1k=0i_R4vQ@mail.gmail.com>
 <20190201151139.GK31854@zn.tnic>
 <CAK7LNATVeX=6Mmn6A4+EGmZ9OSf=ePwbQWV1m1c=e=_LiebdNQ@mail.gmail.com>
 <20190202144227.GC27822@zn.tnic>
 <20190206104729.GC7314@zn.tnic>
 <CAK7LNAT+GhbEwP7v7NWd2kqW76qbXM1mtKhc21YXkp7BUJjzKQ@mail.gmail.com>
 <20190210123923.GA14948@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190210123923.GA14948@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 01:39:23PM +0100, Borislav Petkov wrote:
> Please attach the diff or send it from another mail server.

So you couldn't be bothered to send me an applicable version so I went
and typed it in by hand. Thanks. ;-\

Anyway, this variant works too, pls queue it.

Acked-by: Borislav Petkov <bp@suse.de>
Tested-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
