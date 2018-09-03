Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A09C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95FA20857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0FRmxeSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95FA20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeICHGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 03:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbeICHGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 03:06:33 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E3C20841;
        Mon,  3 Sep 2018 02:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535942910;
        bh=uyGnT///s+MLGZLhfru2bWALEJaMB9RaYelRA1GROPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0FRmxeSMvLXOTAt/Kk4/orz2rG2yMuLNuyDzBchXJGwNPBYgZrqdSTMEpI8+XKPuA
         m2CFTPVdV1wluQqZtHBxMRK/18P1OQxU0TREZM6zAY4E09IT27JXgTfWNZGUaune3k
         d8rS6yL1L1yczDzq5NapjzcIQjG5GsNDweYTek0c=
Date:   Mon, 3 Sep 2018 10:47:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls208xa: add second duart
Message-ID: <20180903024721.GH3850@dragon>
References: <20180830090038.6956-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830090038.6956-1-kurt@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:00:38AM +0200, Kurt Kanzenbach wrote:
> The NXP LS208xA SoCs have two dual uarts. Thus, add the second one.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Applied, thanks.
