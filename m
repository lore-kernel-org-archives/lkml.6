Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C65C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577FD21754
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL0GxYNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577FD21754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeH0K2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbeH0K2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:28:05 -0400
Received: from dragon (unknown [45.56.155.152])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86177216FA;
        Mon, 27 Aug 2018 06:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535352168;
        bh=U/75FVIW38uQdHTUZigmIjWoayVAW1EfXtMaxJ0kf8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZL0GxYNcseOV4qlWtorKkZ9uvytvQX8D8xtxTgSlSjU/jrfJIsK2UldjnNumT6M8V
         LE/uy3TwJ1LVc2lBNCviszgpJw3Latge78iHT8QzetAaNhfIfX+qOh7y157PJYCYU/
         WYkQdoswScjeU8CvP7jo4uPx4aAoDs0fabVH30p8=
Date:   Mon, 27 Aug 2018 14:41:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx: Switch Engicam boards to use SPDX
 identifier
Message-ID: <20180827064152.GC3850@dragon>
References: <20180807070838.24685-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807070838.24685-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 12:38:36PM +0530, Jagan Teki wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Also added Engicam Copyright on missing files.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied all, thanks.
