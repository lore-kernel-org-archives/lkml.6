Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40B0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53F22087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfANQMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:12:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36530 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfANQMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:12:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB4D580D;
        Mon, 14 Jan 2019 08:12:40 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC8973F5BD;
        Mon, 14 Jan 2019 08:12:38 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:12:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        daniel.thompson@linaro.org, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org
Subject: Re: [PATCH v8 07/26] arm64: ptrace: Provide definitions for PMR
 values
Message-ID: <20190114161235.GC84430@arrakis.emea.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-8-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546956464-48825-8-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 02:07:25PM +0000, Julien Thierry wrote:
> Introduce fixed values for PMR that are going to be used to mask and
> unmask interrupts by priority.
> 
> The current priority given to GIC interrupts is 0xa0, so clearing PMR's
> most significant bit is enough to mask interrupts.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
