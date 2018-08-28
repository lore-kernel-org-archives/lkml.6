Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C41C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA8C2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pDxM2wJx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ds+q4EWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA8C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeH1RgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:36:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeH1RgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:36:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B3556602AE; Tue, 28 Aug 2018 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535463858;
        bh=2RRFAGZH5/4Y6UF7wqEnvXqlwAj7qNUXzIBfGhosu38=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pDxM2wJxoTuFetJIFuVdu7IoLKUx7yEHX9WCwF93zqXpfD4Zqb/RQJ96NebVaDi38
         Zv4d8igRNWjPuCTpunDzYJ7QGsaBQJLHdTb6Yhw9FFG85GAuNV8IvXMiMTx+KB8aY9
         aLVU/38wo3ZspAYgxg1wyjk2hQoBfqfwMFEgkgjU=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6795160388;
        Tue, 28 Aug 2018 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535463858;
        bh=2RRFAGZH5/4Y6UF7wqEnvXqlwAj7qNUXzIBfGhosu38=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ds+q4EWP8tMdBf/FsCvQ24oVPBXC51GBsBb4QLBkS5AzRzE2Lt8oWYahU9PEnGR2N
         LpN3EgZshVgOTTYte7umA99KlVnPxalhCb+HM/+eKfNpQNYZ8kTyFK0TX9mlFufF8d
         FVdGjUBPZ9q5aRjTkmQrW+8QW45wpIs5T68hskX0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6795160388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] net: wireless: ath9k: Remove unnecessary parentheses
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180725185305.4118-1-rvarsha016@gmail.com>
References: <20180725185305.4118-1-rvarsha016@gmail.com>
To:     Varsha Rao <rvarsha016@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Varsha Rao <rvarsha016@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180828134418.B3556602AE@smtp.codeaurora.org>
Date:   Tue, 28 Aug 2018 13:44:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Varsha Rao <rvarsha016@gmail.com> wrote:

> Remove extra parentheses to fix the clang warning of extraneous
> parentheses.
> 
> Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

bf05e0fe7da4 ath9k: Remove unnecessary parentheses

-- 
https://patchwork.kernel.org/patch/10544571/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

