Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16609C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99622081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99622081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeKJCqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:46:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41432 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeKJCqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:46:04 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C2YtbZ6Ya40I; Fri,  9 Nov 2018 18:04:37 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7381C1EC01A8;
        Fri,  9 Nov 2018 18:04:37 +0100 (CET)
Date:   Fri, 9 Nov 2018 18:04:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tigran Aivazian <aivazian.tigran@gmail.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, shli@kernel.org,
        thomas.lendacky@amd.com
Subject: Re: [PATCH 3/4] x86/microcode: Add SPDX license identifiers
Message-ID: <20181109170429.GD21243@zn.tnic>
References: <20181109150431.14147-1-bp@alien8.de>
 <20181109150431.14147-4-bp@alien8.de>
 <CAK+_RLmV2rm=7zQ6BeJxUg0x1K7Kwv7AfHXmJ=YEV6xQuufbVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK+_RLmV2rm=7zQ6BeJxUg0x1K7Kwv7AfHXmJ=YEV6xQuufbVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 03:34:16PM +0000, Tigran Aivazian wrote:
> Ok, that's fine. I noticed these things when changing BFS code a
> couple of days ago and wondered what they were --- now I know :)

Thx.

For more info, see

https://www.kernel.org/doc/html/latest/process/license-rules.html

Doc is pretty nice and should explain everything.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
