Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A4C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781A02479B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781A02479B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934310AbeFVTHt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:07:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42635 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754488AbeFVTHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:07:48 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWRP9-0001ru-4v; Fri, 22 Jun 2018 21:07:31 +0200
Date:   Fri, 22 Jun 2018 21:07:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 6/7] x86/vdso: Introduce CPU number helper functions
In-Reply-To: <C9BB696F3A938947B10DCAD29FAB8FFA66BDB8A6@CRSMSX101.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1806222106550.1589@nanos.tec.linutronix.de>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com> <1529536506-26237-7-git-send-email-chang.seok.bae@intel.com>,<alpine.DEB.2.21.1806221644090.2402@nanos.tec.linutronix.de>
 <C9BB696F3A938947B10DCAD29FAB8FFA66BDB8A6@CRSMSX101.amr.corp.intel.com>
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

On Fri, 22 Jun 2018, Bae, Chang Seok wrote:
> On Friday, 22 Jun 2018, Thomas Gleixner wrote: 
> > Or some other sensible function name.
> 
> Now, for these helper function renaming, I would like to check it from Andy.

Sure I just made some up. Find some which are descriptive enough,

Thanks,

	tglx
