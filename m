Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192E6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02AE20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02AE20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632744AbeKXCOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:14:32 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:42023 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436632AbeKXCOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:14:31 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 431gGl5v6Mz1qvvr;
        Fri, 23 Nov 2018 16:29:51 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 431gGl3Pk6z1rJpf;
        Fri, 23 Nov 2018 16:29:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id WHtNaEiodq41; Fri, 23 Nov 2018 16:29:50 +0100 (CET)
X-Auth-Info: MsO8wfJewdGYFKBqDdfuWNNHtI+sEwSaZtOarX/AB7U=
Received: from crub (p5088702D.dip0.t-ipconnect.de [80.136.112.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 23 Nov 2018 16:29:50 +0100 (CET)
Date:   Fri, 23 Nov 2018 16:29:49 +0100
From:   Anatolij Gustschin <agust@denx.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org, atull@kernel.org,
        mdf@kernel.org, kbuild-all@01.org
Subject: Re: [PATCH] usb: misc: fix boolconv.cocci warnings
Message-ID: <20181123162949.0ca117d0@crub>
In-Reply-To: <20181123151054.GA18175@kroah.com>
References: <alpine.DEB.2.21.1811211832430.2779@hadrien>
        <20181123151054.GA18175@kroah.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 16:10:54 +0100
Greg KH gregkh@linuxfoundation.org wrote:
...
>> Fixes: 0772a5bf580c ("usb: misc: add driver for FT232H based FPGA configuration devices")  
>
>I can't find this commit anywhere, nor the file that this patch touches.
>
>What tree is it in?

This new driver was submitted to the lists and is not in mainline
tree yet. It was committed to some tree for build testing the
submitted patches, it seems.

Thanks,

Anatolij
