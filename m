Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C85AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A8420B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfBFK1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:27:13 -0500
Received: from foss.arm.com ([217.140.101.70]:50970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbfBFK1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:27:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A705080D;
        Wed,  6 Feb 2019 02:27:12 -0800 (PST)
Received: from C02TF0J2HF1T.cambridge.arm.com (C02TF0J2HF1T.cambridge.arm.com [10.1.30.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75BF73F719;
        Wed,  6 Feb 2019 02:27:10 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:27:07 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com, will.deacon@arm.com, mark.rutland@arm.com
Subject: Re: [PATCH v10 00/25] arm64: provide pseudo NMI with GICv3
Message-ID: <20190206102706.GA92291@C02TF0J2HF1T.cambridge.arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On Thu, Jan 31, 2019 at 02:58:38PM +0000, Julien Thierry wrote:
> This series is a continuation of the work started by Daniel [1]. The goal
> is to use GICv3 interrupt priorities to simulate an NMI.
> 
> The patches depend on the core API for NMIs patches [2]. Both series can
> be found on this branch:
> git clone http://linux-arm.org/linux-jt.git -b v5.0-pseudo-nmi

I queued these patches in the arm64 for-next/core, on top of Marc's
generic-nmi branch:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms irq/generic-nmi

I'll push the changes out later today, once my tests finished.

Thanks for pushing this series through.

-- 
Catalin
