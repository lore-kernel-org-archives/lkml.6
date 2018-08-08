Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD85C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD6B219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD6B219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeHHQqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:46:43 -0400
Received: from ozlabs.org ([203.11.71.1]:58319 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbeHHQqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:46:43 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ltxL6kNPz9s4V; Thu,  9 Aug 2018 00:26:30 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 658b0f92bc7003bc734471f61bf7cd56339eb8c3
In-Reply-To: <20180801213320.11203-2-muriloo@linux.ibm.com>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Michael Neuling <mikey@neuling.org>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Alastair D'Silva <alastair@d-silva.org>,
        Joe Perches <joe@perches.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Cyril Bur <cyrilbur@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [v4, 1/6] powerpc/traps: Print unhandled signals in a separate function
Message-Id: <41ltxL6kNPz9s4V@ozlabs.org>
Date:   Thu,  9 Aug 2018 00:26:30 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 21:33:15 UTC, Murilo Opsfelder Araujo wrote:
> Isolate the logic of printing unhandled signals out of _exception_pkey().
> No functional change, only code rearrangement.
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/658b0f92bc7003bc734471f61bf7cd

cheers
