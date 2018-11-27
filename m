Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C54C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2352086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2352086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbeK0UUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:20:02 -0500
Received: from ozlabs.org ([203.11.71.1]:38305 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729710AbeK0UTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:19:40 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 433ywv1tHvz9sB7; Tue, 27 Nov 2018 20:22:22 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f6cee260309807acb12ff84524ffc84720c2904b
In-Reply-To: <20181105150119.6452-1-tiny.windzz@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, benh@kernel.crashing.org,
        paulus@samba.org, hbathini@linux.ibm.com,
        mahesh@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
        msuchanek@suse.de
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: powerpc/fadump: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-Id: <433ywv1tHvz9sB7@ozlabs.org>
Date:   Tue, 27 Nov 2018 20:22:22 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 15:01:19 UTC, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f6cee260309807acb12ff84524ffc8

cheers
