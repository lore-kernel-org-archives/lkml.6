Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA34AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9482020818
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfBGILx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:11:53 -0500
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:52397 "EHLO
        8.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfBGILw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:11:52 -0500
X-Greylist: delayed 2100 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2019 03:11:52 EST
Received: from player750.ha.ovh.net (unknown [10.109.146.32])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5C6E1152623
        for <linux-kernel@vger.kernel.org>; Thu,  7 Feb 2019 08:36:51 +0100 (CET)
Received: from etezian.org (81-175-223-118.bb.dnainternet.fi [81.175.223.118])
        (Authenticated sender: andi@etezian.org)
        by player750.ha.ovh.net (Postfix) with ESMTPSA id 626BB28D3A3D;
        Thu,  7 Feb 2019 07:36:45 +0000 (UTC)
Date:   Thu, 7 Feb 2019 09:36:44 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Andi Shyti <andi@etezian.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: stmfts - acknowledge that setting brightness is a
 blocking call
Message-ID: <20190207073644.GA3721@jack.zhora.eu>
References: <20190205224642.GA182156@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205224642.GA182156@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 16146249089766572698
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeelgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Feb 05, 2019 at 02:46:42PM -0800, Dmitry Torokhov wrote:
> We need to turn regulators on and off when switching brightness, and
> that may block, therefore we have to set stmfts_brightness_set() as
> LED's brightness_set_blocking() method.
> 
> Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Andi Shyti <andi@etezian.org>

Thanks,
