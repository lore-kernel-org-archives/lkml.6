Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D15C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E9320872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="apC64aQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E9320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeKKTGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 14:06:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbeKKTGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 14:06:04 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D57BB20818;
        Sun, 11 Nov 2018 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541927882;
        bh=h6vfmF4oZS5rG8wPewu9bXhrSnpZmdP5+9lEcMvFdTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apC64aQa4/69FUgRi6OqRCGGrCX5HuBnzUjKxErAmEkycutBurMUriKQSkRnOPMVV
         rWDr6wwsT6ycBr+Bq77L5yLQRoWhH3EieTA7CnLZdMJBBEx4QdF+clnVID8+7uqZgC
         x9gcrvaJ1xItGLH9uSMOU0AyhA6CM60rvbrRbCFE=
Date:   Sun, 11 Nov 2018 14:47:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
Message-ID: <20181111091754.GA12092@vkoul-mobl>
References: <1534249935-15496-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB17708409052CFB9469856335C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20181108122329.pxxjrmaaxutxxel3@verge.net.au>
 <TY1PR01MB1770C8FE55F27CAAB2A89FB7C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1770C8FE55F27CAAB2A89FB7C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-18, 13:59, Fabrizio Castro wrote:
> Thank you Simon for getting back to me.
> 
> Vinod, does this patch look ok to you?

This does not appear in my queue, please resend and collect the acks
received if any as well

Thanks
-- 
~Vinod
