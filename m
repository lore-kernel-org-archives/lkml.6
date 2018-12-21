Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD70BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE9D218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbeLUQjF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:39:05 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:35071 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLUQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:39:05 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gaNp1-00058r-Lv; Fri, 21 Dec 2018 17:38:47 +0100
Date:   Fri, 21 Dec 2018 17:38:47 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kvm ML <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3I/bcOhPw==?= <rkrcmar@redhat.com>,
        Rik van Riel <riel@surriel.com>, x86-ml <x86@kernel.org>
Subject: Re: [PATCH v4.9 STABLE] x86/fpu: Disable bottom halves while loading
 FPU registers
Message-ID: <20181221163847.u43h4vun4jibqnyj@linutronix.de>
References: <20181204103726.750894136@linuxfoundation.org>
 <20181204103731.697870447@linuxfoundation.org>
 <5C07FC30.43601034@users.sourceforge.net>
 <20181205190020.GO29510@zn.tnic>
 <20181206105407.GH19891@kroah.com>
 <20181221162338.dir7z3c76kucm6uh@linutronix.de>
 <20181221162905.GB7797@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181221162905.GB7797@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-21 17:29:05 [+0100], Greg Kroah-Hartman wrote:
> What is the git commit id of this patch upstream?

commit 68239654acafe6aad5a3c1dc7237e60accfebc03 upstream.

I'm sorry. I cherry picked the original commit, resolved the conflict
and forgot about the original commit id…

> thanks,
> 
> greg k-h

Sebastian
