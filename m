Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7D6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652B320672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544688365;
	bh=g2mI5rkFhb/AhqwfrRzny8HFLs/+Q/ABCp6gWFu1usg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xWIQPS2N7e1hNQ9wYGwFJf3AajGSajBuCe92dzRN5pJkFNBa2Ofq+na3qQEVzK7ht
	 gZMnDSUPTCXaVIbNVlS0TIG7Ff0ZyVzOJlCfv7p73bqXCuiwOvo44Vj9Ls8ztMblIX
	 lh3f/+yqW3mHFJ3Im0Zhz0gXdOagHC69aC1GE++M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652B320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeLMIGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:06:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeLMIGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:06:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37AC020672;
        Thu, 13 Dec 2018 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544688359;
        bh=g2mI5rkFhb/AhqwfrRzny8HFLs/+Q/ABCp6gWFu1usg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGWn0aiOmEcw1ditjoFnFdYC54ZLiuBKDmZPIP0NeOvTo1F6OqaqXTB1T+4dfOs9S
         Yl6iOL1MrIMXh+MUIkCa8DbsgSWCythtaLFP3/LmYdLHHJVSDztQDJC/L0VHRHuG25
         8WIB1DKC2xmORVE24HLEaEZ+NsoC+iwZoWfidHWE=
Date:   Thu, 13 Dec 2018 09:05:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     scott@labau.com.tw
Cc:     young@labau.com.tw, jocelyn@labau.com.tw,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: pl2303: add ids for Hewlett-Packard HP POS pole
 displays
Message-ID: <20181213080557.GA2051@kroah.com>
References: <1544681288-26067-1-git-send-email-scott@labau.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544681288-26067-1-git-send-email-scott@labau.com.tw>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 01:08:08AM -0500, scott@labau.com.tw wrote:
> From: scott <scott@labau.com.tw>
> 
> Add device ids to pl2303 for the HP POS pole displays:
> LM920:   03f0:026b
> TD620:   03f0:0956
> LD960TA: 03f0:4439
> LD220TA: 03f0:4349
> LM940:   03f0:5039
> 
> Signed-off-by: scott <scott@labau.com.tw>

I doubt you sign legal paperwork with just that single name :)

We need a full name here, and in the From: line.  Please fix up and
resend.

thanks,

greg k-h
