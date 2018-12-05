Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A55C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30423206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30423206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeLEKZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:25:47 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:34330 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeLEKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:25:46 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 438vyJ5v7wz1qw0L;
        Wed,  5 Dec 2018 11:25:44 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 438vyJ4lt6z1qrnF;
        Wed,  5 Dec 2018 11:25:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ZDAnjMt9Dat4; Wed,  5 Dec 2018 11:25:43 +0100 (CET)
X-Auth-Info: FZNqOCBI+gy5rToEwg5DmERTTwWP61zym6Em0+7z/bE=
Received: from crub (p508DE362.dip0.t-ipconnect.de [80.141.227.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  5 Dec 2018 11:25:43 +0100 (CET)
Date:   Wed, 5 Dec 2018 11:25:43 +0100
From:   Anatolij Gustschin <agust@denx.de>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        atull@kernel.org, mdf@kernel.org
Subject: Re: [PATCH v3 2/3] spi: add FTDI MPSSE SPI controller driver
Message-ID: <20181205112543.33e167e4@crub>
In-Reply-To: <20181127175438.16116-3-agust@denx.de>
References: <20181127175438.16116-1-agust@denx.de>
        <20181127175438.16116-3-agust@denx.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, 27 Nov 2018 18:54:37 +0100
Anatolij Gustschin agust@denx.de wrote:

>Add SPI bus controller driver for FTDI MPSSE mode. This driver
>is supposed to be used together with the FT232H interface driver
>for FPGA configuration in drivers/usb/misc/ft232h-intf.c which
>adds an mpsse spi platform device describing USB SPI bus with
>attached SPI slave devices.

I suppose this patch should go via Greg's usb tree as part of the
series, once acked. I've addressed comments in v3, is it okay now?

Thanks,
Anatolij
