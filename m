Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83C1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9513C2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545079167;
	bh=R33rg/wenbPWcVS7cILKy7MFjBbn69nDiTPbJQPDlfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=szVZf8MR4h5MPY3IbBmr9LzRoWUxcNBl7+fGCDGu9tvZ4Gpf8VKsRHa63hUJTzI58
	 IHHXAuhg7sm9uJ68SBbc0PodBd/qepw04GIpeDSaAB3pGtAk5KCyCWWto1ndZCdJsf
	 vGDnLIItH6tFwjTJfKFGEhuG6h9SLnKYd3cMn8eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbeLQUj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:39:26 -0500
Received: from casper.infradead.org ([85.118.1.10]:47680 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeLQUj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WwsczWpd2Vp4c1+ovorrM7SbEhqiJ5p1JgbBbVskR/k=; b=piellfVV7dFnjfv50+lvYm1eqK
        F7s+MzSbavEOrQcurrwkHUyFzJVPKc0mpjgzjGbGa5ZscLwjR83ZJTJiDxbc3u0/GAz0cZv2oAtWk
        XUZvpYkE8qvN1UY11KcUtFsf6PS4hT7GZq/x2kgzQuyBdhkk8yD6gju/v/c2c1UXk/FvzKhrFTxlF
        e7uW/3GyODedSdQTbwyGnspXF5Ng6zaGgF3LhXlcRBnEhtwCQNeV4gCW8uHtsGW6KJNV7sOgByxp0
        NY/jRo/jXMmnrzFii5jPL9z7t4AKkPncgxMWyhWWl3EU5ALYVCR4S7/wNpscuBXYNOHqEtcTDAaYw
        SJbvH//Q==;
Received: from 177.205.112.95.dynamic.adsl.gvt.net.br ([177.205.112.95] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYzff-0003Oq-2c; Mon, 17 Dec 2018 20:39:23 +0000
Date:   Mon, 17 Dec 2018 18:39:17 -0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Cao,Bing Bu" <bingbu.cao@intel.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 v4l-dvb-next tree
Message-ID: <20181217183909.3a06fbb4@coco.lan>
In-Reply-To: <20181216172339.486781e5@canb.auug.org.au>
References: <20181216172339.486781e5@canb.auug.org.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 16 Dec 2018 17:23:39 +1100
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi Mauro,
> 
> Commit
> 
>   7ab9b77a9410 ("media: staging/intel-ipu3: Add dual pipe support")
> 
> is missing a Signed-off-by from its author.

The original author sent his SOB. I rebased the topic branch in order
to contain it.

Thanks for the warning!

Thanks,
Mauro
