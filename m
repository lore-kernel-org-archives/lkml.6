Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27807C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1853214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1853214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeITKCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:02:21 -0400
Received: from ozlabs.org ([203.11.71.1]:46449 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeITKCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:02:20 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42G3SV13tPz9sCV; Thu, 20 Sep 2018 14:20:57 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5600fbe340331e2a25d1b277f9c190f5c9948038
In-Reply-To: <1534775376-22480-2-git-send-email-ldufour@linux.vnet.ibm.com>
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     aneesh.kumar@linux.ibm.com, npiggin@gmail.com, paulus@samba.org
Subject: Re: [v2,1/3] powerpc/pseries/mm: Introducing FW_FEATURE_BLOCK_REMOVE
Message-Id: <42G3SV13tPz9sCV@ozlabs.org>
Date:   Thu, 20 Sep 2018 14:20:57 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-20 at 14:29:34 UTC, Laurent Dufour wrote:
> This feature tells if the hcall H_BLOCK_REMOVE is available.
> 
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5600fbe340331e2a25d1b277f9c190

cheers
