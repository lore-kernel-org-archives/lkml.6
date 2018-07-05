Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601FDC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C691240FC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C691240FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754598AbeGEQnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:43:42 -0400
Received: from foss.arm.com ([217.140.101.70]:53806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753814AbeGEQng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:43:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A65B47A9;
        Thu,  5 Jul 2018 09:43:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7FBA3F5BA;
        Thu,  5 Jul 2018 09:43:32 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:43:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        will.deacon@arm.com
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linuxdrivers@attotech.com,
        mingo@kernel.org, mingo@redhat.com, parri.andrea@gmail.com,
        peter@hurleysoftware.com, tglx@linutronix.de
Subject: Re: [PATCHv3 00/12] atomics: generate atomic headers / instrument
 arm64
Message-ID: <20180705164327.7ic2tyjd24wrmntc@lakrids.cambridge.arm.com>
References: <20180705164025.10015-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705164025.10015-1-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:40:13PM +0100, Mark Rutland wrote:
> This series scripts the generation of the various atomic headers, to ensure
> that the various atomic APIs remain consistent, reducing the risk of human
> error, and simplifying future rework. This fleshes out the instrumented atomics
> such that arm64 can be migrated over to them.

Sorry for this duplicate cover; I'd messed up my git-send-email
invocation such that this didn't go to LAKML.

Mark.
