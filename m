Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E5FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EEE208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EEE208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeGaGBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:01:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33130 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeGaGBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:01:14 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3TEN5p8FbiRO; Tue, 31 Jul 2018 06:22:56 +0200 (CEST)
Received: from nazgul.tnic (95-42-131-245.ip.btc-net.bg [95.42.131.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D51331EC00F4;
        Tue, 31 Jul 2018 06:22:55 +0200 (CEST)
Date:   Tue, 31 Jul 2018 06:22:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     vnkgutta@codeaurora.org
Cc:     evgreen@chromium.org, robh@kernel.org, mchehab@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH v0 3/4] drivers: edac: Add cache erp driver for Last
 Level Cache Controller (LLCC)
Message-ID: <20180731042259.GD13258@nazgul.tnic>
References: <1532540697-26630-1-git-send-email-vnkgutta@codeaurora.org>
 <1532540697-26630-4-git-send-email-vnkgutta@codeaurora.org>
 <20180729034927.GA2916@nazgul.tnic>
 <090d55ef84af7bc6c750b93219408437@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <090d55ef84af7bc6c750b93219408437@codeaurora.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 02:38:01PM -0700, vnkgutta@codeaurora.org wrote:
> Do you mean the Signed-off-by lines above? That's because
> Channagoud is the one who is the original author of this driver,
> and I'm the one who did the incremental changes (changes in llcc)
> and uploading it upstream.
> That's why the Signed-off is like that.
> Which way do you think it should be?

Then you need to figure out between you two who the author should be
because we have single authorship. When you do, commit it in git with

git commit --amend --author=...

so that that is reflected properly.

For expressing stuff like co-authorship we have

Co-Developed-by:

All explained in submitting-patches.rst.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
