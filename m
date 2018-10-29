Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D30D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D30D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeJ3G1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:27:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52780 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJ3G1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:27:06 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHFCy-0003fD-Pa; Mon, 29 Oct 2018 22:36:24 +0100
Date:   Mon, 29 Oct 2018 22:36:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     Andrei Vagin <avagin@gmail.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "criu@openvz.org" <criu@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
In-Reply-To: <87y3ag5tze.fsf@xmission.com>
Message-ID: <alpine.DEB.2.21.1810292234300.5984@nanos.tec.linutronix.de>
References: <20180919205037.9574-1-dima@arista.com>        <874lej6nny.fsf@xmission.com>        <20180924205119.GA14833@outlook.office365.com>        <874leezh8n.fsf@xmission.com>        <20180925014150.GA6302@outlook.office365.com>        <87zhw4rwiq.fsf@xmission.com>
        <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>        <87mus1ftb9.fsf@xmission.com> <20181021014121.GA23474@gmail.com>        <alpine.DEB.2.21.1810292026040.5984@nanos.tec.linutronix.de> <87y3ag5tze.fsf@xmission.com>
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

Eric,

On Mon, 29 Oct 2018, Eric W. Biederman wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> >
> > I'll try to find some time in the next weeks to look deeper into that, but
> > I can't promise anything before returning from LPC. Btw, LPC would be a
> > great opportunity to discuss that. Are you and the other name space wizards
> > there by any chance?
> 
> I will be and there are going to be both container and CRIU
> mini-conferences.  So there should at least some of us around.

So let's try to find a slot for a BOF or similar (there might be still
slots for the kernel summit available, i'll ask).

Thanks,

	tglx
