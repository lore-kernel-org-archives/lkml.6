Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13951C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D113A2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQkoAn5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D113A2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbeKLD3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbeKLD3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:29:49 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC37621104;
        Sun, 11 Nov 2018 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541958039;
        bh=qoPu7fXr+cXHKPPB78QSHdYp7YjnHa3+9mXFj/3IvaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQkoAn5Wae293QaOnTNybY8q/XzHLgwG2VoOPoiJkU2vaYiIpUiGCg0QkO5VtAXsD
         xuPQ39iwbatmJdnL6CFrjc+sHXabRyCYlXnzJP1E52pjt2xcJLWNY1KptYrn1w0J9f
         2hkc40aHN+687nhw8rgnnAm+GolnFeSu2eC61FAY=
Date:   Sun, 11 Nov 2018 09:40:14 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vitor soares <vitor.soares@synopsys.com>
Cc:     boris.brezillon@bootlin.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, arnd@arndb.de, psroka@cadence.com,
        agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com,
        dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com,
        sureshp@cadence.com, rafalc@cadence.com,
        thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        mshettel@codeaurora.org, swboyd@chromium.org,
        joao.pinto@synopsys.com
Subject: Re: [PATCH v3 0/3] Add driver for Synopsys DesignWare I3C master IP
Message-ID: <20181111174014.GA16216@kroah.com>
References: <1541697251-20392-1-git-send-email-soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541697251-20392-1-git-send-email-soares@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 05:14:08PM +0000, Vitor soares wrote:
> This patch series is a proposal for the I3C master driver for Synopsys IP.
> This patch is to be applied on top of I3C subsystem RFC V10 submitted by
> Boris Brezillon.

I'd like to get Boris's reviewed/signed-off on these before I take them.

thanks,

greg k-h
