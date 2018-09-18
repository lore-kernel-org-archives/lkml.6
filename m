Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493BEECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0013020858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0013020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeIROJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:09:21 -0400
Received: from foss.arm.com ([217.140.101.70]:41122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbeIROJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:09:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1022ED1;
        Tue, 18 Sep 2018 01:37:46 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C22053F5C0;
        Tue, 18 Sep 2018 01:37:46 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9482F1AE321F; Tue, 18 Sep 2018 09:38:05 +0100 (BST)
Date:   Tue, 18 Sep 2018 09:38:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robert Richter <robert.richter@cavium.com>
Cc:     Mian Yousaf Kaukab <ykaukab@suse.de>, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cwu@amperecomputing.com
Subject: Re: [PATCH RESEND 3/6] arm64: add sysfs vulnerability show for
 spectre v1
Message-ID: <20180918083805.GB14404@arm.com>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-4-ykaukab@suse.de>
 <20180917172206.GA3795@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917172206.GA3795@rric.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 07:22:07PM +0200, Robert Richter wrote:
> On 27.08.18 16:33:07, Mian Yousaf Kaukab wrote:
> > Hard-coded since patches are merged and there are no configuration
> > options.
> 
> Could you add a list of upstream patches to the description that are
> required to solve this? This would be a strict definition for the
> mitigation being enabled and makes it easier to check if backports are
> affected or not. A build-time check would be ideal (e.g. checking for
> certain macros).

Hmm, I don't grok what you're proposing here. Why do we need a build-time
check (and to check what?)

Confused,

Will
