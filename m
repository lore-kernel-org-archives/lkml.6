Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeD3KZV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:25:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60792 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeD3KZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:25:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A97A60588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: mwifiex: fix spelling mistake: "capabilties" -> "capabilities"
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180428093621.6806-1-colin.king@canonical.com>
References: <20180428093621.6806-1-colin.king@canonical.com>
To: Colin Ian King <colin.king@canonical.com>
Cc: Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>, Xinming Hu <huxm@marvell.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180430102519.0BE96601A1@smtp.codeaurora.org>
Date: Mon, 30 Apr 2018 10:25:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in function names and text strings
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Failed to apply:

error: patch failed: drivers/net/wireless/marvell/mwifiex/sta_event.c:933
error: drivers/net/wireless/marvell/mwifiex/sta_event.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Applying: mwifiex: fix spelling mistake: "capabilties" -> "capabilities"
Using index info to reconstruct a base tree...
Patch failed at 0001 mwifiex: fix spelling mistake: "capabilties" -> "capabilities"
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/10370183/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
