Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF1DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A342B20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A342B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeICOSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:18:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbeICOSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:18:53 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PV-yRIKdEzTZ; Mon,  3 Sep 2018 11:59:10 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF4100329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:4100:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 273C51EC03B1;
        Mon,  3 Sep 2018 11:59:09 +0200 (CEST)
Date:   Mon, 3 Sep 2018 12:00:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/11] kbuild: use 'include' directive to load
 auto.conf from top Makefile
Message-ID: <20180903100021.GD10249@zn.tnic>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
 <1532072796-7947-8-git-send-email-yamada.masahiro@socionext.com>
 <20180903093945.GA1195@zn.tnic>
 <CAK7LNAQOd-QA6E7189q4K-p_9ReRtE88UbhtuXS9600nOQTgaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAQOd-QA6E7189q4K-p_9ReRtE88UbhtuXS9600nOQTgaA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 06:54:12PM +0900, Masahiro Yamada wrote:
> You are right - I missed this usecase,
> but I still want to excuse "it is rare enough".

Isn't there a Makefile way to check file existence before including it?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
