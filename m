Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeEDMgZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:36:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57246 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbeEDMgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:36:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88E6660310
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rtlwifi: fix spelling mistake: "dismatch" -> "mismatch"
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180430134102.11171-1-colin.king@canonical.com>
References: <20180430134102.11171-1-colin.king@canonical.com>
To: Colin Ian King <colin.king@canonical.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180504123620.EC99C607E5@smtp.codeaurora.org>
Date: Fri,  4 May 2018 12:36:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in RT_TRACE message text.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

070fc356e21a rtlwifi: fix spelling mistake: "dismatch" -> "mismatch"

-- 
https://patchwork.kernel.org/patch/10371799/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
