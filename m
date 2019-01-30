Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A8AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076B02082E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfA3AOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 19:14:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45454 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfA3AOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 19:14:32 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1godWI-0000yv-UG; Wed, 30 Jan 2019 01:14:23 +0100
Date:   Wed, 30 Jan 2019 01:14:22 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Gustavo A. R. Silva" <garsilva@embeddedor.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/syscalls: Mark expected switch fall-throughs
In-Reply-To: <20190129235659.GA8556@embeddedor>
Message-ID: <alpine.DEB.2.21.1901300113130.1950@nanos.tec.linutronix.de>
References: <20190129235659.GA8556@embeddedor>
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

On Tue, 29 Jan 2019, Gustavo A. R. Silva wrote:

> In preparation to enable -Wimplicit-fallthrough by default, mark
> switch-case statements where fall-through is intentional, explicitly in
> order to fix a bunch of -Wimplicit-fallthrough warnings.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3.

Was used for what? For writing the patch or for finding the places?

Please be precise in your changelog statements. Te above doesn't make sense
for the casual reader.

Thanks,

	tglx
