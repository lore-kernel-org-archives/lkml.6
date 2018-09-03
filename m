Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E85C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D3A20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D3A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeICSgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:36:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52072 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbeICSgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:36:01 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fwpdP-0008UK-2j; Mon, 03 Sep 2018 16:15:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, william.hu@rock-chips.com,
        Jacob Chen <jacob-chen@iotwrt.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?utf-8?B?6ZKf5Lul5bSH?= <zyc@rock-chips.com>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Jeffy <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org,
        Chen Jacob <jacob2.chen@rock-chips.com>, ezequiel@collabora.com
Subject: Re: [PATCH v6 00/17] Rockchip ISP1 Driver
Date:   Mon, 03 Sep 2018 16:15:18 +0200
Message-ID: <8351204.OBedv8CUKg@phil>
In-Reply-To: <CAAFQd5An=Dc5je_pedo+u8USMwtHMSfSBztaSA4G6Abn3xgbsQ@mail.gmail.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com> <6761c936-82c7-e36a-de21-c0e827b68a3e@xs4all.nl> <CAAFQd5An=Dc5je_pedo+u8USMwtHMSfSBztaSA4G6Abn3xgbsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 3. September 2018, 15:50:20 CEST schrieb Tomasz Figa:
> Hi Hans,
> 
> On Mon, Sep 3, 2018 at 10:07 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >
> > Hi Jacob,
> >
> > What is the status of this patch series? I haven't seen any updates for quite
> > some time now, and I thought that it was getting close.
> >
> > It would be nice to see this go in.
> 
> AFAIK, Jacob has left the project. +william.hu@rock-chips.com , who
> has been working on addressing the remaining comments for a while.

also I think Ezequiel has spent time on the vpu driver.


