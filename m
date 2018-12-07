Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA27C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD43020989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD43020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeLGNHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:07:11 -0500
Received: from ozlabs.org ([203.11.71.1]:45679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLGNHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:07:09 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43BCRZ67Hqz9sBQ; Sat,  8 Dec 2018 00:07:06 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e5480bdcc4429e4c172d450ee1db1934d84482ef
X-Patchwork-Hint: ignore
In-Reply-To: <20181116221104.23024-4-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Use device_type helpers to access the node type
Message-Id: <43BCRZ67Hqz9sBQ@ozlabs.org>
Date:   Sat,  8 Dec 2018 00:07:06 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 22:11:00 UTC, Rob Herring wrote:
> Remove directly accessing device_node.type pointer and use the accessors
> instead. This will eventually allow removing the type pointer.
> 
> Replace the open coded iterating over child nodes with
> for_each_child_of_node() while we're here.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e5480bdcc4429e4c172d450ee1db19

cheers
