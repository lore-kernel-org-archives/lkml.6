Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA37C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9059520872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547198060;
	bh=yI2NegK2AkSzTvDk/Wb3NTiZgE6wVWXmdu2zf7It1dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E37VbPAHqv7r71tqfXvLNLRn9VfUcQxc3MeqchtKDEHQl7cu5XovsVgkVSn37ipWs
	 e9vFyXtDZeQDCMR0E4x2grl/N9YAP8iSdIT3r0Ym0wZO04dlAgrbOCN4KzoryAjAb6
	 LTtRXpBiP9on5Yg/iAna8KIJuqWUsO29tIbcOmU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfAKJOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfAKJOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:14:19 -0500
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D94F720870;
        Fri, 11 Jan 2019 09:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547198058;
        bh=yI2NegK2AkSzTvDk/Wb3NTiZgE6wVWXmdu2zf7It1dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xblN9as92RbNZwfkYdM/FJh+XuYZzmlSjpKcqYnytUWC84ZfH1+zSW7l57uIvFPbB
         2ZAc3U6npQT8wIfFEJLf4hM1KvlGxU6JyVCxB5tGbkaxZR/E/8li0j5Hap4MqRWRF6
         vzY1tizYNDwWYuyeY/4KE/mdcCdMNZEoLarj4Tsw=
Date:   Fri, 11 Jan 2019 17:14:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 1/3] arm64: dts: fsl: use a generic node name
 for m25p80 flashes
Message-ID: <20190111091403.GI32649@dragon>
References: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:07:46PM +0100, Alexandre Belloni wrote:
> Use a generic node name for the m25p80 flashes on ls1043 and ls1046 boards.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied all (not MAINTAINERS patch), thanks.
