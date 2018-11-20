Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4598C32788
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D6220831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D6220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeKUB4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:56:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:44720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbeKUB4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:56:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02A49AD93;
        Tue, 20 Nov 2018 15:27:03 +0000 (UTC)
Date:   Tue, 20 Nov 2018 16:27:01 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Arjan van de Ven <arjan@linux.intel.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Re: STIBP by default.. Revert?
In-Reply-To: <51127fd4-5dcc-b2b9-4873-72098d2a77d9@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1811201623300.21108@cbobk.fhfr.pm>
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com> <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm> <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com> <51127fd4-5dcc-b2b9-4873-72098d2a77d9@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Arjan van de Ven wrote:

> In the documentation, AMD officially recommends against this by default, 
> and I can speak for Intel that our position is that as well: this really 
> must not be on by default.

Thanks for pointing to the AMD doc, it's indeed clearly stated there.

Is there any chance this could perhaps be added to Intel documentation as 
well, so that we avoid cases like this in the future?

The revision 3.0 of Intel doc from may 2018 [1] I am always looking into 
doesn't say anything discouraging about STIBP to me.

[1] https://software.intel.com/security-software-guidance/api-app/sites/default/files/336996-Speculative-Execution-Side-Channel-Mitigations.pdf?_gclid=5b78f4d130faf8.22277271-5b78f4d130fb70.17467890&_utm_source=xakep&_utm_campaign=mention177777&_utm_medium=inline&_utm_content=lnk223716354570

Thanks,

-- 
Jiri Kosina
SUSE Labs

