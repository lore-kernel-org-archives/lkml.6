Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9141EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E532148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E532148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeIXOoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:44:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:54760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727290AbeIXOoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:44:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E86EEADC3;
        Mon, 24 Sep 2018 08:43:06 +0000 (UTC)
Date:   Mon, 24 Sep 2018 10:43:05 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Peter Zijlstra <peterz@infradead.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 0/3] Harden spectrev2 userspace-userspace protection
In-Reply-To: <alpine.DEB.2.21.1809221527140.1391@nanos.tec.linutronix.de>
Message-ID: <nycvar.YFH.7.76.1809241032000.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144EA58@ORSMSX107.amr.corp.intel.com> <20180919154828.GJ24124@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1809220936520.15880@cbobk.fhfr.pm> <alpine.DEB.2.21.1809221022250.1391@nanos.tec.linutronix.de> <20180922101844.GF24124@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1809221219270.1391@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809221527140.1391@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2018, Thomas Gleixner wrote:

> Lunch and coffee indeed made brain work better. The simple solution was way
> too obvious.

Ah, cool, I like it a lot.

Do you want me to fold this into v7, or are you on it already?

Thanks,

-- 
Jiri Kosina
SUSE Labs

