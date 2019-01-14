Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1854AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C5D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfANUtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:49:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfANUtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:49:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 570302D7E7;
        Mon, 14 Jan 2019 20:49:15 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43D9760CCF;
        Mon, 14 Jan 2019 20:49:15 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 231593F7CB;
        Mon, 14 Jan 2019 20:49:15 +0000 (UTC)
Date:   Mon, 14 Jan 2019 15:49:14 -0500 (EST)
From:   Dave Anderson <anderson@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Message-ID: <1862896935.69778880.1547498954956.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190114203500.GU2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com> <20190114192144.GQ2773@zn.tnic> <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com> <20190114195940.GS2773@zn.tnic> <244986363.69770015.1547496453312.JavaMail.zimbra@redhat.com> <20190114201812.GT2773@zn.tnic> <221183717.69773903.1547497592624.JavaMail.zimbra@redhat.com> <20190114203500.GU2773@zn.tnic>
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.17.201, 10.4.195.25]
Thread-Topic: kdump: add the vmcoreinfo documentation
Thread-Index: 1w3RLd9A9qEHPbJGj05Nd5Aij519rA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 14 Jan 2019 20:49:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> On Mon, Jan 14, 2019 at 03:26:32PM -0500, Dave Anderson wrote:
> > No.  It needs *both* the vmlinux file and the vmcore file in order to read
> > kernel
> > virtual memory, so just having a kernel virtual address is insufficient.
> > 
> > So it's a chicken-and-egg situation.  This particular --osrelease option is used
> > to determine *what* vmlinux file would be required for an actual crash analysis
> > session.
> 
> Ok, that makes sense. I could've used that explanation when reviewing
> the documentation. Do you mind skimming through this:
> 
> https://lkml.kernel.org/r/20190111145650.GG4729@zn.tnic
> 
> in case we've missed explaining relevant usage - like that above - of
> some of the vmcoreinfo members?

Yeah, I've been watching the thread, and the document looks fine to me.
It's just that when I saw the discussion of this one being removed that
I felt the need to respond...  ;-)

Dave
