Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5800C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9691920844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfBHNCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:02:35 -0500
Received: from ozlabs.org ([203.11.71.1]:53967 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfBHNCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:02:34 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wwMC2Dktz9sNG; Sat,  9 Feb 2019 00:02:29 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f069a062ecce7ccc17221c24097826e829f890e1
X-Patchwork-Hint: ignore
In-Reply-To: <5c40a8fd.1c69fb81.e4b1b.8f85@mx.google.com>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        msuchanek@suse.de, haren@linux.vnet.ibm.com, oohall@gmail.com,
        bsingharora@gmail.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     brajeswar.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        jrdr.linux@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: powerpc/powernv: Remove duplicate header
Message-Id: <43wwMC2Dktz9sNG@ozlabs.org>
Date:   Sat,  9 Feb 2019 00:02:29 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 16:10:33 UTC, Sabyasachi Gupta wrote:
> Remove linux/printk.h which is included more than once.
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f069a062ecce7ccc17221c24097826e8

cheers
