Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeB0QOu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:14:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeB0QOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:14:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C8A06021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ssb: return boolean instead of integer in
 ssb_dma_translation_special_bit
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180118235428.GA25892@embeddedor.com>
References: <20180118235428.GA25892@embeddedor.com>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180227161448.CD2C860849@smtp.codeaurora.org>
Date: Tue, 27 Feb 2018 16:14:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <garsilva@embeddedor.com> wrote:

> Return statements in functions returning bool should use
> true/false instead of 1/0.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch applied to wireless-drivers-next.git, thanks.

bd42cd022e44 ssb: return boolean instead of integer in ssb_dma_translation_special_bit

-- 
https://patchwork.kernel.org/patch/10174387/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
