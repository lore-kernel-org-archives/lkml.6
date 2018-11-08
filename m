Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C59DC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC0920827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC0920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeKHTK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:10:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37056 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeKHTK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:10:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F16F580D;
        Thu,  8 Nov 2018 01:36:20 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E339C3F5CF;
        Thu,  8 Nov 2018 01:36:19 -0800 (PST)
Date:   Thu, 8 Nov 2018 09:36:17 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
Message-ID: <20181108093617.GB8433@e107155-lin>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
 <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 11:39:42PM +0100, Marc Gonzalez wrote:
> Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
> dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64.
>

Looks good,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

But I left it intentionally to avoid churn assuming it will go away when
ARM SoC team runs savedefconfig and sync the defconfig.

--
Regards,
Sudeep
