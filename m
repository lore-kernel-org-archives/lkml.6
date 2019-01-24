Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2291BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8A9218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfAXDkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:40:22 -0500
Received: from ozlabs.org ([203.11.71.1]:34045 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfAXDkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:40:19 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43lSbP32bBz9sDK; Thu, 24 Jan 2019 14:40:16 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: acef5e0165912c459a9ae98a25f0f87908ced0f9
X-Patchwork-Hint: ignore
In-Reply-To: <1546951970-29079-1-git-send-email-clabbe@baylibre.com>
To:     Corentin Labbe <clabbe@baylibre.com>, benh@kernel.crashing.org,
        mark.rutland@arm.com, paulus@samba.org, robh+dt@kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: Re: powerpc: build virtex dtb
Message-Id: <43lSbP32bBz9sDK@ozlabs.org>
Date:   Thu, 24 Jan 2019 14:40:16 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 12:52:50 UTC, Corentin Labbe wrote:
> I wanted to test the virtex440-ml507 qemu machine and found that the dtb
> for it was not builded.
> All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
> COMPILE_TEST.
> 
> This patchs adds build of virtex dtbs depending on
> CONFIG_XILINX_VIRTEX440_GENERIC_BOARD option.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/acef5e0165912c459a9ae98a25f0f879

cheers
