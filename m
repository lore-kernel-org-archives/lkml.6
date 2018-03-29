Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeC2JLa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 05:11:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40428 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeC2JL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 05:11:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CA64602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath: Remove unnecessary ath_bcast_mac and use eth_broadcast_addr
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <3ed8112986ba6f538cb45df6ea67e0c027a3dc12.1521628278.git.joe@perches.com>
References: <3ed8112986ba6f538cb45df6ea67e0c027a3dc12.1521628278.git.joe@perches.com>
To: Joe Perches <joe@perches.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180329091127.A5B4960C67@smtp.codeaurora.org>
Date: Thu, 29 Mar 2018 09:11:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> wrote:

> Remove the static array and use the generic routine to set the
> Ethernet broadcast address.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

a72c92629108 ath: Remove unnecessary ath_bcast_mac and use eth_broadcast_addr

-- 
https://patchwork.kernel.org/patch/10299129/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
