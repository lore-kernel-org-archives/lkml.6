Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63958C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7CA214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7CA214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeKOOnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 09:43:21 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47526 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeKOOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 09:43:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id CA951272C2;
        Wed, 14 Nov 2018 23:37:02 -0500 (EST)
Date:   Thu, 15 Nov 2018 15:37:02 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>
Subject: Re: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
In-Reply-To: <459ad559-99bd-0196-13f4-80440cd39671@gmail.com>
Message-ID: <alpine.LNX.2.21.1811151535310.19@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au> <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com> <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
 <fb617c67-089b-c4c0-2f47-28db41ffca6c@gmail.com> <alpine.LNX.2.21.1811131413210.362@nippy.intranet> <b824e485-796c-cbb6-9e50-504b03accd5d@gmail.com> <alpine.LNX.2.21.1811131700010.366@nippy.intranet> <0054c37f-ef34-e892-ff1d-02968ab529fa@gmail.com>
 <alpine.LNX.2.21.1811140905440.371@nippy.intranet> <73f75453-ce74-2c13-ba7c-f36f976d4ff7@gmail.com> <ab36d408-a05f-f220-1c2b-b88333f1c33b@gmail.com> <459ad559-99bd-0196-13f4-80440cd39671@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018, Michael Schmitz wrote:

> Hi Finn,
> 
> On 14/11/18 3:58 PM, Michael Schmitz wrote:
> > Hi Finn,
> > 
> > Am 14.11.2018 um 14:08 schrieb Michael Schmitz:
> > > > Can you also test tree fbf8405cd982 please?
> > > > 
> > > My tests were on c606b5cf902 in case it wasn't clear. I've now seen
> > > fbf8405cd982, one moment please ...
> > > 
> > > That one does appear to work - different versions of ARAnyM, and
> > > different userland versions though. I'll test that again with the setup
> > > that saw c606b5cf902 fail.
> > 
> > Still fails on that emulator / userland.
> > 
> Must be a quirk of ARAnyM 1.0.2 (or powerpc). With 0.9.15 on x86_64, it's
> fine.
> 

Could be a regression in aranym?

Maybe it's worth trying 0.9.15 on the powerpc host?

> I'm sufficiently convinced to try this on actual hardware now.
> 

Thanks!

-- 

> Cheers,
> 
> ??? Michael
> 
> 
> 
