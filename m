Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD2EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4FF2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfBDMWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:22:52 -0500
Received: from verein.lst.de ([213.95.11.211]:48618 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbfBDMWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:22:52 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 7F06168D93; Mon,  4 Feb 2019 13:22:50 +0100 (CET)
Date:   Mon, 4 Feb 2019 13:22:50 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/9] Analogix ANX6345 RGB-(e)DP bridge support
Message-ID: <20190204122250.GB7660@lst.de>
References: <20181018073327.64942-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018073327.64942-1-icenowy@aosc.io>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 03:33:18PM +0800, Icenowy Zheng wrote:
> This patchset brings the support for Analogix ANX6345 RGB-(e)DP bridge,
> which is used by some Allwinner A64 laptops, such as Pinebook and Olimex
> TERES-I.
> 

So what's the status here? I'm working on the Teres-I and I find myself
recreating the chunks in this patchset almost verbatim (only DT so far),
one by one, so there must be something right about them ;-)

Whose turn is it?

	Torsten

