Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46342C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DBB208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DBB208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbeHAHJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:09:04 -0400
Received: from ozlabs.org ([203.11.71.1]:59419 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733085AbeHAHHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:07:47 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41gMDH3hWCz9s3x; Wed,  1 Aug 2018 15:23:59 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9c7b185ab2fe313b4426bf55da3624bef71f342b
In-Reply-To: <20180705114022.19285-2-akshay.adiga@linux.vnet.ibm.com>
To:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     stewart@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
        rjw@rjwysocki.net, npiggin@gmail.com,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [v4, 1/2] powernv/cpuidle: Parse dt idle properties into global structure
Message-Id: <41gMDH3hWCz9s3x@ozlabs.org>
Date:   Wed,  1 Aug 2018 15:23:59 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 11:40:21 UTC, Akshay Adiga wrote:
> Device-tree parsing happens twice, once while deciding idle state to be
> used for hotplug and once during cpuidle init. Hence, parsing the device
> tree and caching it will reduce code duplication. Parsing code has been
> moved to pnv_parse_cpuidle_dt() from pnv_probe_idle_states(). In addition
> to the properties in the device tree the number of available states is
> also required.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9c7b185ab2fe313b4426bf55da3624

cheers
