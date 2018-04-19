Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbeDSP5y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:57:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33660 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbeDSP5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:57:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29B2B602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath6kl: fix spelling mistake: "chache" -> "cache"
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180329165304.26504-1-colin.king@canonical.com>
References: <20180329165304.26504-1-colin.king@canonical.com>
To: Colin Ian King <colin.king@canonical.com>
Cc: Kalle Valo <kvalo@qca.qualcomm.com>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180419155752.0DF336090E@smtp.codeaurora.org>
Date: Thu, 19 Apr 2018 15:57:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> Trivial fix to spelling mistake in message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5072d87426bb ath6kl: fix spelling mistake: "chache" -> "cache"

-- 
https://patchwork.kernel.org/patch/10315713/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
