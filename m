Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeDXRXe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:23:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55176 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeDXRXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:23:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2840960807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: cw1200: fix spelling mistake: "Mailformed" -> "Malformed"
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180329153818.29538-1-colin.king@canonical.com>
References: <20180329153818.29538-1-colin.king@canonical.com>
To: Colin Ian King <colin.king@canonical.com>
Cc: Solomon Peachy <pizza@shaftnet.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180424172330.0FA6460881@smtp.codeaurora.org>
Date: Tue, 24 Apr 2018 17:23:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in wiphy_warn warning message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

0fb1abc3a0b8 cw1200: fix spelling mistake: "Mailformed" -> "Malformed"

-- 
https://patchwork.kernel.org/patch/10315587/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
