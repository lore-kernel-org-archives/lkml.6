Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44ACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFC720872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfAKIhN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:37:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfAKIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:37:12 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghsJJ-0004Am-OA; Fri, 11 Jan 2019 09:37:01 +0100
Date:   Fri, 11 Jan 2019 09:37:01 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Tang, Haoyu" <haoyu.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu/init: Add __setup() functions back to fpu/init.c
Message-ID: <20190111083701.qd6a6aanibmelo26@linutronix.de>
References: <1547174753-31180-1-git-send-email-haoyu.tang@intel.com>
 <20190111081150.lpgwjpwx24kdl7yb@linutronix.de>
 <62C1CF205A679448ACBEE7C5EDA2DE3716365B2A@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <62C1CF205A679448ACBEE7C5EDA2DE3716365B2A@SHSMSX103.ccr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-11 08:30:13 [+0000], Tang, Haoyu wrote:
> It doesn't consistent with document: https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html 
> I met an init which didn't accept unknown arguments.

Why are those a problem and nokaslr / nospectre_v2 / … are not?

> Haoyu

Sebastian
