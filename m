Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C997C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AE32184A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="MvbcP4BG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeLRKMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:12:41 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:53537 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeLRKMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:12:33 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 79C3E25B75B;
        Tue, 18 Dec 2018 21:12:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1545127950; bh=VcqmWhLCzbHaqO/NUY8cRBaC8Ir+e4UoRvF70kNlisI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvbcP4BG/4bHc79TLHEd3mV02Tuxf8UG110CcyC7Q6mg5JmFQqivflPvEc7Mt7unL
         iWlp07fGkKlz07rrQc90gN9DdclD4sAcOSsGfJJo2XU8BX3Z0oPIRLetS0TSh17zP5
         FJ+ElUYa0cW45JWQiRwnpjt1pZN3hifqjrHYLcbU=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B8FCD940274; Tue, 18 Dec 2018 11:12:28 +0100 (CET)
Date:   Tue, 18 Dec 2018 11:12:28 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH 0/9] RZ/G2E basic device tree
Message-ID: <20181218101228.mfo5fd3q4gfft5lt@verge.net.au>
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:10:04AM +0000, Fabrizio Castro wrote:
> Dear All,
> 
> this series adds a basic dtsi for the RZ/G2E (a.k.a. r8a774c0).

Series applied for v4.22. Thanks!
