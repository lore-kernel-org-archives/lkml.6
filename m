Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB49FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D5E20825
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D5E20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeJ2Spn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:45:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49418 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbeJ2Spn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:45:43 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gjhy8i-Bn4XH; Mon, 29 Oct 2018 10:57:45 +0100 (CET)
Received: from zn.tnic (p200300EC2BC61800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:1800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C87D1EC0310;
        Mon, 29 Oct 2018 10:57:45 +0100 (CET)
Date:   Mon, 29 Oct 2018 10:57:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dyoung@redhat.com
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181029095738.GB20101@zn.tnic>
References: <20181027091007.GB1046@nazgul.tnic>
 <20181027093917.GA14493@MiWiFi-R3L-srv>
 <20181027101221.GC1046@nazgul.tnic>
 <20181027110858.GB14493@MiWiFi-R3L-srv>
 <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
 <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
 <20181027145151.GA7338@nazgul.tnic>
 <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
 <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 05:29:16PM +0800, lijiang wrote:
> Ok, i will change it to a local variable and export it.

Why do you have to export it at all?!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
