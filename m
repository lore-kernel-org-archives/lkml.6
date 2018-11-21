Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F2EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9B421479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9B421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeKUX4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:56:16 -0500
Received: from twin.jikos.cz ([91.219.245.39]:51636 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeKUX4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:56:15 -0500
Received: from twin.jikos.cz (jikos@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id wALDLG8K012358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 21 Nov 2018 14:21:17 +0100
Received: from localhost (jikos@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) with ESMTP id wALDLFVX012355;
        Wed, 21 Nov 2018 14:21:15 +0100
X-Authentication-Warning: twin.jikos.cz: jikos owned process doing -bs
Date:   Wed, 21 Nov 2018 14:21:15 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        WoodhouseDavid <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        SchauflerCasey <casey.schaufler@intel.com>
Subject: Re: [PATCH 4.19 041/361] x86/speculation: Enable cross-hyperthread
 spectre v2 STIBP mitigation
In-Reply-To: <20181111221625.598298393@linuxfoundation.org>
Message-ID: <alpine.LRH.2.00.1811211420130.18805@gjva.wvxbf.pm>
References: <20181111221619.915519183@linuxfoundation.org> <20181111221625.598298393@linuxfoundation.org>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018, Greg Kroah-Hartman wrote:

> 4.19-stable review patch.  If anyone has any objections, please let me know.

Greg, please drop this patch from all -stable for now. Version that 
wouldn't have such performance impact is being worked on.

-- 
Jiri Kosina
SUSE Labs
