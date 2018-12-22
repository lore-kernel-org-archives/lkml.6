Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E36C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3146F21A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392514AbeLVRCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:02:08 -0500
Received: from ozlabs.org ([203.11.71.1]:37977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392402AbeLVRBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:03 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLSf5Txrz9sPG; Sat, 22 Dec 2018 20:54:42 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2fea82db113e4422ef5c8e6209908806e5fb6b63
X-Patchwork-Hint: ignore
In-Reply-To: <20181210215203.1936171-1-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>, Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: powerpc: eeh_event: convert semaphore to completion
Message-Id: <43MLSf5Txrz9sPG@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:54:42 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 21:51:57 UTC, Arnd Bergmann wrote:
> For this use case, completions and semaphores are equivalent,
> but semaphores are an awkward interface that should generally
> be avoided, so use the completion instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2fea82db113e4422ef5c8e62099088

cheers
