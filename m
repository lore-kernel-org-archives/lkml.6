Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936116AbeEYKSv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:18:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935965AbeEYKSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:18:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D6E760262
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] wcn36xx: Add support for Factory Test Mode (FTM)
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180522190256.32136-1-ramon.fried@gmail.com>
References: <20180522190256.32136-1-ramon.fried@gmail.com>
To: Ramon Fried <ramon.fried@gmail.com>
Cc: linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Eyal Ilsar <eilsar@codeaurora.org>,
        Ramon Fried <ramon.fried@linaro.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180525101847.498DC6076C@smtp.codeaurora.org>
Date: Fri, 25 May 2018 10:18:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ramon Fried <ramon.fried@gmail.com> wrote:

> Introduce infrastructure for supporting Factory Test Mode (FTM) of the
> wireless LAN subsystem. In order for the user space to access the
> firmware in test mode the relevant netlink channel needs to be exposed
> from the kernel driver.
> 
> The above is achieved as follows:
> 1) Register wcn36xx driver to testmode callback from netlink
> 2) Add testmode callback implementation to handle incoming FTM commands
> 3) Add FTM command packet structure
> 4) Add handling for GET_BUILD_RELEASE_NUMBER (msgid=0x32A2)
> 5) Add generic handling for all PTT_MSG packets
> 
> Signed-off-by: Eyal Ilsar <eilsar@codeaurora.org>
> Signed-off-by: Ramon Fried <ramon.fried@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

87f825e6e246 wcn36xx: Add support for Factory Test Mode (FTM)

-- 
https://patchwork.kernel.org/patch/10419423/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
