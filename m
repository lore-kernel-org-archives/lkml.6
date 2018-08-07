Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C9EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D852219E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D852219E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbeHGJmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:42:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732805AbeHGJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:42:36 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fmwQp-0008Ml-Oe; Tue, 07 Aug 2018 09:29:27 +0200
Date:   Tue, 7 Aug 2018 09:29:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     hpa@zytor.com, david.laight@aculab.com,
        LKML <linux-kernel@vger.kernel.org>, jdelvare@suse.de,
        Ingo Molnar <mingo@kernel.org>,
        linux-tip-commits@vger.kernel.org, sedat.dilek@gmail.com
Subject: Re: [tip:x86/urgent] x86/irqflags: Provide a declaration for
 native_save_fl
In-Reply-To: <CAKwvOdmxaE7p-fgaaeCE17bbTf0iYmHQgWT2D6FM7U5fwUoN1Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808070924170.1788@nanos.tec.linutronix.de>
References: <20180803170550.164688-1-ndesaulniers@google.com> <tip-208cbb32558907f68b3b2a081ca2337ac3744794@git.kernel.org> <CAKwvOdmxaE7p-fgaaeCE17bbTf0iYmHQgWT2D6FM7U5fwUoN1Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2018, Nick Desaulniers wrote:
> On Sun, Aug 5, 2018 at 1:33 PM tip-bot for Nick Desaulniers
> <tipbot@zytor.com> wrote:
> > Cc: stable@vger.kernel.org
> 
> Not sure if this was going to be cleaned up in an automated way, but
> looks like this commit message drops the comment to stable as to how
> far back it should go:
> 
> # 4.17, 4.14, 4.9, 4.4

The Fixes tag is enough. If the upstream commit was backported, then the
tools of the stable folks will find it and know exactly how far it needs to
go back.

> also, there were tested by's reported:
> 
> Tested-by: David Laight <david.laight@acuab.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Which came in after I applied it....

Thanks,

	tglx
