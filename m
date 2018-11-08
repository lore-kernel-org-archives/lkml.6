Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A98C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E6020827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E6020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeKHTXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:23:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37184 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeKHTXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:23:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B83F580D;
        Thu,  8 Nov 2018 01:48:58 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9A653F5CF;
        Thu,  8 Nov 2018 01:48:57 -0800 (PST)
Date:   Thu, 8 Nov 2018 09:48:55 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/9] Regenerate arm64 defconfig for current kernel
Message-ID: <20181108094855.GC8433@e107155-lin>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 11:39:19PM +0100, Marc Gonzalez wrote:
> Hello ARM maintainers,
>
> v2: Improve commit message for a few patches
>
> The set of Kconfig options slowly changes with every kernel version.
> This patch series regenerates the arm64 defconfig for v4.20
> No functional change intended, except adding PINCTRL_MTK_MOORE to
> keep PINCTRL_MT7622.

Just to be sure, the end result is same as renormalising the defconfig
right ? Something like:

Commit c432c0880596 ("arm64: defconfig: renormalize based on recent additions")

Otherwise, others may try to do the same again.

--
Regards,
Sudeep
