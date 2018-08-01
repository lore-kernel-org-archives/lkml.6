Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A23C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D5420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D5420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbeHAHHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:07:48 -0400
Received: from ozlabs.org ([203.11.71.1]:35175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733090AbeHAHHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:07:47 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41gMDJ2zDtz9s3Z; Wed,  1 Aug 2018 15:24:00 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: db0a2b633da4216b767d7aed95ffe30d37409c7a
In-Reply-To: <7df5e140a48f60c74374fe77841ad1f3eaf3f594.1530807556.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3,01/16] powerpc: remove kdump.h from page.h
Message-Id: <41gMDJ2zDtz9s3Z@ozlabs.org>
Date:   Wed,  1 Aug 2018 15:24:00 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 16:24:51 UTC, Christophe Leroy wrote:
> page.h doesn't need kdump.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/db0a2b633da4216b767d7aed95ffe3

cheers
