Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6991CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEF020652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEF020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbeGKN2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:28:31 -0400
Received: from ozlabs.org ([203.11.71.1]:40347 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732530AbeGKN2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:28:31 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41Qft13C7HzB4MW; Wed, 11 Jul 2018 23:24:08 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8272f598523d0975259080d2f9d760b9ce625e18
In-Reply-To: <20180617124909.26828-1-j.neuschaefer@gmx.net>
To:     =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org
Subject: Re: powerpc: wii: Remove outdated comment about memory fixups
Message-Id: <41Qft13C7HzB4MW@ozlabs.org>
Date:   Wed, 11 Jul 2018 23:24:08 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-17 at 12:49:06 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> The workaround has been removed. What stays is just code to find the
> memory hole so the BATs can be configured properly in the function below.
> 
> Fixes: 57deb8fea01f ("powerpc/wii: Don't rely on the reserved memory hack")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8272f598523d0975259080d2f9d760

cheers
