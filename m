Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE44C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B6220652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfAPVrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:47:03 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:11682 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731045AbfAPVrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:47:02 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 7BE61A103C;
        Wed, 16 Jan 2019 22:47:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id vh8zgT24wPuH; Wed, 16 Jan 2019 22:46:59 +0100 (CET)
Subject: Re: [PATCH 3/3] net: dsa: lantiq_gswip: drop bogus drvdata check
To:     Johan Hovold <johan@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190116102335.30433-1-johan@kernel.org>
 <20190116102335.30433-4-johan@kernel.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <09e235a0-721a-cb78-9354-7e14b8c6748c@hauke-m.de>
Date:   Wed, 16 Jan 2019 22:46:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190116102335.30433-4-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 11:23 AM, Johan Hovold wrote:
> The platform-device driver data is set on successful probe and will
> never be NULL on remove (or we have much bigger problems).
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  drivers/net/dsa/lantiq_gswip.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
