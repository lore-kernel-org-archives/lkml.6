Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBEEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649EA2170B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyYpW6tI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649EA2170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeH0JAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbeH0JAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:00:00 -0400
Received: from localhost (unknown [106.200.197.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C90A20C51;
        Mon, 27 Aug 2018 05:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535346898;
        bh=1G/1biGqj8Ja1t2gJIfpTh6FPYc9yhMY7ZPPmgod0ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DyYpW6tIf8ijCUvhKH6tILTu7c/1MAXokIv14Vrz6O4IvWbufi4Rnw22uOtHiq+tE
         NitT0gtl6kpxbsp0TjZIsu9Qbp3RS/5411NQ4PxGQgmNMW5aPIXifb4cWfGeYB+TcN
         SuzAFkB8taspMZomQvPIATlbJMxRQ9MwhwKg5OS0=
Date:   Mon, 27 Aug 2018 10:44:50 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v4 00/18] JZ47xx DMA patchset v4
Message-ID: <20180827051450.GS2388@vkoul-mobl>
References: <20180807114218.20091-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807114218.20091-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-08-18, 13:42, Paul Cercueil wrote:
> Hi,
> 
> This is the V4 of my Ingenic JZ47xx DMA patchset.

This does not apply for me. Please rebase on rc1, fix Rob's and my
comment and send

Also I noticed checkpatch gave warns on some style issues (--strict
option) please see if they make sense and fix if it does.

Thanks
-- 
~Vinod
