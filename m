Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21F5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACFA2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfxEaInm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACFA2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbeKOIss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbeKOIss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:48:48 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B862145D;
        Wed, 14 Nov 2018 22:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542235418;
        bh=KOBzcogoZDpWQ8X3NZkKMWjsmBn48oUPJqU192w0G/Q=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=YfxEaInmkxdNSfKG49pUSZ8MvMpe6lEPEBUMFPrDaTYDT60id/azFIzg78iLp8fA3
         XtWh87KZwqeUkQZBT7kuG+JGc9gYymrcrqVLnXZJarLbR/5r3MXB24k71JD9HZO1C2
         rlrLnBAO59t1ZGKwdakCoTDwn377Sl0lRlVHhB3k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Eric Anholt <eric@anholt.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1541862755-7034-1-git-send-email-stefan.wahren@i2se.com>
Cc:     linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Simon Arlott <simon@arlott.org>,
        Stephen Warren <swarren@wwwdotorg.org>
References: <1541862755-7034-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <154223541729.88331.3739552122757159999@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 04/17] clk: bcm2835: Switch to SPDX identifier
Date:   Wed, 14 Nov 2018 14:43:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stefan Wahren (2018-11-10 07:12:35)
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> =

> Cc: Simon Arlott <simon@arlott.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied to clk-next

