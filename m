Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64096ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23EE214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="KBMe/8gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23EE214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeIQMiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:38:46 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:36150 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeIQMip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:38:45 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 2B8E025B814;
        Mon, 17 Sep 2018 17:12:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1537168359; bh=9OJdPEEE7Pi5QZqymSLnMovOC97WpK4XIRx8xfy9bA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBMe/8gjmNyNSNuyCLf9LfSxKdm5HJUfgwel3ZIQncEbv8FvLD8eRdEDnWB4uqvgU
         CZ58YyDkMiGACCdZ3jL9GUzeQ3xNKLMJ5NPU0yIGXBkKRdB6TNGfwZ8WfNQGyWb6ng
         McfUU5vUAGda0+edcJSnQsCYWAZ5V7SY1qV6jcEY=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id EA3A3940480; Mon, 17 Sep 2018 09:12:36 +0200 (CEST)
Date:   Mon, 17 Sep 2018 09:12:36 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable R8A774C0 SoC
Message-ID: <20180917071236.ldhp64ei7et7kuib@verge.net.au>
References: <1536760371-17300-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536760371-17300-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 02:52:50PM +0100, Fabrizio Castro wrote:
> Enable the Renesas RZ/G2E (R8A774C0) SoC in the ARM64 defconfig.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch applies on top of next-20180912

Thanks, applied to the arm64-defconfig branch of the renesas tree for v4.20.
