Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeDXR2b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:28:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57986 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeDXR2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:28:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F05776071A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: mt7601u: phy: mark expected switch fall-through
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180330211223.GA22497@embeddedgus>
References: <20180330211223.GA22497@embeddedgus>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jakub Kicinski <kubakici@wp.pl>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180424172823.754ED60A06@smtp.codeaurora.org>
Date: Tue, 24 Apr 2018 17:28:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Acked-by: Jakub Kicinski <kubakici@wp.pl>

Patch applied to wireless-drivers-next.git, thanks.

5156b054bcda mt7601u: phy: mark expected switch fall-through

-- 
https://patchwork.kernel.org/patch/10318419/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
