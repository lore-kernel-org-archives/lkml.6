Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ACFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CEF20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rDjP3gJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfAQNWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:22:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48734 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfAQNWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DkHpwPUi2K8KLiBMzJ7UNF+DC//E0zU2Ao0R/H52uDU=; b=rDjP3gJFlCgLvwC3eBantO51y
        7KgH1OlVwLWaJCxp+P8Zhp4cWWbNF1frTAEki237yiApjS7vG36hJSicIiJyZkYMnNrc4OWDhHdjF
        AR5h/gvbAzvogtpEjJ2KzlWhajzDeK3sx0RAL3eU3SmFpp4awnzN5lx6Cc5O710Iyxf+guVMXkNwr
        HfPZRWFk6CMBM0wuMcBfJElRyndfEIT0cAsaaJKg+cKvu1v8DFHKGRRWDRUCyx99nw1A64fyRRSb8
        Puw2gi38jxqbnZF1XWBQsLvG/NEUaUsUS+xLFQjalysGanTQGvCiJTtV7X6NotjZYkS6TjutpdiMY
        2052e2Dbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk7br-0001cf-Mg; Thu, 17 Jan 2019 13:21:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7073C2026562B; Thu, 17 Jan 2019 14:21:26 +0100 (CET)
Date:   Thu, 17 Jan 2019 14:21:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com
Subject: Re: [PATCH 00/17] Merge text_poke fixes and executable lockdowns
Message-ID: <20190117132126.GI10486@hirez.programming.kicks-ass.net>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



1-7,11-12

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
