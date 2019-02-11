Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09043C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF77F222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfBKR0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:26:21 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60612 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbfBKR0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:26:17 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gtFLS-0006gf-Sb; Mon, 11 Feb 2019 10:26:15 -0700
To:     Peng Fan <peng.fan@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "ghackmann@android.com" <ghackmann@android.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
References: <20190210093738.30923-1-peng.fan@nxp.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d21d10ab-ce32-9f4c-205a-43ad02c11300@deltatee.com>
Date:   Mon, 11 Feb 2019 10:26:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190210093738.30923-1-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: van.freenix@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hannes@cmpxchg.org, stefan@agner.ch, ghackmann@android.com, james.morse@arm.com, robin.murphy@arm.com, f.fainelli@gmail.com, ard.biesheuvel@linaro.org, rppt@linux.vnet.ibm.com, akpm@linux-foundation.org, will.deacon@arm.com, catalin.marinas@arm.com, peng.fan@nxp.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] arm64: use memblocks_present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-02-10 2:28 a.m., Peng Fan wrote:
> arm64_memory_present is doing same thing as memblocks_present, so
> let's use common code memblocks_present instead of platform
> specific arm64_memory_present.

I've already sent patches for this[1]. The arm64 one was already queued
up by Catalin.

Thanks,

Logan
