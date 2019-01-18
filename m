Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D53C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A305E20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfARQ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:26:29 -0500
Received: from foss.arm.com ([217.140.101.70]:33304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbfARQ00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:26:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D8CDEBD;
        Fri, 18 Jan 2019 08:26:26 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25633F557;
        Fri, 18 Jan 2019 08:26:24 -0800 (PST)
Date:   Fri, 18 Jan 2019 16:26:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        daniel.thompson@linaro.org, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        joel@joelfernandes.org
Subject: Re: [PATCH v8 11/26] efi: Let architectures decide the flags that
 should be saved/restored
Message-ID: <20190118162622.GJ118707@arrakis.emea.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-12-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546956464-48825-12-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 02:07:29PM +0000, Julien Thierry wrote:
> Currently, irqflags are saved before calling runtime services and
> checked for mismatch on return.
> 
> Provide a pair of overridable macros to save and restore (if needed) the
> state that need to be preserved on return from a runtime service.
> This allows to check for flags that are not necesarly related to
> irqflags.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
