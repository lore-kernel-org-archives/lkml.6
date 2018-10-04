Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C4AC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADCD21477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADCD21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeJDNGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:06:14 -0400
Received: from ozlabs.org ([203.11.71.1]:49309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbeJDNGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:06:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42QjK64l5Zz9s7W; Thu,  4 Oct 2018 16:14:34 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8c8933eba0c2853ecbd6a9ef7542b9058f8b5e11
In-Reply-To: <20180104224542.15333-3-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: powerpc: cell: use irq_of_parse_and_map helper
Message-Id: <42QjK64l5Zz9s7W@ozlabs.org>
Date:   Thu,  4 Oct 2018 16:14:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-01-04 at 22:45:41 UTC, Rob Herring wrote:
> Instead of calling both of_irq_parse_one and irq_create_of_mapping, call
> of_irq_parse_and_map instead which does the same thing. This gets us closer
> to making the former 2 functions static.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8c8933eba0c2853ecbd6a9ef7542b9

cheers
