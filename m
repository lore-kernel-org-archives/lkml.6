Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03791C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA015206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA015206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbeGSGtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:49:02 -0400
Received: from ozlabs.org ([203.11.71.1]:34375 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbeGSGtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:49:02 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41WNpb24Jbz9s21; Thu, 19 Jul 2018 16:07:35 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: dcb14337e0f2adb227c376e6327ef0c3e4cce6f9
In-Reply-To: <1524636895-27185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: cpufreq: powernv: Remove global pstate ramp-down timer in POWER9
Message-Id: <41WNpb24Jbz9s21@ozlabs.org>
Date:   Thu, 19 Jul 2018 16:07:35 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 06:14:55 UTC, Shilpasri G Bhat wrote:
> POWER9 doesnot support global pstate requests for the chip. So remove
> the timer logic which slowly ramps down the global pstate in P9
> platforms.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dcb14337e0f2adb227c376e6327ef0

cheers
