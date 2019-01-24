Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAF0C282C4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1722184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfAXDkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:40:33 -0500
Received: from ozlabs.org ([203.11.71.1]:43231 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbfAXDk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:40:29 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43lSbb0ffyz9sNM; Thu, 24 Jan 2019 14:40:26 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8de7547e03059281fda075355c1146941fbbe76f
X-Patchwork-Hint: ignore
In-Reply-To: <20190112162124.3341-2-j.neuschaefer@gmx.net>
To:     =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [1/2] powerpc: wii.dts: Add interrupt-related properties to GPIO node
Message-Id: <43lSbb0ffyz9sNM@ozlabs.org>
Date:   Thu, 24 Jan 2019 14:40:26 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-01-12 at 16:21:23 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> The Hollywood GPIO controller is connected to the Hollywood PIC (&PIC1)
> at IRQs 10 and 11; IRQ 10 for GPIO lines that are configured for access
> by the PPC, 11 for GPIO lines that are configured for access by the
> ARM926.
> 
> Signed-off-by: Jonathan NeuschÃ¤fer <j.neuschaefer@gmx.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8de7547e03059281fda075355c114694

cheers
