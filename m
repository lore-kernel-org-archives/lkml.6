Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258BEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8127A224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8127A224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeKMJDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:03:44 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:48996 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeKMJDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:03:44 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42v5yw2sqJz1qvwJ;
        Tue, 13 Nov 2018 00:08:24 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42v5yw2SKGz1qr2P;
        Tue, 13 Nov 2018 00:08:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Aam61KEonSFo; Tue, 13 Nov 2018 00:08:23 +0100 (CET)
X-Auth-Info: 19jjPQ9/J9LK16fQ1ZaOK75qa0LVgHyryK/nLILwvXY=
Received: from crub (p5088702D.dip0.t-ipconnect.de [80.136.112.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 13 Nov 2018 00:08:23 +0100 (CET)
Date:   Tue, 13 Nov 2018 00:08:23 +0100
From:   Anatolij Gustschin <agust@denx.de>
To:     capetry.dev@gmail.com
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fpga: altera-cvp: Insert SPDX-License-Identifier
Message-ID: <20181113000823.04df5a7a@crub>
In-Reply-To: <20181108011312.29587-2-capetry.dev@gmail.com>
References: <20181108011312.29587-1-capetry.dev@gmail.com>
        <20181108011312.29587-2-capetry.dev@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 23:13:11 -0200
capetry.dev@gmail.com capetry.dev@gmail.com wrote:
...
>diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>index 610a1558e..45b7c8c0b 100644
>--- a/drivers/fpga/altera-cvp.c
>+++ b/drivers/fpga/altera-cvp.c
>@@ -1,3 +1,4 @@
>+// SPDX-License-Identifier: GPL-2.0

when SPDX identifier is in place, shouldn't the GPL boilerplate below
be removed?

Anatolij
