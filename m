Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9A500C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D926208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SDK7DWgo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ICdxlxw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D926208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936074AbeFNPSX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:18:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755033AbeFNPSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:18:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A45766055D; Thu, 14 Jun 2018 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989500;
        bh=OyYCdtDlGnX8C8q+G3uPOA0BPxRAYP1AR+nakLODIjk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SDK7DWgoeLrVxVGhXvSE7DeiQsPKDINVsfR1itkxgQ94ru9I+VDARuUljZ/gtjPUd
         wZU+lkRNFOsbajQtEjeM/Q/Mu4yEde1oF26h31N2zixwE50VxMRtL8uJHHenDbe/Tr
         vGHP0YcHyNuk4qEmR+NeAzdp7JLuaVHjsOmrdbYk=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98F316022C;
        Thu, 14 Jun 2018 15:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989500;
        bh=OyYCdtDlGnX8C8q+G3uPOA0BPxRAYP1AR+nakLODIjk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ICdxlxw+fcYqlbd3axXuqTw9cREAtvzM3rJrqYA95Lg75MaeZtzqQYzlvfKUck6BR
         tJC1/SNqJTwllbco6BrB4oUEcdXp8bkRI6JnWtahm4jUEfDUMgtNtOcScVDru93Ejm
         9pihuMIBHcDb3Ff1pszq2C1EtxWCcLSHn0pigAPQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98F316022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/2] ath10k: do not mix spaces and tabs in Kconfig
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180612113907.15043-1-niklas.cassel@linaro.org>
References: <20180612113907.15043-1-niklas.cassel@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180614151820.A45766055D@smtp.codeaurora.org>
Date:   Thu, 14 Jun 2018 15:18:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas Cassel <niklas.cassel@linaro.org> wrote:

> Do not mix spaces and tabs in Kconfig.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

50c51f394e68 ath10k: do not mix spaces and tabs in Kconfig

-- 
https://patchwork.kernel.org/patch/10460095/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

