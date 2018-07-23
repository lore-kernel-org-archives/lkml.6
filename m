Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11B2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B33320881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B33320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbeGWQM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:12:57 -0400
Received: from ozlabs.org ([203.11.71.1]:39093 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387859AbeGWQM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:12:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41Z4h32LnGz9s3Z; Tue, 24 Jul 2018 01:11:14 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fca7bf946e31688edce446fdaa571ccf77e24687
In-Reply-To: <1530267872-31244-1-git-send-email-Bharat.Bhushan@nxp.com>
To:     Bharat Bhushan <Bharat.Bhushan@nxp.com>, benh@kernel.crashing.org,
        paulus@samba.org, robh@kernel.org, geoff@infradead.org,
        tyreld@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: Re: powerpc/mpic: Cleanup irq vector accounting
Message-Id: <41Z4h32LnGz9s3Z@ozlabs.org>
Date:   Tue, 24 Jul 2018 01:11:14 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 10:24:32 UTC, Bharat Bhushan wrote:
> Available vector space accounts ipis and timer interrupts
> while spurious vector was not accounted. Also later
> mpic_setup_error_int() escape one more vector, seemingly it
> assumes one spurious vector.
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fca7bf946e31688edce446fdaa571c

cheers
