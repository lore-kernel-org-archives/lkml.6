Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE3020858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE3020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeIRNYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:24:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56036 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeIRNYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:24:38 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VfyWcZ5AwMK7; Tue, 18 Sep 2018 09:53:13 +0200 (CEST)
Received: from nazgul.tnic (unknown [81.19.42.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FC7E1EC0118;
        Tue, 18 Sep 2018 09:53:13 +0200 (CEST)
Date:   Tue, 18 Sep 2018 09:53:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        michal.simek@xilinx.com, leoyang.li@nxp.com, sudeep.holla@arm.com,
        amit.kucheria@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/7] edac: synopsys: Fix code comments and naming
 convention
Message-ID: <20180918075311.GB22202@nazgul.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1537194305-9243-2-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 07:54:59PM +0530, Manish Narani wrote:
> Update the comments in the Synopsys EDAC driver. Minor changes to function
> names and return types are also included.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 176 ++++++++++++++++++++-----------------------
>  1 file changed, 80 insertions(+), 96 deletions(-)

So this patch does a bunch of things together and should be split into:

* functional changes like code cleanup
* functions renaming
* comments cleanup

Maybe in that order.

This way you'll have one logical set of changes per patch and review
will be almost trivial.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
