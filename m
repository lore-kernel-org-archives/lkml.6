Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7858EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4900720869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4900720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeKFX6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:58:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388284AbeKFX6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:58:30 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RsZiUEipH-CM; Tue,  6 Nov 2018 15:32:59 +0100 (CET)
Received: from zn.tnic (p200300EC2BD1C800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:c800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8613A1EC02A3;
        Tue,  6 Nov 2018 15:32:59 +0100 (CET)
Date:   Tue, 6 Nov 2018 15:32:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        qiuxu.zhuo@intel.com, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: skx_edac: add ACPI dependency
Message-ID: <20181106143253.GH13712@zn.tnic>
References: <20181102153232.1450251-1-arnd@arndb.de>
 <20181102161013.GG14602@zn.tnic>
 <20181102173959.GA27709@agluck-desk>
 <20181102234255.GE26770@zn.tnic>
 <CAK8P3a2yE8FGvpN0P8hXnyCpS4h-ZOHeYhSCjE+Ov=7s1TB=5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2yE8FGvpN0P8hXnyCpS4h-ZOHeYhSCjE+Ov=7s1TB=5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 02:44:42PM +0100, Arnd Bergmann wrote:
> No, it was unintentional, the 'if ACPI' can be dropped when we add
> 'depends on ACPI'.

So I have one fix already which takes care of non-sensical configs. If
you or Tony wanna make it prettier, feel free to test it thoroughly and
send me a patch ontop of

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=for-next

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
