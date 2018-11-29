Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B85FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C002621104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvTkL9Cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C002621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeK2SzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbeK2SzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:55:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F00B621019;
        Thu, 29 Nov 2018 07:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543477853;
        bh=lregHQvNFCWsKHLimj37GuYkaUS7fxKf4QwCjk52vkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvTkL9CqV/Kq4JlkQMfh+2gjzqgc8b0qd1PcppnCBDFj9rM766RzxkU7+1949CcZa
         f0I9ZFThCxnOuIfkMFPkkPWkAr89GeE3D6MhDC1tC6vINHyqSeKz+Zlfn/2Zc+lKJZ
         Kwqq3oW3kf89utG7l1LpcC0y2ExqYd4lYD+7sjPA=
Date:   Thu, 29 Nov 2018 08:50:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     adam@adamwong.me
Cc:     dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com,
        kt.liao@emc.com.tw, dshanty@protonmail.com, robh@kernel.org,
        jackxviichaos@gmail.com, ben.hutchings@codethink.co.uk,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: mouse: elan_i2c_core: Added support for ELAN0621
 touchpad.
Message-ID: <20181129075051.GF12347@kroah.com>
References: <20181128212001.20839-1-adam@adamwong.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128212001.20839-1-adam@adamwong.me>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 04:20:01PM -0500, adam@adamwong.me wrote:
> From: TheWongGuy <adam@adamwong.me>

This name, does not match:

> Signed-off-by: Adam Wong <adam@adamwong.me>

That name :(

Please fix.

thanks,

greg k-h
