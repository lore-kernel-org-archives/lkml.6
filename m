Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A1DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D32E2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbeLWN2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 08:28:47 -0500
Received: from ozlabs.org ([203.11.71.1]:36061 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbeLWN2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 08:28:01 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43N38G6V72z9sMM; Mon, 24 Dec 2018 00:27:58 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2c8e65b595cf0bf7c1413404dff9b928a64d27cb
X-Patchwork-Hint: ignore
In-Reply-To: <20181205195050.4759-2-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
        Alistair Popple <alistair@popple.id.au>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Use of_node_name_eq for node name comparisons
Message-Id: <43N38G6V72z9sMM@ozlabs.org>
Date:   Mon, 24 Dec 2018 00:27:58 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-05 at 19:50:18 UTC, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> A couple of open coded iterating thru the child node names are converted
> to use for_each_child_of_node() instead.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Alistair Popple <alistair@popple.id.au>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2c8e65b595cf0bf7c1413404dff9b9

cheers
