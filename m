Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158BAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D462082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D462082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbeJ2Tbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:31:31 -0400
Received: from foss.arm.com ([217.140.101.70]:38650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729208AbeJ2Tbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:31:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1D8D165C;
        Mon, 29 Oct 2018 03:43:24 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 462BA3F6A8;
        Mon, 29 Oct 2018 03:43:23 -0700 (PDT)
Date:   Mon, 29 Oct 2018 10:43:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Prateek Patel <prpatel@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-tegra@vger.kernel.org, snikam@nvidia.com, vdumpa@nvidia.com,
        talho@nvidia.com, swarren@nvidia.com,
        Sri Krishna chowdary <schowdary@nvidia.com>
Subject: Re: [PATCH V2] kmemleak: Add config to select auto scan
Message-ID: <20181029104320.GC168424@arrakis.emea.arm.com>
References: <1540231723-7087-1-git-send-email-prpatel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540231723-7087-1-git-send-email-prpatel@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 11:38:43PM +0530, Prateek Patel wrote:
> From: Sri Krishna chowdary <schowdary@nvidia.com>
> 
> Kmemleak scan can be cpu intensive and can stall user tasks at times.
> To prevent this, add config DEBUG_KMEMLEAK_AUTO_SCAN to enable/disable
> auto scan on boot up.
> Also protect first_run with DEBUG_KMEMLEAK_AUTO_SCAN as this is meant
> for only first automatic scan.
> 
> Signed-off-by: Sri Krishna chowdary <schowdary@nvidia.com>
> Signed-off-by: Sachin Nikam <snikam@nvidia.com>
> Signed-off-by: Prateek <prpatel@nvidia.com>

Looks fine to me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
