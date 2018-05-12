Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeELIzK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 04:55:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41434 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeELIzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 04:55:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D008B601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rsi: fix spelling mistake: "thead" -> "thread"
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180510143217.23488-1-colin.king@canonical.com>
References: <20180510143217.23488-1-colin.king@canonical.com>
To: Colin Ian King <colin.king@canonical.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180512085508.173276019F@smtp.codeaurora.org>
Date: Sat, 12 May 2018 08:55:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in rsi_dbg debug message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

b41c39367669 rsi: fix spelling mistake: "thead" -> "thread"

-- 
https://patchwork.kernel.org/patch/10391879/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
