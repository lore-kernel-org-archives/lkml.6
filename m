Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557C6C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC4A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbfAUOKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:10:53 -0500
Received: from foss.arm.com ([217.140.101.70]:34998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbfAUOKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:10:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3788EEBD;
        Mon, 21 Jan 2019 06:10:48 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1D4C3F5C1;
        Mon, 21 Jan 2019 06:10:46 -0800 (PST)
Date:   Mon, 21 Jan 2019 14:10:45 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] PM/EM: Document the Energy Model framework
Message-ID: <20190121141043.xkjy34bsofwcr4bn@queper01-lin>
References: <20190110110546.8101-2-quentin.perret@arm.com>
 <tip-a6a2333618df721d942d37564f8c4b28d1f6924b@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-a6a2333618df721d942d37564f8c4b28d1f6924b@git.kernel.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 Jan 2019 at 05:53:49 (-0800), tip-bot for Quentin Perret wrote:
> Commit-ID:  a6a2333618df721d942d37564f8c4b28d1f6924b
> Gitweb:     https://git.kernel.org/tip/a6a2333618df721d942d37564f8c4b28d1f6924b
> Author:     Quentin Perret <quentin.perret@arm.com>
> AuthorDate: Thu, 10 Jan 2019 11:05:45 +0000
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon, 21 Jan 2019 14:40:28 +0100
> 
> PM/EM: Document the Energy Model framework
> 
> Introduce a documentation file summarizing the key design points and
> APIs of the newly introduced Energy Model framework.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: corbet@lwn.net
> Cc: dietmar.eggemann@arm.com
> Cc: morten.rasmussen@arm.com
> Cc: patrick.bellasi@arm.com
> Cc: qais.yousef@arm.com
> Cc: rjw@rjwysocki.net
> Link: https://lkml.kernel.org/r/20190110110546.8101-2-quentin.perret@arm.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

Argh, I sent a v2 addressing Juri's and Rafael's comments on the list
just today [1]. Should I send a diff patch later ? Or is it still
possible to pick up the v2 ?

Thanks,
Quentin

[1] https://lore.kernel.org/lkml/20190121111724.18234-1-quentin.perret@arm.com/
