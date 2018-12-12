Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C59C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCD220839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCD220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeLLKOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:14:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37324 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbeLLKOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:14:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E020EBD;
        Wed, 12 Dec 2018 02:14:53 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A13263F575;
        Wed, 12 Dec 2018 02:14:51 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:14:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Prateek Patel <prpatel@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-tegra@vger.kernel.org, snikam@nvidia.com, vdumpa@nvidia.com,
        talho@nvidia.com, swarren@nvidia.com, treding@nvidia.com
Subject: Re: [PATCH V2] kmemleak: Add config to select auto scan
Message-ID: <20181212101448.GA65138@arrakis.emea.arm.com>
References: <1540231723-7087-1-git-send-email-prpatel@nvidia.com>
 <20181029104320.GC168424@arrakis.emea.arm.com>
 <a51a7d4b-6366-ea10-f220-992525ec1d42@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a51a7d4b-6366-ea10-f220-992525ec1d42@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:14:29PM +0530, Prateek Patel wrote:
> On 10/29/2018 4:13 PM, Catalin Marinas wrote:
> > On Mon, Oct 22, 2018 at 11:38:43PM +0530, Prateek Patel wrote:
> > > From: Sri Krishna chowdary <schowdary@nvidia.com>
> > > 
> > > Kmemleak scan can be cpu intensive and can stall user tasks at times.
> > > To prevent this, add config DEBUG_KMEMLEAK_AUTO_SCAN to enable/disable
> > > auto scan on boot up.
> > > Also protect first_run with DEBUG_KMEMLEAK_AUTO_SCAN as this is meant
> > > for only first automatic scan.
> > > 
> > > Signed-off-by: Sri Krishna chowdary <schowdary@nvidia.com>
> > > Signed-off-by: Sachin Nikam <snikam@nvidia.com>
> > > Signed-off-by: Prateek <prpatel@nvidia.com>
> > Looks fine to me.
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Can you mark this patch as acknowledged so that it can be picked up by the
> maintainer.

I thought Reviewed-by was sufficient. Anyway:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
