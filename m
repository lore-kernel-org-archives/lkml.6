Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A3EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5615321773
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbeLWN2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 08:28:19 -0500
Received: from ozlabs.org ([203.11.71.1]:56895 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbeLWN2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 08:28:14 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43N38W5pqRz9sNr; Mon, 24 Dec 2018 00:28:11 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ae6263cc33742d1c179510b6aadd31108fe89a89
X-Patchwork-Hint: ignore
In-Reply-To: <de85bbcd-36a8-7de5-8d18-96e1530a23c2@users.sourceforge.net>
To:     SF Markus Elfring <elfring@users.sourceforge.net>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh@kernel.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [5/5] powerpc/4xx: Delete an unnecessary return statement in two functions
Message-Id: <43N38W5pqRz9sNr@ozlabs.org>
Date:   Mon, 24 Dec 2018 00:28:11 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-01-11 at 18:04:54 UTC, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 11 Jan 2018 18:40:23 +0100
> 
> The script "checkpatch.pl" pointed information out like the following.
> 
> WARNING: void function return statements are not generally useful
> 
> Thus remove such a statement in the affected functions.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ae6263cc33742d1c179510b6aadd31

cheers
