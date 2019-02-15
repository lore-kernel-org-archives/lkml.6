Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D71C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8E4222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfBORqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:46:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36832 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfBORqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:46:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EB84A78;
        Fri, 15 Feb 2019 09:46:50 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380D43F589;
        Fri, 15 Feb 2019 09:46:49 -0800 (PST)
Date:   Fri, 15 Feb 2019 17:46:46 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 0/4] arm64: kprobes: Update blacklist checking on arm64
Message-ID: <20190215174646.GH100037@arrakis.emea.arm.com>
References: <154998617300.21869.11457765723750331236.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154998617300.21869.11457765723750331236.stgit@devbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, Feb 13, 2019 at 12:42:53AM +0900, Masami Hiramatsu wrote:
> In v3, I rebased on the latest arm64 kernel which includes
> James' KVM/HYP fixes for kprobes, and fix a reported bugs
> in [4/4].

I will queue this patches at 5.1-rc1 since the arm64 for-next/core
branch is currently based on -rc3 and does not include James' fix. Even
if I rebased your patches on top of -rc3, we'd still get a conflict when
pushing into mainline, so I'd rather send them after -rc1.

Thanks.

-- 
Catalin
