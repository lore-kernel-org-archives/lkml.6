Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97713C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5898F2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vkqtOB1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5898F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeK3ERa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:17:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbeK3ERa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:17:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D188020863;
        Thu, 29 Nov 2018 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543511486;
        bh=1xFMaz2ELOSE2oe8FWFobwYAE4jnj0z9oIh8MAL2pJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vkqtOB1uFnIbkIt1Xt9uQuHkydWJe97TP0wI1zGG+hgL1rTby3wEIiQM2iI2526dT
         4zPnYZWcDKS3mxo3Y63tAAFPKnl6jwvIpBsVVZkQkehgxdVj0+P32Iihr1312hVt/m
         08YdlFJZ4yRsnCkT2waYLHap17Yy8AiCXEnzIYtk=
Date:   Thu, 29 Nov 2018 18:11:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     adam@adamwong.me
Cc:     dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com,
        kt.liao@emc.com.tw, dshanty@protonmail.com, robh@kernel.org,
        jackxviichaos@gmail.com, ben.hutchings@codethink.co.uk,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: mouse: elan_i2c_core: Added support for ELAN0621
 touchpad.
Message-ID: <20181129171124.GB4651@kroah.com>
References: <20181129163019.4203-1-adam@adamwong.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129163019.4203-1-adam@adamwong.me>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:30:19AM -0500, adam@adamwong.me wrote:
> From: TheWongGuy <adam@adamwong.me>
> 
> Added the ability to detect the ELAN0621 touchpad found in some Lenovo
> laptops.
> 
> Signed-off-by: TheWongGuy <adam@adamwong.me>

I doubt that is the name on your passport :(

Please use your "real" name, like you did for the signed-off-by last
time, just fix up the From: line.

thanks,

greg k-h
