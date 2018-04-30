Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbeD3Kfp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:35:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41230 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeD3Kfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:35:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E82160556
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rt2x00: fix spelling mistake in various macros, UKNOWN -> UNKNOWN
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180418114750.1978-1-colin.king@canonical.com>
References: <20180418114750.1978-1-colin.king@canonical.com>
To: Colin Ian King <colin.king@canonical.com>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180430103541.C860C60556@smtp.codeaurora.org>
Date: Mon, 30 Apr 2018 10:35:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Rename several macros that contain mispellings of UNKNOWN
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Stanislaw Gruszka <sgruszka@redhat.com>

Patch applied to wireless-drivers-next.git, thanks.

cc282a0c5f08 rt2x00: fix spelling mistake in various macros, UKNOWN -> UNKNOWN

-- 
https://patchwork.kernel.org/patch/10348023/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
