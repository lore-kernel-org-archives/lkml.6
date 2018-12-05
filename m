Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D47AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47C320850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQa4P1G8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47C320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeLEIoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbeLEIoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:44:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60E59206B7;
        Wed,  5 Dec 2018 08:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543999476;
        bh=U5dEiwIZfR5FxEhcerf3luDIYZHBfDuuh1o9maX2vRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQa4P1G8eUtsfXV8mSQkXutdRktM16cmhkwiDi9Zx8yEtXx1szvrqtueKw07P5cEb
         O6ibfHrsPyK5S44MEOUDmVOo1iLrQqP5+W7jU7V/Ud2rG3DGpW7dDTNiY+XwXymu5T
         Vcsi28C/qj0NHmU1vkCGO9sDqPXpDE28sVnVPwdI=
Date:   Wed, 5 Dec 2018 09:44:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Carmeli Tamir <carmeli.tamir@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: emxx_udc: Align parameter with parenthesis
Message-ID: <20181205084434.GA29477@kroah.com>
References: <1543274351-25762-3-git-send-email-sicilia.cristian@gmail.com>
 <1543352237-1978-1-git-send-email-sicilia.cristian@gmail.com>
 <1543352237-1978-2-git-send-email-sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543352237-1978-2-git-send-email-sicilia.cristian@gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:57:16PM +0100, Cristian Sicilia wrote:
> Align parameters with parenthesis and removed
> open parenthesis at the end of line.
> 
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 270 ++++++++++++++----------------------
>  1 file changed, 107 insertions(+), 163 deletions(-)

This patch did not apply to my tree :(
