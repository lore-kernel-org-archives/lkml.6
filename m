Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDADC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12363206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12363206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbeKPUKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:10:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40854 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbeKPUKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:10:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 39CFF20787; Fri, 16 Nov 2018 10:58:25 +0100 (CET)
Received: from collins (220.107.128.77.rev.sfr.net [77.128.107.220])
        by mail.bootlin.com (Postfix) with ESMTPSA id E087B20510;
        Fri, 16 Nov 2018 10:58:24 +0100 (CET)
Message-ID: <2866553ef5e5bb293e099ec7c281111e0a6f86dc.camel@bootlin.com>
Subject: Re: [PATCH 01/15] ARM: dts: sun8i-a33: Remove heading 0 in
 video-codec unit address
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Fri, 16 Nov 2018 10:59:43 +0100
In-Reply-To: <CAGb2v679sG+KqmkGway8E-CdgQa8ybBv8K2RdNwfB7zWAJkaXQ@mail.gmail.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
         <20181115145013.3378-2-paul.kocialkowski@bootlin.com>
         <CAGb2v679sG+KqmkGway8E-CdgQa8ybBv8K2RdNwfB7zWAJkaXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeudi 15 novembre 2018 à 23:50 +0800, Chen-Yu Tsai a écrit :
> On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > This cosmetic change removes the heading 0 in the video-codec unit
> > address, as it's done for other nodes.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> Nit: I'd prefer the subject prefix format be "<family>: <soc>: ... ",
> or "sun8i: a33:" in this case. This format seems to be used more often
> than your alternative format.
> 
> I can fix it up when applying.

Understood, I will make sure to follow this convention next time.

Cheers,

Paul

> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> ChenYu

