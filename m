Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeBYH1e (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 02:27:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbeBYH1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 02:27:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27BB460591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Ramon Fried <rfried@codeaurora.org>
Cc: davem@davemloft.net, marcel@holtmann.org, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] qrtr: add MODULE_ALIAS macro to smd
References: <20180225060559.17527-1-rfried@codeaurora.org>
Date: Sun, 25 Feb 2018 09:27:26 +0200
In-Reply-To: <20180225060559.17527-1-rfried@codeaurora.org> (Ramon Fried's
        message of "Sun, 25 Feb 2018 08:05:59 +0200")
Message-ID: <878tbhwmu9.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ramon Fried <rfried@codeaurora.org> writes:

> Added MODULE_ALIAS("rpmsg:IPCRTR") to ensure qrtr-smd and qrtr will load
> when IPCRTR channel is detected.
>
> Signed-off-by: Ramon Fried <rfried@codeaurora.org>
>
> V2: Corrected subject line, this is not a part of a patchset.
> ---
>  net/qrtr/smd.c | 1 +
>  1 file changed, 1 insertion(+)

The change log should be after "---" line so that git-am can discard it
automatically. Now the changelog would be part of git commit log and we
don't want that.

So please submit v3.

-- 
Kalle Valo
