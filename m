Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B449C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545CC2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBGIUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:20:51 -0500
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:44079 "EHLO
        7.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfBGIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:20:51 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2019 03:20:50 EST
Received: from player731.ha.ovh.net (unknown [10.109.146.19])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id C073A11538A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Feb 2019 08:42:59 +0100 (CET)
Received: from etezian.org (81-175-223-118.bb.dnainternet.fi [81.175.223.118])
        (Authenticated sender: andi@etezian.org)
        by player731.ha.ovh.net (Postfix) with ESMTPSA id 22FA1258A535;
        Thu,  7 Feb 2019 07:42:52 +0000 (UTC)
Date:   Thu, 7 Feb 2019 09:42:51 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Andi Shyti <andi@etezian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: tm2-touchkey - acknowledge that setting
 brightness is a blocking call
Message-ID: <20190207074251.GB3721@jack.zhora.eu>
References: <20190206181616.GA204279@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206181616.GA204279@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 16249831883786142362
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeelgddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, Feb 06, 2019 at 10:16:16AM -0800, Dmitry Torokhov wrote:
> We need to access I2C bus when switching brightness, and that may block,
> therefore we have to set stmfts_brightness_set() as LED's
> brightness_set_blocking() method.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

same here:

Acked-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
