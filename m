Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754879AbeE2H0s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:26:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55174 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeE2H0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:26:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06C94603D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: mwifiex: mark expected switch fall-throughs
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180525213854.GA13392@embeddedor.com>
References: <20180525213854.GA13392@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>, Xinming Hu <huxm@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180529072644.C5679603D2@smtp.codeaurora.org>
Date: Tue, 29 May 2018 07:26:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied to wireless-drivers-next.git, thanks.

666cc438f369 mwifiex: mark expected switch fall-throughs

-- 
https://patchwork.kernel.org/patch/10428577/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
