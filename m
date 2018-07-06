Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ED6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF5622BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfu3aFDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF5622BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934327AbeGFUrW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933833AbeGFUrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:47:20 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB5522BD2;
        Fri,  6 Jul 2018 20:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530910040;
        bh=CGB+SGFOu3JZxHjDtKMZbWCLnt1hS3UTa0GexaTYeQQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=kfu3aFDyOUnZ+0gGJoyjNVBk/6K2W19VUDQ6GZf9/nYQPZiGqfjawl/JDVMyGEj3F
         LzjdT2AGLamYG/02OOskuhhEOlKy/NVJFnWZ4AjTCeiukhvThdfmywMYABBE/0eAoN
         FMlzvXF1nnbhbCvD4ezsHZ5EUHZLcvAd0BpJn5Wo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Faiz Abbas <faiz_abbas@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180705142319.19583-3-faiz_abbas@ti.com>
Cc:     mark.rutland@arm.com, paul@pwsan.com, tony@atomide.com,
        faiz_abbas@ti.com, t-kristo@ti.com, robh+dt@kernel.org,
        bcousson@baylibre.com
References: <20180705142319.19583-1-faiz_abbas@ti.com>
 <20180705142319.19583-3-faiz_abbas@ti.com>
Message-ID: <153091003956.143105.6661322668517577461@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 2/6] clk: ti: dra7: Add clkctrl clock data for the mcan clocks
Date:   Fri, 06 Jul 2018 13:47:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Faiz Abbas (2018-07-05 07:23:15)
> Add clkctrl data for the m_can clocks and register it within the
> clkctrl driver
> =

> Acked-by: Rob Herring <robh@kernel.org>
> CC: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

but Tero should ack it too.

