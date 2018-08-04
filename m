Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC7EC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2425B217CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2425B217CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeHDSdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 14:33:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43962 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbeHDSdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 14:33:42 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oKQnlF9qkDfv; Sat,  4 Aug 2018 18:32:28 +0200 (CEST)
Received: from nazgul.tnic (95-42-181-223.ip.btc-net.bg [95.42.181.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5AEA01EC00FF;
        Sat,  4 Aug 2018 18:32:28 +0200 (CEST)
Date:   Sat, 4 Aug 2018 18:32:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, michal.simek@xilinx.com, mchehab@kernel.org,
        mdf@kernel.org, edgar.iglesias@xilinx.com,
        shubhrajyoti.datta@xilinx.com, naga.sureshkumar.relli@xilinx.com,
        bharat.kumar.gogada@xilinx.com, stefan.krsmanovic@aggios.com,
        sgoud@xilinx.com, anirudh@xilinx.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v4 0/4] EDAC: Enhancements to Synopsys EDAC driver
Message-ID: <20180804163230.GA8157@nazgul.tnic>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 02:55:31PM +0530, Manish Narani wrote:
> This patch series enhances the current EDAC driver to support different

This one, your 2/4 and 4/4 still says "this patch". Hurried too much?
How about slowing down and looking at them with a critical eye?

Also, how about waiting for a week before resending your patches so that
you give people chance to review them too?

While you wait, please read Documentation/process/submitting-patches.rst
- it'll help you with the submission modalities.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
