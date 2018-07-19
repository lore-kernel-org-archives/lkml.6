Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8769CECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E91206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E91206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbeGSGtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:49:04 -0400
Received: from ozlabs.org ([203.11.71.1]:34707 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbeGSGtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:49:03 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41WNpc2DKrz9s4w; Thu, 19 Jul 2018 16:07:36 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 835b706bab95141e2663b046f2fc596169b57fa8
In-Reply-To: <20180621083305.5322-1-brgl@bgdev.pl>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND, 1/3] powerpc: dts: use 'atmel' as at24 anufacturer for pdm360ng
Message-Id: <41WNpc2DKrz9s4w@ozlabs.org>
Date:   Thu, 19 Jul 2018 16:07:36 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-21 at 08:33:03 UTC, Bartosz Golaszewski wrote:
> Using 'at' as the <manufacturer> part of the compatible string is now
> deprecated. Use a correct string: 'atmel,<model>'.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/835b706bab95141e2663b046f2fc59

cheers
