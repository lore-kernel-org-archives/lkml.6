Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B89F7C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79757208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79757208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934061AbeFLIlp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:41:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60889 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933251AbeFLIlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:41:42 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fSerx-0000w0-OB; Tue, 12 Jun 2018 10:41:37 +0200
Message-ID: <1528792895.5280.7.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/2] media: staging/imx: fill vb2_v4l2_buffer
 sequence entry
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Peter Seiderer <ps.report@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>
Cc:     linux-media@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jun 2018 10:41:35 +0200
In-Reply-To: <20180611224833.64a89c80@gmx.net>
References: <20180315191323.6028-1-ps.report@gmx.net>
         <20180315191323.6028-2-ps.report@gmx.net>
         <892dd00e-83bc-7781-6684-603ff89378cd@gmail.com>
         <20180611224833.64a89c80@gmx.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2018-06-11 at 22:48 +0200, Peter Seiderer wrote:
> Hello *,
> 
> On Fri, 16 Mar 2018 10:05:44 -0700, Steve Longerbeam <slongerbeam@gmail.com> wrote:
> 
> > Reviewed-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> 
> Ping? Anybody taking this one?

The patches have been marked not applicable in patchwork [1][2].
They do apply on media_tree master.

[1] https://patchwork.linuxtv.org/patch/47946/
[2] https://patchwork.linuxtv.org/patch/47947/

regards
Philipp
