Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD66C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7728F2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7728F2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeKCCVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:21:33 -0400
Received: from foss.arm.com ([217.140.101.70]:44184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKCCVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:21:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4343DA78;
        Fri,  2 Nov 2018 10:13:42 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11BAF3F71E;
        Fri,  2 Nov 2018 10:13:42 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9B0AF1AE0DD2; Fri,  2 Nov 2018 17:13:50 +0000 (GMT)
Date:   Fri, 2 Nov 2018 17:13:50 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        punitagrawal@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailmap: Update email for Punit Agrawal
Message-ID: <20181102171350.GA31184@arm.com>
References: <20181102165751.17948-1-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102165751.17948-1-punit.agrawal@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:57:52PM +0000, Punit Agrawal wrote:
> As I'll no longer be working with Arm, add a mailmap entry so any mail
> directed towards me reaches the appropriate mailbox.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index a76be45fef6c..28fecafa6506 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -159,6 +159,7 @@ Peter Oruba <peter@oruba.de>
>  Peter Oruba <peter.oruba@amd.com>
>  Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
>  Praveen BP <praveenbp@ti.com>
> +Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
>  Qais Yousef <qsyousef@gmail.com> <qais.yousef@imgtec.com>
>  Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
>  Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks for volunteering to stay involved, Punit!

Will
