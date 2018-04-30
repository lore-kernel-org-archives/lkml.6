Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbeD3Ke1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:34:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeD3KeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:34:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AB38607CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rsi_91x: fix uninitialized variable
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180426131324.GA982@embeddedor.com>
References: <20180426131324.GA982@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180430103424.D492960807@smtp.codeaurora.org>
Date: Mon, 30 Apr 2018 10:34:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> There is a potential execution path in which variable ret is returned
> without being properly initialized previously.
> 
> Fix this by storing the value returned by function
> rsi_usb_master_reg_write into _ret_.
> 
> Addresses-Coverity-ID: 1468407 ("Uninitialized scalar variable")
> Fixes: 16d3bb7b2f37 ("rsi: disable fw watchdog timer during reset")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied to wireless-drivers-next.git, thanks.

48c6b5c9c118 rsi_91x: fix uninitialized variable

-- 
https://patchwork.kernel.org/patch/10365985/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
