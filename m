Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeD3K25 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:28:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33986 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeD3K2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:28:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9EDD601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: qtnfmac: fix qtnf_netdev_hard_start_xmit()'s return type
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180424131810.4963-1-luc.vanoostenryck@gmail.com>
References: <20180424131810.4963-1-luc.vanoostenryck@gmail.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Vasily Ulyanov <vulyanov@quantenna.com>,
        Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180430102854.CA14360558@smtp.codeaurora.org>
Date: Mon, 30 Apr 2018 10:28:54 +0000 (UTC)
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
> Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Patch applied to wireless-drivers-next.git, thanks.

3ff6ee28535f qtnfmac: fix qtnf_netdev_hard_start_xmit()'s return type

-- 
https://patchwork.kernel.org/patch/10359851/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
