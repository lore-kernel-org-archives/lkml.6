Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3E7C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432F52173B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeLWN2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 08:28:32 -0500
Received: from ozlabs.org ([203.11.71.1]:34813 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbeLWN2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 08:28:11 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43N38S6v33z9sP9; Mon, 24 Dec 2018 00:28:08 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b52106a040e6f86848b05be1b4317479836e94d4
X-Patchwork-Hint: ignore
In-Reply-To: <90e9f81b-25ad-cf02-663c-50a9997d9d53@users.sourceforge.net>
To:     SF Markus Elfring <elfring@users.sourceforge.net>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh@kernel.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [1/5] powerpc/4xx: Combine four seq_printf() calls into two in ocm_debugfs_show()
Message-Id: <43N38S6v33z9sP9@ozlabs.org>
Date:   Mon, 24 Dec 2018 00:28:08 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-01-11 at 18:00:33 UTC, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 11 Jan 2018 18:08:08 +0100
> 
> Some data were printed into a sequence by four separate function calls.
> Print the same data by two single function calls instead.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b52106a040e6f86848b05be1b43174

cheers
