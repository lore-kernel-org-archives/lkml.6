Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VBYAKOQfHlurSAAAmS7hNA
	; Mon, 11 Jun 2018 07:09:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C536A60792; Mon, 11 Jun 2018 07:09:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOh5W3a0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 526B0601D2;
	Mon, 11 Jun 2018 07:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 526B0601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeFKHJY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753981AbeFKHJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:09:22 -0400
Received: from localhost (unknown [62.177.166.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8235208AE;
        Mon, 11 Jun 2018 07:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528700962;
        bh=6U6hW/Y7Y2mZxFwx1GhhFTMICjBrsGtCABbhn+feE0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nOh5W3a0tNI7NRfvVtjwIGof9eyo79a7rZPrHmd0WG+XJy768lirG/gU1NZ/VhpUY
         UyZQ0fPL3JGD/xBAzTIVOqDyr3uZpfNasl6JJDTrf4+UHCoM7w2QAs3+jrXtZIHm9z
         6x4ivrEGBdpNO20z+t7/TyclZbh4qF6mtKiHj4D0=
Date: Mon, 11 Jun 2018 09:08:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/8] usb: pd: include kernel.h
Message-ID: <20180611070859.GB9472@kroah.com>
References: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
 <20180608112941.26332-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608112941.26332-2-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:29:34PM +0300, Heikki Krogerus wrote:
> Some of the macros use le16_to_cpu().

What macros?

Is this causing build errors today?  If so, why should it not be
included now?

thanks,

greg k-h
