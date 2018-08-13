Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B799C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A10821746
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A10821746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbeHMOEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:04:43 -0400
Received: from ozlabs.org ([203.11.71.1]:54143 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbeHMOEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:04:42 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ptcr1qmxz9sBD; Mon, 13 Aug 2018 21:22:52 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 302c7b0c4ff5aed585419603f835dee30207e5d5
In-Reply-To: <20161122092033.7869-1-boqun.feng@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Rashmica Gupta <rashmicy@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [RFC,v2] powerpc: xmon: Add address lookup for percpu symbols
Message-Id: <41ptcr1qmxz9sBD@ozlabs.org>
Date:   Mon, 13 Aug 2018 21:22:52 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2016-11-22 at 09:20:09 UTC, Boqun Feng wrote:
> Currently, in xmon, there is no obvious way to get an address for a
> percpu symbol for a particular cpu. Having such an ability would be good
> for debugging the system when percpu variables got involved.
> 
> Therefore, this patch introduces a new xmon command "lp" to lookup the
> address for percpu symbols. Usage of "lp" is similar to "ls", except
> that we could add a cpu number to choose the variable of which cpu we
> want to lookup. If no cpu number is given, lookup for current cpu.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/302c7b0c4ff5aed585419603f835de

cheers
