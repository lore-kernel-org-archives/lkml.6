Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EDAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F41E21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548667865;
	bh=8pE31qs1n6Gad1iZk9eDBc/v/HFhm7sP1o6WYwKn88M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hi6HMEzhkRJSllhziI8eW7cR4SO5oxWsXNKV/H6cXT9iI3Z0fd7MMlqoFrQrC/aJM
	 bl6KzDD6XfW+b6lAKFBmrVMlvOxIRCewxW6TVv0zUdGBVeEVjZFgo5LHuXSTMu5BKk
	 ebK762pcrN+nLrfz+03no0f9pDeOpot1IJxDkLhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfA1JbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:31:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfA1JbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:31:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0480C20880;
        Mon, 28 Jan 2019 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548667862;
        bh=8pE31qs1n6Gad1iZk9eDBc/v/HFhm7sP1o6WYwKn88M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7Vk+fG327DceGU7K+7vUGgYatfTEq+ZOr7dHNBDzy1aVPviUyrQ2nIaSH1pkY1mp
         nTq8wtgDXDpoZgNpEi79LYosTCnYDZjZJEztCeGPwPe0ro0P8iiwX9KzA3L4/cRiUD
         tP+re6K9iTJgiO3clEAb+LxJSKjMU26FWKjZQwk4=
Date:   Mon, 28 Jan 2019 10:30:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: Re: [PATCH 1/2] Serial: Ingenic: Add support for the X1000.
Message-ID: <20190128093059.GA31657@kroah.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:19:35PM +0800, Zhou Yanjie wrote:
> Add support for probing the 8250_ingenic driver on the
> X1000 Soc from Ingenic.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  drivers/tty/serial/8250/8250_ingenic.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

You sent two different patches with the same subject: line, yet they did
totally different things.

Please fix this up and resend with a better set of subject lines.

thanks,

greg k-h
