Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0E6C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8D120842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8D120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeJOLoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 07:44:30 -0400
Received: from ozlabs.org ([203.11.71.1]:50265 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbeJOLo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 07:44:28 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42YPr04cz1z9sDP; Mon, 15 Oct 2018 15:01:04 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b45e9d761ba2d60044b610297e3ef9f947ac157f
In-Reply-To: <20181009135913.14616-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <nfont@linux.vnet.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3, -next] powerpc/pseries/memory-hotplug: Fix return value type of find_aa_index
Message-Id: <42YPr04cz1z9sDP@ozlabs.org>
Date:   Mon, 15 Oct 2018 15:01:04 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-09 at 13:59:13 UTC, YueHaibing wrote:
> 'aa_index' is defined as an unsigned value, but find_aa_index
> may return -1 when dlpar_clone_property fails. So change 
> find_aa_index return value type to bool, which indicate 'aa_index'
> whether found or not.
> 
> Fixes: c05a5a40969e ("powerpc/pseries: Dynamic add entires to associativity lookup array")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Nathan Fontenot nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b45e9d761ba2d60044b610297e3ef9

cheers
