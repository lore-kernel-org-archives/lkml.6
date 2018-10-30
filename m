Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E68C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718242082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718242082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeJ3SIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:08:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeJ3SIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:08:23 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R6sZFB0EaqVG; Tue, 30 Oct 2018 10:15:45 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0E200329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:e200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1110C1EC00EB;
        Tue, 30 Oct 2018 10:15:45 +0100 (CET)
Date:   Tue, 30 Oct 2018 10:15:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     lijiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181030091542.GD32102@zn.tnic>
References: <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
 <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
 <20181029095738.GB20101@zn.tnic>
 <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
 <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
 <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 01:09:00PM +0800, Dave Young wrote:
> It is not the content, I think it is a good catch from Boris, it would
> be good to document the exported things in somewhere eg.
> Documentation/kdump/vmcoreinfo.txt

Yes.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
