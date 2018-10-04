Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E20C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA942082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA942082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJDRrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:47:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36914 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbeJDRrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:47:33 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9iLxEzf4aA6l; Thu,  4 Oct 2018 12:54:49 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68F8B1EC02D1;
        Thu,  4 Oct 2018 12:54:49 +0200 (CEST)
Date:   Thu, 4 Oct 2018 12:54:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        x86@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: x86/mm: Found insecure W+X mapping at address (ptrval)/0xc00a0000
Message-ID: <20181004105443.GH1864@zn.tnic>
References: <0922cc1b-ed51-06e9-df81-57fd5aa8e7de@molgen.mpg.de>
 <alpine.DEB.2.21.1809210045220.1434@nanos.tec.linutronix.de>
 <c8da5778-3957-2fab-69ea-42f872a5e396@molgen.mpg.de>
 <alpine.DEB.2.21.1809281653270.2004@nanos.tec.linutronix.de>
 <20181003212255.GB28361@zn.tnic>
 <20181004080321.GA3630@8bytes.org>
 <20181004081429.GB1864@zn.tnic>
 <6cbb9135-7e89-748f-1d55-ac105a9f8091@molgen.mpg.de>
 <20181004084946.GD1864@zn.tnic>
 <bdc5d224-91d6-eeee-c334-4b76efb56cac@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdc5d224-91d6-eeee-c334-4b76efb56cac@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 10:59:18AM +0200, Paul Menzel wrote:
> I meant just the test you did.

https://lkml.kernel.org/r/20181003212255.GB28361@zn.tnic

> The SSD is also used in the Lenovo X60 and T60, which are
> 32-bit systems.

And what exactly is the problem when you access it on a 64-bit OS?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
