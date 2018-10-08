Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E9C6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BFA20882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLy2y7iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BFA20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeJHKDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHKDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 06:03:05 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A38102086D;
        Mon,  8 Oct 2018 02:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538967219;
        bh=8KPPa0ezFypO+jjO0jIXdZajBKfRIwAS5lWubpn9+qY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=FLy2y7iLAm7GDn9X27ahNCfl5Q82GDZ1n/5BhqslyDSCBDzkOmgy47CSSMkdUMNC0
         J7F/pF2tpLDkV0/ebeLOVHOWqEOFQ1ff/QcUHqALjz4WKDdLRX4bYa9SEkxjGpOyq7
         6D2yKRxYFk0l0loRYPAPrEOrMfF4iIxXhMyt/fw8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181005161126.704214-1-arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20181005161126.704214-1-arnd@arndb.de>
Message-ID: <153896721896.119890.15909768221713438779@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: keystone: add missing MODULE_LICENSE
Date:   Sun, 07 Oct 2018 19:53:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2018-10-05 09:11:15)
> A randconfig build showed that two clk modules have no license tag:
> =

> WARNING: modpost: missing MODULE_LICENSE() in drivers/clk/keystone/gate.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/clk/keystone/pll.o
> see include/linux/module.h for more information
> =

> Add the appropriate information from the comment at the start of the
> two files.
> =

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next

