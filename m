Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F96C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1392147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550621439;
	bh=LP44Eu92UZzwF1JD4k4+K7eaNSD3rOSJziapLKoQ0Co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YvnGAwB8u8OtTr3qaUYpcmd5Lpf1IA9aE1a+/SDeyO60/r85QO/Gr9w3HHVdRy1q9
	 CxoVQfFM5VlCvwHh0lY4vkMBmLBpkYKYhPwr8YKJwe8v5y/Wnbfx5WGq6IGwCU71gg
	 ZFq1wn/1+TiPCcSqPu/PCgfgzRtn7kvX4h1bhuL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfBTAKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:10:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfBTAKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nlMqjlLhR6g8TOqMHGBguUwXIC67StiY+gBClZKgbtQ=; b=uHiwQgkT3KqeVOZj7K+Ife87u
        7C0sCZnKPaq3aBF0B9Np4DE44xObJz01uEGgyNdeDhwsk+c+eO/XFJMKYqoIpPK3dk9mNRUNeD9Gi
        MFG9jJw4EtyjsUVYvNLHwoWl92fl8275SvZcdeqwMWc0qUuSen9UWGSq/gM5xadeo1QjIfqbk6RlN
        ddbv1sNAZgKJJNx4bGT/Sce/TDXIhnSFQprVBhqyE46MWBtRTIvWeXGz3gvtAcvutXx6svVb0JLGT
        gAYWH8JaWs4Z6ptzNdq3wY329pheZTV9Oz/N0/wxWdQRYivl8Grt/Uy7aKGPBSyTbYQn5x7zrd6XQ
        ANH3wJvNA==;
Received: from 177.96.194.24.dynamic.adsl.gvt.net.br ([177.96.194.24] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwFTA-0003Jv-PJ; Wed, 20 Feb 2019 00:10:37 +0000
Date:   Tue, 19 Feb 2019 21:10:33 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: please clean up the v4l-dvb-next tree
Message-ID: <20190219211007.4a916a62@coco.lan>
In-Reply-To: <20190220105703.69c9b582@canb.auug.org.au>
References: <20190220105703.69c9b582@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 20 Feb 2019 10:57:03 +1100
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi Mauro,
> 
> It seems most (if not all) of the commits in the v4l-dvb-next tree are
> also in the v4l-dvb tree and are now causing lots of conflicts when I
> merge them both.  Please clean it up.
> 

Yeah, it had some branches that got already merged.

Just updated it to be in sync with v4l-dvb tree.

Sorry for the mess.

Thanks,
Mauro
