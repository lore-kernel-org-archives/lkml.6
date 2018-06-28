Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD86C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB612733E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="drkdmuN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB612733E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935139AbeF1MQb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:16:31 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:53671 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934923AbeF1MQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:16:28 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8262725B7A3;
        Thu, 28 Jun 2018 22:16:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1530188186; bh=M3+Zz0QuiPVpADI39lfn6g1gJpgJAI08NLEhd+1f6ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=drkdmuN4qSCvHastcswytlcTcL/z9PAIDhpQ8+6v6CyrXDlpOUoFdqYsa+Ykrh72k
         2Zyg/cmvEjU82+1bs/9EZe5RgxJ+GkicAGCh34g4lSoZOLnMUE6WvafjJ+PhExJ+2C
         SFHczt2vn0t8TBmMtPLAECY+HNgC0fCesZ5D0mm8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 73C27940760; Thu, 28 Jun 2018 14:16:24 +0200 (CEST)
Date:   Thu, 28 Jun 2018 14:16:24 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/5] ARM: dts: Renesas RZN1D-DB Board base file
Message-ID: <20180628121623.tncutbj6hrh2ccya@verge.net.au>
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528973829-25493-5-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528973829-25493-5-git-send-email-michel.pollet@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:56:33AM +0100, Michel Pollet wrote:
> This adds a base device tree file for the RZN1-DB board, with only the
> basic support allowing the system to boot to a prompt. Only one UART is
> used, with only a single CPU running.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, applied.
