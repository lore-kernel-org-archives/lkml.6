Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F847C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C561820651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pVu2t3Ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfAOKHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:07:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37934 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfAOKHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:07:07 -0500
Received: from zn.tnic (p200300EC2BCBB4000C4BA7EB962C71EB.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b400:c4b:a7eb:962c:71eb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6C491EC0B69;
        Tue, 15 Jan 2019 11:07:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547546826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AThfrLqsUq2xn4tIaET9wGhm1B/0VM5AetYRBejovyA=;
        b=pVu2t3Ji6sZauXJsLQj4y8reYFyxlrbzy5TEDCDlCyM/NQenGVy/zadPM9v5onqXg4EjsZ
        ix3q8W5hhkOuZS0MUkALle2Nl+/JlbkWXvVRSe9RFr1TSYstuQWVdCvxbG17HSnpqlRuvF
        EjsQRl/ZJ5xYQnSqa4GM1+Z9xi925oo=
Date:   Tue, 15 Jan 2019 11:06:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Anderson <anderson@redhat.com>
Cc:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Message-ID: <20190115100659.GB6596@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190114192144.GQ2773@zn.tnic>
 <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com>
 <20190114195940.GS2773@zn.tnic>
 <244986363.69770015.1547496453312.JavaMail.zimbra@redhat.com>
 <20190114201812.GT2773@zn.tnic>
 <221183717.69773903.1547497592624.JavaMail.zimbra@redhat.com>
 <20190114203500.GU2773@zn.tnic>
 <1862896935.69778880.1547498954956.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1862896935.69778880.1547498954956.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 03:49:14PM -0500, Dave Anderson wrote:
> Yeah, I've been watching the thread, and the document looks fine to me.
> It's just that when I saw the discussion of this one being removed that
> I felt the need to respond...  ;-)

Good. :-)

Ok, I've amended the init_uts_ns.name.release description with the
additional important info.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
