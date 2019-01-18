Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899B2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6029E2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfARMJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:09:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49330 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfARMJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:09:28 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gkSxd-0005jj-Jb; Fri, 18 Jan 2019 13:09:21 +0100
Date:   Fri, 18 Jan 2019 13:09:21 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu: Get rid of CONFIG_AS_FXSAVEQ
Message-ID: <20190118120921.742vgh23f6v5lrus@linutronix.de>
References: <20190117232408.GH5023@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117232408.GH5023@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-18 00:24:08 [+0100], Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> This was a "workaround" to probe for binutils which could generate
> FXSAVEQ, apparently gas with min version 2.16. In the meantime, minimal
> required gas version is 2.20 so all those workarounds for older binutils
> can be dropped.

indeed.

> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
