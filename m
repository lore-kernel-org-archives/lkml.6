Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70B4C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8922084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfALVgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:36:03 -0500
Received: from manchmal.in-ulm.de ([217.10.9.201]:45122 "EHLO
        manchmal.in-ulm.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfALVgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 16:36:02 -0500
Date:   Sat, 12 Jan 2019 22:35:59 +0100
From:   Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Breno Leitao <leitao@debian.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4.20 41/65] Revert "powerpc/tm: Unset MSR[TS] if not
 recheckpointing"
Message-ID: <1547328527@msgid.manchmal.in-ulm.de>
References: <20190111131055.331350141@linuxfoundation.org>
 <20190111131102.136630542@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111131102.136630542@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote...

> 4.20-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> This reverts commit d412deb85a4aada382352a8202beb7af8921cd53 which is
> commit 6f5b9f018f4c7686fd944d920209d1382d320e4e upstream.
>
> It breaks the powerpc build, so drop it from the tree until a fix goes
> upstream.

Is this necessary on 4.20? The build failures I reported were on 4.19
only. The 4.20.2-rc1 kernel for my Powermac G5 builds with and without
that patch, both boot fine, no visible differences. Again however, Breno
is authoritative here.

Aside, I also checked 4.19.15-rc1, builds and runs without any
noticeable problems.

    Christoph
