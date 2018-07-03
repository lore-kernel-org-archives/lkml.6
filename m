Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A29BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6782084D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6782084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932771AbeGCO4c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:56:32 -0400
Received: from foss.arm.com ([217.140.101.70]:50638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932238AbeGCO4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:56:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13F677A9;
        Tue,  3 Jul 2018 07:56:31 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05F553F5AD;
        Tue,  3 Jul 2018 07:56:29 -0700 (PDT)
Date:   Tue, 3 Jul 2018 15:56:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nikunj Kela <nkela@cisco.com>
Cc:     Will Deacon <will.deacon@arm.com>, xe-kernel@external.cisco.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: add support for 43bit physical address
Message-ID: <20180703145626.g6pb4bgnrle2p2qf@armageddon.cambridge.arm.com>
References: <20180702210451.16057-2-nkela@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702210451.16057-2-nkela@cisco.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:04:51PM -0700, Nikunj Kela wrote:
> This patch adds support for 43bit physical address. Additionally,
> this patch adds support for 27bit section size. This is useful in
> reducing kernel memory usage. One usecase is in kdump kernel.

Some numbers please.

-- 
Catalin
