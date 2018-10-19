Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B78ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC5E20836
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC5E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeJSScl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:32:41 -0400
Received: from foss.arm.com ([217.140.101.70]:50068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeJSScl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:32:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0490480D;
        Fri, 19 Oct 2018 03:27:14 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C83F23F71D;
        Fri, 19 Oct 2018 03:27:13 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CF0D21AE06EF; Fri, 19 Oct 2018 11:27:16 +0100 (BST)
Date:   Fri, 19 Oct 2018 11:27:16 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>, mingo@kernel.org
Cc:     arnd@arndb.de, aryabinin@virtuozzo.com, boqun.feng@gmail.com,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        linuxdrivers@attotech.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3 0/6] atomics: generate atomic headers / instrument arm64
Message-ID: <20181019102715.GA14246@arm.com>
References: <20180904104830.2975-1-mark.rutland@arm.com>
 <20181008171523.rw34hyaqap2yb3py@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008171523.rw34hyaqap2yb3py@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Mon, Oct 08, 2018 at 06:15:24PM +0100, Mark Rutland wrote:
> On Tue, Sep 04, 2018 at 11:48:24AM +0100, Mark Rutland wrote:
> > As previously requested, this is a (trivial) rebase of the remaining generated
> > atomic patches atop of v4.19-rc2, avoiding any potential conflict with Peter's
> > ldsem atomic cleanup patch that got taken through the tty tree.
> > 
> > Are you still happy to pick this up? Full blurb below.
> 
> Ping!
> 
> Do you have any comments, or would you be happy to queue this?
> 
> I'm happy to resend come rc1, if you'd prefer?

It would be really nice to see this merged. Any chance we could get this
queued at -rc1 for 4.21, please? If not, what more needs to be done?

Cheers,

Will
