Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F84EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4815320989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4815320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeLEKAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:00:24 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:34711 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbeLEJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:50:16 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 438v9L0L8hz1qwBs;
        Wed,  5 Dec 2018 10:50:14 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 438v9K6j0Lz1qrnh;
        Wed,  5 Dec 2018 10:50:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id en4AMrb1qkYx; Wed,  5 Dec 2018 10:50:13 +0100 (CET)
X-Auth-Info: N+cS8wxj1rbgWRO8hJDuD4Bk3pIAad2C2cJQUviV8mg=
Received: from crub (p508DE362.dip0.t-ipconnect.de [80.141.227.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  5 Dec 2018 10:50:12 +0100 (CET)
Date:   Wed, 5 Dec 2018 10:50:08 +0100
From:   Anatolij Gustschin <agust@denx.de>
To:     atull@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org, mdf@kernel.org
Subject: Re: [PATCH v3 3/3] fpga: Add fpga manager driver for ARRI Altera
 FPP
Message-ID: <20181205105008.4a32956c@crub>
In-Reply-To: <20181127175438.16116-4-agust@denx.de>
References: <20181127175438.16116-1-agust@denx.de>
        <20181127175438.16116-4-agust@denx.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, 27 Nov 2018 18:54:38 +0100
Anatolij Gustschin agust@denx.de wrote:

>Add FPGA manager driver for loading ARRI Altera FPGAs via fast
>passive parallel (FPP) interface using FTDI FT232H chip.

Ping. Is this patch okay? I suppose that it will go via usb tree
as part of the whole series (you send fpga driver patches to Greg
anyway). Can you ack this patch or is there something that should
be changed? I'd like to see it merged in v4.21, so if there are
issues with this patch, I'll try to address it before it is to late.

Thanks,
Anatolij
