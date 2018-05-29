Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754858AbeE2HVy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:21:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeE2HVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:21:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08C2C603D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rsi: fix spelling mistake "Uknown" -> "Unknown"
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180526150019.10288-1-colin.king@canonical.com>
References: <20180526150019.10288-1-colin.king@canonical.com>
To: Colin Ian King <colin.king@canonical.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180529072150.D61E660242@smtp.codeaurora.org>
Date: Tue, 29 May 2018 07:21:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in rsi_dbg message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

a53e8f3edaa0 rsi: fix spelling mistake "Uknown" -> "Unknown"

-- 
https://patchwork.kernel.org/patch/10429003/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
