Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D216C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3A32077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iC+JnTfl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QYkCcZ1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3A32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeHaTux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:50:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHaTuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:50:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F51D60452; Fri, 31 Aug 2018 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535730168;
        bh=dpZ7M3siXLRUAkSXXifcX6YjznI5/tT2aj+z/4TCcIo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=iC+JnTflQQk6krfLp/D+KCR1OI4qXQE4R4T2fO3etrFb9aGWX3qnR0Vbnp7/Rg51I
         v3KFo21XemxlxY3U6sGEpX4pN5wNUrLv991bVdyAZFbc4+d7Bgu0nu29JoGJ9mymld
         L5aGo92GQE/ZKJKa5zPg4GPBB2W9bHfaQ/f5RGz4=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DCEF76038E;
        Fri, 31 Aug 2018 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535730167;
        bh=dpZ7M3siXLRUAkSXXifcX6YjznI5/tT2aj+z/4TCcIo=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=QYkCcZ1IicxjacnJYBD4Ly0QCOc6/+9aUzyliomGh/TEc5OmScP7/Vmm68F0R7zi/
         ibST9SMYeuMGvTV3THHxVBmWrKO5OFFmrrnqlRrCD2CKEGcZIaR2IF8S7dP954D4W2
         ZsqHX1O3MxGfpS+WAfCW/oBjKNuTW7mkap4vWftU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCEF76038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] cw1200: Remove extra parentheses
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180725190011.4317-1-rvarsha016@gmail.com>
References: <20180725190011.4317-1-rvarsha016@gmail.com>
To:     Varsha Rao <rvarsha016@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Solomon Peachy <pizza@shaftnet.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Varsha Rao <rvarsha016@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180831154248.7F51D60452@smtp.codeaurora.org>
Date:   Fri, 31 Aug 2018 15:42:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Varsha Rao <rvarsha016@gmail.com> wrote:

> Remove unnecessary parentheses to fix the extraneous parentheses clang
> warning.
> 
> Signed-off-by: Varsha Rao <rvarsha016@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

057118edfc36 cw1200: Remove extra parentheses

-- 
https://patchwork.kernel.org/patch/10544575/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

