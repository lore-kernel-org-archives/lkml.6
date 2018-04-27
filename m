Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757713AbeD0LfU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:35:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53252 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757451AbeD0LfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:35:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B665E60310
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath6kl: fix ath6kl_data_tx()'s return type
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180424131900.5718-1-luc.vanoostenryck@gmail.com>
References: <20180424131900.5718-1-luc.vanoostenryck@gmail.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180427113517.656D360767@smtp.codeaurora.org>
Date: Fri, 27 Apr 2018 11:35:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

378b1d65070f ath6kl: fix ath6kl_data_tx()'s return type

-- 
https://patchwork.kernel.org/patch/10359823/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
