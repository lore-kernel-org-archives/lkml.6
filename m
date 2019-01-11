Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D22BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BC92133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfAKUpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:45:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34665 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfAKUpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:45:42 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gi3gP-0004J6-Hp; Fri, 11 Jan 2019 21:45:37 +0100
Date:   Fri, 11 Jan 2019 21:45:37 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Vacek <neelx@redhat.com>
cc:     mingo@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [tip:x86/timers] x86/tsc: Make calibration refinement more
 robust
In-Reply-To: <CACjP9X-ax44OxjRmVPJaAu93ZJJySuuFO9mtsvSc6Lfpipzspw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901112143540.1661@nanos.tec.linutronix.de>
References: <1541437840-29293-1-git-send-email-neelx@redhat.com> <tip-a786ef152cdcfebc923a67f63c7815806eefcf81@git.kernel.org> <CACjP9X-ax44OxjRmVPJaAu93ZJJySuuFO9mtsvSc6Lfpipzspw@mail.gmail.com>
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

Daniel,

On Tue, 8 Jan 2019, Daniel Vacek wrote:

> I'm wondering, was x86/timers branch of tip tree merged to linus' tree
> for v5.0-rc1? Somehow I do not see this patch make it through...
> 
> Am I doing something wrong?

No. The branch was not sent to Linus during the merge window due to holiday
season induced oversight.

Thanks,

	tglx
