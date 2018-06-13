Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C6A52C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA8F208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="bhUTs33V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA8F208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936056AbeFMQEs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:04:48 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:42835 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935977AbeFMQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FUb1hqAHOazpZmg5nd1LgmfEQDd8lP4ZNz9nbMP/qjA=; b=bhUTs33VskBTeFZvxmrZXLyiGo
        9RcAh9UcenEOpKqkTyxqZQotmm95zo7yEfa5zqyqVZ+8LLuWeM4QK5AIdfIGU7UtjdqgLfeAO5gz3
        CEZhQE9b+QHze4OG8MxEecdWzblvAJXok5bKZAANPRMf7XQ/+t9yZUf6NpxWw94V13mdIP6dMJiUY
        iEEvG6yX3xYfdWQps7UvwHLBK/1ytB3zLjPfjlMYkbXREdTFbhPjjqrp32zBc+U6JGx40s6FPK8UX
        f54scmRWx2jA6CbJ5kvApGRPANrkWeAp/D+ICzwkXTgfeCzaKZ2J2lcUjTl8CyZcO9YWNHulMoIdY
        KfVbTM6A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58294 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fT8G7-004Dr6-7v; Wed, 13 Jun 2018 16:04:31 +0000
Date:   Wed, 13 Jun 2018 09:04:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jakob Albert <jakob.j.albert@fau.de>
Cc:     devel@linuxdriverproject.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenz Kaestle <lorenz.kaestle@fau.de>,
        linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH v2 0/3] hwmon: (nct7904) Fix style issues
Message-ID: <20180613160430.GA11640@roeck-us.net>
References: <1528902805-21474-1-git-send-email-jakob.j.albert@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528902805-21474-1-git-send-email-jakob.j.albert@fau.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:13:22PM +0200, Jakob Albert wrote:
> This set of patches fixes style errors reported by checkpatch.pl. This
> adapts the code to the coding style.
> 
> Changes since v1:
> * Changed patch subjects and descriptions
> 
> 
> 
> Jakob Albert (3):
>   hwmon: (nct7904) Fix SPACING errors
>   hwmon: (nct7904) Fix CODE_INDENT error
>   hwmon: (nct7904) Fix UNSPECIFIED_INT warning
> 

Series applied to hwmon-next.

Thanks,
Guenter
