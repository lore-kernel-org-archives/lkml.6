Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932136AbeB0QRF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:17:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52938 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeB0QRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:17:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 853E160285
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wireless: zd1211rw: remove redundant assignment of pointer 'q'
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180130182537.5580-1-colin.king@canonical.com>
References: <20180130182537.5580-1-colin.king@canonical.com>
To: Colin Ian King <colin.king@canonical.com>
Cc: Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180227161702.81FE4607E5@smtp.codeaurora.org>
Date: Tue, 27 Feb 2018 16:17:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer q is initialized and then almost immediately afterwards being
> re-assigned the same value. Remove the second redundant assignment.
> 
> Cleans up clang warning:
> drivers/net/wireless/zydas/zd1211rw/zd_mac.c:503:23: warning: Value
> stored to 'q' during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

76d1f95983a0 wireless: zd1211rw: remove redundant assignment of pointer 'q'

-- 
https://patchwork.kernel.org/patch/10192195/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
