Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED0CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75ED82177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfA1UKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:10:19 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60955 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1UKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:10:19 -0500
X-Originating-IP: 86.202.150.119
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr [86.202.150.119])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id F0EB51BF203;
        Mon, 28 Jan 2019 20:10:14 +0000 (UTC)
Date:   Mon, 28 Jan 2019 21:10:14 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Zhou Yanjie <zhouyanjie@zoho.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        a.zummo@towertech.it, robh+dt@kernel.org, paul.burton@mips.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: Re: Add Ingenic X1000 RTC support.
Message-ID: <20190128201014.GB18309@piout.net>
References: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This seems like a useless renaming to me, can you elaborate a bit more?

I'd also like to have Paul and Lars-Peter comment.

On 29/01/2019 01:29:56+0800, Zhou Yanjie wrote:
> Add Ingenic X1000 RTC support.
> 
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
