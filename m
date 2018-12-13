Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974B9C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6144920849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6144920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbeLMN4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:56:15 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34534 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbeLMN4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:56:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EC3C80D;
        Thu, 13 Dec 2018 05:56:14 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A46AA3F575;
        Thu, 13 Dec 2018 05:56:12 -0800 (PST)
Date:   Thu, 13 Dec 2018 13:56:11 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org
Cc:     linux-tip-commits@vger.kernel.org, tglx@linutronix.de,
        hpa@zytor.com, torvalds@linux-foundation.org, efault@gmx.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [tip:sched/core] sched/toplogy: Introduce the
 'sched_energy_present' static key
Message-ID: <20181213135608.gf4gysytsvvxflse@queper01-lin>
References: <20181203095628.11858-10-quentin.perret@arm.com>
 <tip-1f74de8798c93ce14801cc4e772603e51c841c33@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-1f74de8798c93ce14801cc4e772603e51c841c33@git.kernel.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 Dec 2018 at 07:36:40 (-0800), tip-bot for Quentin Perret wrote:
> Commit-ID:  1f74de8798c93ce14801cc4e772603e51c841c33
> Gitweb:     https://git.kernel.org/tip/1f74de8798c93ce14801cc4e772603e51c841c33
> Author:     Quentin Perret <quentin.perret@arm.com>
> AuthorDate: Mon, 3 Dec 2018 09:56:22 +0000
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 11 Dec 2018 15:17:01 +0100
> 
> sched/toplogy: Introduce the 'sched_energy_present' static key

Argh, this one needs a quick fix too :-(

s/toplogy/topology
