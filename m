Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2880C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D9C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D9C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeIDLxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:53:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60610 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeIDLxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:53:13 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yJiB24tJZWgG; Tue,  4 Sep 2018 09:29:04 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC9A500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:a500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0CFBC1EC0513;
        Tue,  4 Sep 2018 09:29:03 +0200 (CEST)
Date:   Tue, 4 Sep 2018 09:28:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fan Wu <wufan@codeaurora.org>
Cc:     mchehab@kernel.org, james.morse@arm.com, baicar.tyler@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, john.garry@huawei.com,
        toshi.kani@hpe.com, tanxiaofei@huawei.com, wanghuiqiang@huawei.com,
        shiju.jose@huawei.com
Subject: Re: [PATCH v3] EDAC, ghes: use CPER module handles to locate DIMMs
Message-ID: <20180904072858.GA32615@zn.tnic>
References: <1536033055-25522-1-git-send-email-wufan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1536033055-25522-1-git-send-email-wufan@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 03:50:55AM +0000, Fan Wu wrote:
> For platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records, this patch uses the module
> handles to locate corresponding DIMMs and enables per-DIMM
> error counter update.
> 
> Signed-off-by: Fan Wu <wufan@codeaurora.org>
> Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
> Tested-by: Toshi Kani <toshi.kani@hpe.com>

Those two tags I did see being given to you ...

> Reviewed-by: Borislav Petkov <bp@alien8.de>
> Reviewed-by: James Morse <james.morse@arm.com>
> Reviewed-by: tanxiaofei <tanxiaofei@huawei.com>

... but how in the world did you come up with those?

Do you understand how Reviewed-by works or do you need to look at
Documentation/process/submitting-patches.rst, section 13 ?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
