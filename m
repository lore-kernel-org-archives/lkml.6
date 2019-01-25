Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83507C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E30120881
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfAYO1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:27:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48064 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfAYO1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:27:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B355DEBD;
        Fri, 25 Jan 2019 06:27:16 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16B4B3F589;
        Fri, 25 Jan 2019 06:27:14 -0800 (PST)
Date:   Fri, 25 Jan 2019 14:27:12 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, peterz@infradead.org, will.deacon@arm.com,
        james.morse@arm.com, hpa@zytor.com, valentin.schneider@arm.com
Subject: Re: [PATCH v3 0/4] uaccess: Add unsafe accessors for arm64
Message-ID: <20190125142711.GD25901@arrakis.emea.arm.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On Tue, Jan 15, 2019 at 01:58:25PM +0000, Julien Thierry wrote:
> Julien Thierry (4):
>   arm64: uaccess: Cleanup get/put_user()
>   arm64: uaccess: Implement unsafe accessors
>   uaccess: Check no rescheduling function is called in unsafe region
>   arm64: uaccess: Implement user_access_region_active

I queued the first two patches for 5.1. It would be nice to upstream the
other two but patch 3 needs an ack from (or merged by) the scheduler
folk.

Thanks.

-- 
Catalin
