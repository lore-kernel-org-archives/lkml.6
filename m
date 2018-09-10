Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD42C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE88206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE88206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeIJNMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:12:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeIJNMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:12:23 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 164FACD9;
        Mon, 10 Sep 2018 08:19:32 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:19:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH 1/1] staging:rtl8192u: Rename dot11d_init to fix name
 clash
Message-ID: <20180910081929.GB31344@kroah.com>
References: <20180904105623.15797-1-johnfwhitmore@gmail.com>
 <20180904105623.15797-2-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904105623.15797-2-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 11:56:23AM +0100, John Whitmore wrote:
> The function dot11d_init() was previously renamed to clear a style
> issue. Unfortunately the new name used, dot11d_init(), clashes with
> a sybmol which is exported with the same name. To correct this
> problem the function has been renamed to rtl8192u_dot11d_init().
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>

You forgot a "Reported-by:" tag here.  I'll go add it...

thanks,

greg k-h
