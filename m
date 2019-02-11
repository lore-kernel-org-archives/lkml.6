Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39762C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115892075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfBKMUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:20:43 -0500
Received: from foss.arm.com ([217.140.101.70]:46754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfBKMUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:20:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F0180D;
        Mon, 11 Feb 2019 04:20:37 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B0933F557;
        Mon, 11 Feb 2019 04:20:35 -0800 (PST)
Date:   Mon, 11 Feb 2019 12:20:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "ghackmann@android.com" <ghackmann@android.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH] arm64: use memblocks_present
Message-ID: <20190211122032.GC165128@arrakis.emea.arm.com>
References: <20190210093738.30923-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210093738.30923-1-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 09:28:43AM +0000, Peng Fan wrote:
> arm64_memory_present is doing same thing as memblocks_present, so
> let's use common code memblocks_present instead of platform
> specific arm64_memory_present.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I already merged a similar one (see commit
a2c801c53d1682871fba1e037c9d3b0c9fffee8a in -next).

-- 
Catalin
