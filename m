Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535FCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253DF2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfA2Wbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:31:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45337 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfA2Wbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:31:35 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gobug-0007yb-UQ; Tue, 29 Jan 2019 23:31:27 +0100
Date:   Tue, 29 Jan 2019 23:31:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     =?ISO-8859-15?Q?Jan_H=2E_Sch=F6nherr?= <jan@schnhrr.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        it+linux-x86@molgen.mpg.de
Subject: Re: [PATCH 0/2] Fix TSC issues on (some) AMD Ryzen based systems
In-Reply-To: <986788f4-2a89-78a9-edee-3754dadba512@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1901292329320.1950@nanos.tec.linutronix.de>
References: <20190129102329.27610-1-jan@schnhrr.de> <74929a77-6a21-d13e-9a65-5a0753009ddf@molgen.mpg.de> <986788f4-2a89-78a9-edee-3754dadba512@molgen.mpg.de>
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

Paul,

On Tue, 29 Jan 2019, Paul Menzel wrote:
> 
> Please do not forget to tag both patches for the stable releases
> by adding the tag.
> 
> > CC: stable@vger.kernel.org

That's not the way it works. The TSC one might go to stable eventually, but
the second one is a hack and surely goes nowhere in the current
form. Routing patches to stable is not a matter of works for me.

Thanks,

	tglx
