Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B4FC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811C4214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811C4214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeJDNGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:06:17 -0400
Received: from ozlabs.org ([203.11.71.1]:47319 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeJDNGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:06:16 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42QjK83lG3z9sBq; Thu,  4 Oct 2018 16:14:36 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b9ef7b4b867f56114bedbe6bf104cfaba0ca818e
In-Reply-To: <20180828015252.28511-6-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: powerpc: Convert to using %pOFn instead of device_node.name
Message-Id: <42QjK83lG3z9sBq@ozlabs.org>
Date:   Thu,  4 Oct 2018 16:14:36 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-28 at 01:52:07 UTC, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b9ef7b4b867f56114bedbe6bf104cf

cheers
