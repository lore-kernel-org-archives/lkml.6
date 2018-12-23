Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D241AC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA002173B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeLWN1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 08:27:54 -0500
Received: from ozlabs.org ([203.11.71.1]:52441 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbeLWN1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 08:27:54 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43N3884F5Nz9sDP; Mon, 24 Dec 2018 00:27:52 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0c9108b083706330cd5484d121fbb0ad67e8f647
X-Patchwork-Hint: ignore
In-Reply-To: <20181121035637.17446-1-ravi.bangoria@linux.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, paulus@samba.org, ebiederm@xmission.com,
        muriloo@linux.ibm.com, leitao@debian.org,
        naveen.n.rao@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [v2] Powerpc/perf: Wire up PMI throttling
Message-Id: <43N3884F5Nz9sDP@ozlabs.org>
Date:   Mon, 24 Dec 2018 00:27:52 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-21 at 03:56:37 UTC, Ravi Bangoria wrote:
> Commit 14c63f17b1fde ("perf: Drop sample rate when sampling is too
> slow") introduced a way to throttle PMU interrupts if we're spending
> too much time just processing those. Wire up powerpc PMI handler to
> use this infrastructure.
> 
> We have throttling of the *rate* of interrupts, but this adds
> throttling based on the *time taken* to process the interrupts.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0c9108b083706330cd5484d121fbb0

cheers
