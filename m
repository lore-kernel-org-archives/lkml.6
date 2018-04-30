Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeD3KdR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:33:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38248 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeD3KdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:33:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A25260556
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rsi_91x: fix structurally dead code
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180426130138.GA440@embeddedor.com>
References: <20180426130138.GA440@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180430103315.35F26606AC@smtp.codeaurora.org>
Date: Mon, 30 Apr 2018 10:33:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Function rsi_hal_key_config returns before reaching code at line
> 922 if (status), hence this code is structurally dead.
> 
> Fix this by storing the value returned by rsi_hal_load_key
> into _status_ for its further evaluation and use.
> 
> Addresses-Coverity-ID: 1468409 ("Structurally dead code")
> Fixes: 4fd6c4762f37 ("rsi: roaming enhancements")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied to wireless-drivers-next.git, thanks.

e1fd7ceec194 rsi_91x: fix structurally dead code

-- 
https://patchwork.kernel.org/patch/10365997/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
