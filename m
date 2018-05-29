Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754752AbeE2H2z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:28:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57134 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeE2H2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:28:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EE106021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rtlwifi: remove duplicate code
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180524185450.GA2875@embeddedor.com>
References: <20180524185450.GA2875@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180529072851.25E62603D2@smtp.codeaurora.org>
Date: Tue, 29 May 2018 07:28:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Remove and refactor some code in order to avoid having identical code
> for different branches.
> 
> Notice that the logic has been there since 2014.
> 
> Addresses-Coverity-ID: 1426199 ("Identical code for different branches")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied to wireless-drivers-next.git, thanks.

06895b1627fe rtlwifi: remove duplicate code

-- 
https://patchwork.kernel.org/patch/10425379/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
