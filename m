Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83AFC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D7A2146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D7A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLGNHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:07:39 -0500
Received: from ozlabs.org ([203.11.71.1]:49245 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeLGNHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:07:05 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43BCRW3g0Sz9s0t; Sat,  8 Dec 2018 00:07:03 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 15b680c474afd54dac05530d8fed41c1e8d607e0
X-Patchwork-Hint: ignore
In-Reply-To: <20181116220540.17222-3-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: macintosh: windfarm: Another convert to using %pOFn instead of device_node.name
Message-Id: <43BCRW3g0Sz9s0t@ozlabs.org>
Date:   Sat,  8 Dec 2018 00:07:03 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 22:05:39 UTC, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Convert the open coded iterating thru child nodes to
> for_each_child_of_node() while we're here.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/15b680c474afd54dac05530d8fed41

cheers
