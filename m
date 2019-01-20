Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347AFC636A2
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E4220861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="vGvz/A4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfATPEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:04:23 -0500
Received: from node.akkea.ca ([192.155.83.177]:51558 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfATPEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:04:22 -0500
Received: by node.akkea.ca (Postfix, from userid 33)
        id 722E14E204B; Sun, 20 Jan 2019 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1547996662; bh=DxYXAu0vuWUECNVXh5x1ydx8O/cp3oY+010U6gpDSpM=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=vGvz/A4Ei8hE7wjFL7BPvVzaD6wQvvXm2JRnyRQWBmeHEu8LvSRg9nNmKPPlZSxvv
         TsgF70gA+Dgb4pd58l3V2wDvIyLSZRr9b1mrv9fYUdfa5Xe0JoVk419WOuU6WT1bp9
         gjT9RI3tlea8huUsWHlAWi8S8PzkojMf4rhMrl/0=
To:     Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 1/3] dma: imx-sdma: fix NULL pointer de-reference
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 20 Jan 2019 08:04:22 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAEnQRZDzvmn-6YyoQRrWbkbH8d1ej8aFE1wFAiXQtqzHxyW2eA@mail.gmail.com>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190120023150.17138-2-angus@akkea.ca>
 <CAEnQRZDzvmn-6YyoQRrWbkbH8d1ej8aFE1wFAiXQtqzHxyW2eA@mail.gmail.com>
Message-ID: <1bd1b8ad44dc8e1cd65e73111764b94e@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-20 02:54, Daniel Baluta wrote:
> On Sun, Jan 20, 2019 at 4:34 AM Angus Ainslie (Purism) <angus@akkea.ca> 
> wrote:
>> 
>> On the imx8mq I get NULL pointer de-deference errors if the device
>> isn't passed in during allocation.
>> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> 
> Hi Angus,
> 
> I have already sent a fix for this:
> 
> https://patchwork.kernel.org/patch/10758203/

Sorry, I missed that. I'll drop it for V3.

Angus
