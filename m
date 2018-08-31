Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674EAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DA42083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do8VWefp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DA42083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeHaWFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeHaWFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:05:15 -0400
Received: from localhost (unknown [104.132.0.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6CD02083E;
        Fri, 31 Aug 2018 17:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535738199;
        bh=jw8ZT2/hzccJfCeRpzevj0nKMl/gKk85QD4DWFFxztQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Do8VWefpSTaQG2Sx88aOZKoGupNwcUPoXePUVMqYRriNwa8eCqEJvVTZirAksVEXh
         lNk+lt8gbhUrHkJrrsvtGorZDUP+E3ai3gxxbv7cKtnFfX1GWOmNbddexu2F+HDRG0
         q5PZ0eidbrfvnea0KE2XVvtmQzD/7d+xz8EFUjuQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1535576973-8067-3-git-send-email-eajames@linux.vnet.ibm.com>
Cc:     linux-media@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, andrew@aj.id.au, mchehab@kernel.org,
        joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org,
        Eddie James <eajames@linux.vnet.ibm.com>
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1535576973-8067-3-git-send-email-eajames@linux.vnet.ibm.com>
Message-ID: <153573819934.93865.9948361566635476864@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/4] clock: aspeed: Setup video engine clocking
Date:   Fri, 31 Aug 2018 10:56:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eddie James (2018-08-29 14:09:31)
> Add the video engine reset bit. Add eclk mux and clock divider table.
> =

> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

