Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA94FC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A333B21C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z7CDIHpj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GkK2PxeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A333B21C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbeHIRjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:39:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731178AbeHIRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:39:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A13B60AD8; Thu,  9 Aug 2018 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827669;
        bh=TBPs8Lpn8t7/pZHsdjIEPqBI614XRoevdv0r/yaGeqw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Z7CDIHpjbVK9lF3ExY8EtQ4vKCdsxE6OQQPC22quZUdqMjLzk1GkTgvZgxcN+OMki
         F9Zaiuwq0I7MMnviNaMEKZEHUB7uZYNNeuyMMnR5i050P+YdR6i23RZ/jgjB9zUezw
         lj72X8F6x+QpH0BiGE3/3WrOrI8MKcrP0T76u9lc=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46C2A60807;
        Thu,  9 Aug 2018 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827667;
        bh=TBPs8Lpn8t7/pZHsdjIEPqBI614XRoevdv0r/yaGeqw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=GkK2PxeZjqaS7GLCSP56rwPO2fmqH6CUAFrm+hC4+a5NT1kptEYUGWqbiVMddXzxC
         dBdYBGt5Vg/rf1mRJsz7FK2xMCK89Uk9oxxpk0UhLhrKHEjI4D3QPdoNj0nzCel3CR
         xTps4zzPE1Hk69IMym8BsfkOGRXsGeJStHsI8EQs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46C2A60807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlegacy: fix spelling mistake "acumulative" ->
 "accumulative"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180803134224.2609-1-colin.king@canonical.com>
References: <20180803134224.2609-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180809151429.0A13B60AD8@smtp.codeaurora.org>
Date:   Thu,  9 Aug 2018 15:14:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> fix spelling mistake in rx stats text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Stanislaw Gruszka <sgruszka@redhat.com>

Patch applied to wireless-drivers-next.git, thanks.

26b701adc378 iwlegacy: fix spelling mistake "acumulative" -> "accumulative"

-- 
https://patchwork.kernel.org/patch/10555115/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

