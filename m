Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA04DC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8350D2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfAaPUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:20:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46470 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfAaPUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:20:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E940080D;
        Thu, 31 Jan 2019 07:20:04 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07F6F3F557;
        Thu, 31 Jan 2019 07:20:03 -0800 (PST)
Subject: Re: [PATCH v6 0/4] Provide core API for NMIs
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org
References: <1548946441-38546-1-git-send-email-julien.thierry@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <925aa373-dcee-3e83-6976-b73425c10289@arm.com>
Date:   Thu, 31 Jan 2019 15:20:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548946441-38546-1-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/2019 14:53, Julien Thierry wrote:
> Hi,
> 
> This patch series provides a way for irqchips to define some IRQs as NMIs.
> 
> Updating this series as it is needed for the arm64 pseudo-NMI which we
> are considering to merge (I'll post a new version shortly).
> 

Latest version of the arm64 pseudo-NMI can be found here:

https://lkml.org/lkml/2019/1/31/535

Cheers,

-- 
Julien Thierry
