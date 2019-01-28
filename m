Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CAAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D6E21848
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfA1QAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:00:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42510 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730270AbfA1QAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:41 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1go9Kt-0004b7-BC; Mon, 28 Jan 2019 17:00:35 +0100
Date:   Mon, 28 Jan 2019 17:00:34 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Vacek <neelx@redhat.com>
cc:     mingo@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [tip:x86/timers] x86/tsc: Make calibration refinement more
 robust
In-Reply-To: <CACjP9X_pwYyBvh6Zu0R1sbkzLoXJ7U2psFfK4wFeSz614_hvNA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901281700110.1582@nanos.tec.linutronix.de>
References: <1541437840-29293-1-git-send-email-neelx@redhat.com> <tip-a786ef152cdcfebc923a67f63c7815806eefcf81@git.kernel.org> <CACjP9X-ax44OxjRmVPJaAu93ZJJySuuFO9mtsvSc6Lfpipzspw@mail.gmail.com> <alpine.DEB.2.21.1901112143540.1661@nanos.tec.linutronix.de>
 <CACjP9X_pwYyBvh6Zu0R1sbkzLoXJ7U2psFfK4wFeSz614_hvNA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019, Daniel Vacek wrote:

> On Fri, Jan 11, 2019 at 10:03 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > No. The branch was not sent to Linus during the merge window due to holiday
> > season induced oversight.
> 
> So does it wait for the next merge window now or is it still going to
> be sent? This is actually worth stable branches. I've confirmations
> from Hitachi and Nec that this really helps latest Skylake-X systems
> boot reliably.

It's in 5.0-rc4 now.

Thanks,

	tglx
