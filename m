Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05D2C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCED21479
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCED21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeJDOkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:40:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57034 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbeJDOkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:40:36 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 52KyIdrSTFOr; Thu,  4 Oct 2018 09:48:39 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61E4B1EC02D1;
        Thu,  4 Oct 2018 09:48:39 +0200 (CEST)
Date:   Thu, 4 Oct 2018 09:48:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        x86@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: x86/mm: Found insecure W+X mapping at address (ptrval)/0xc00a0000
Message-ID: <20181004074827.GA1864@zn.tnic>
References: <e75fa739-4bcc-dc30-2606-25d2539d2653@molgen.mpg.de>
 <alpine.DEB.2.21.1809191004580.1468@nanos.tec.linutronix.de>
 <0922cc1b-ed51-06e9-df81-57fd5aa8e7de@molgen.mpg.de>
 <alpine.DEB.2.21.1809210045220.1434@nanos.tec.linutronix.de>
 <c8da5778-3957-2fab-69ea-42f872a5e396@molgen.mpg.de>
 <alpine.DEB.2.21.1809281653270.2004@nanos.tec.linutronix.de>
 <20181003212255.GB28361@zn.tnic>
 <18bf13a4-2853-358e-594f-27533193757c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18bf13a4-2853-358e-594f-27533193757c@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 05:11:17AM +0200, Paul Menzel wrote:
> Thank you for looking into this. On what board are you able to reproduce
> this? Do you build for 32-bit or 64-bit?

32-bit partition on an AMD F14h laptop.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
