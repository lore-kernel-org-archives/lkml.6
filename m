Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEE3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598392084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DgMFPkGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598392084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbeH2RJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:09:28 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46344 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeH2RJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=1SqDzueHWSIQ7Q85LTOkoCB5FrKE2Vb/O2P3t8fLsr8=;
        b=DgMFPkGFeBnKGQ0mPTBQpUQPq7eEuYJIGtR3EPQtjmjH9aC1Cpo9AO/Z74fZfo9xeEnugwsDF+SSUPaayiUmyb1TApuLAq0hvmTReLUWLmYJDMjx5LvEuP1nhQL4mE/qhW/kQCTzYyXEkxeFQhqBhdUsjhCGb8JFbpEgJn2ACyQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fv0Gu-0000tB-3M; Wed, 29 Aug 2018 15:12:32 +0200
Date:   Wed, 29 Aug 2018 15:12:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     thomas.petazzoni@bootlin.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] net: mvneta: some bug fix and trivial improvement
Message-ID: <20180829131232.GE1955@lunn.ch>
References: <20180829162456.2bd69796@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829162456.2bd69796@xhacker.debian>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng

Please separate fixes from new features.

Fixes should be based on DaveM net branch, and use the subject line
[PATCH net]...

New features should be based on DaveM net-next branch, and use the
subject line [PATCH net-next]...

	Thanks
		Andrew
