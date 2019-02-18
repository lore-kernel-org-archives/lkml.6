Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FE92184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfBRIj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:39:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53794 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbfBRIj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:39:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD871A78;
        Mon, 18 Feb 2019 00:39:58 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D2023F589;
        Mon, 18 Feb 2019 00:39:57 -0800 (PST)
Date:   Mon, 18 Feb 2019 08:39:53 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: arm/arm64: fix spelling mistake: "auxilary" ->
 "auxiliary"
Message-ID: <20190218083953.2e8e6ed4@why.wild-wind.fr.eu.org>
In-Reply-To: <20190217223626.16686-1-colin.king@canonical.com>
References: <20190217223626.16686-1-colin.king@canonical.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 22:36:26 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a kvm_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  virt/kvm/arm/arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 7fcc1c8c4020..99c37384ba7b 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1563,7 +1563,7 @@ static int init_hyp_mode(void)
>  
>  	err = hyp_map_aux_data();
>  	if (err)
> -		kvm_err("Cannot map host auxilary data: %d\n", err);
> +		kvm_err("Cannot map host auxiliary data: %d\n", err);
>  
>  	return 0;
>  

Applied, thanks.

	M.
-- 
Without deviation from the norm, progress is not possible.
