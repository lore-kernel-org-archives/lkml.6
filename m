Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02EAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A03C214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfA1K1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:27:32 -0500
Received: from protonic.xs4all.nl ([83.163.252.89]:39289 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfA1K1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:27:32 -0500
Received: from erd987 (unknown [192.168.2.69])
        by sparta (Postfix) with ESMTP id A624744A0027;
        Mon, 28 Jan 2019 11:28:44 +0100 (CET)
Date:   Mon, 28 Jan 2019 11:27:30 +0100
From:   Robin van der Gracht <robin@protonic.nl>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH v2] mmc: mxs-mmc: Introduce regulator support
Message-ID: <20190128112730.0175049d@erd987>
In-Reply-To: <20190128102022.1880-1-martink@posteo.de>
References: <20190128102022.1880-1-martink@posteo.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, 28 Jan 2019 11:20:22 +0100
Martin Kepplinger <martink@posteo.de> wrote:

> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> This adds support for explicitly switching the mmc's power on and off
> which is needed for example for WL1837 wifi controllers. ip link set wlan0 down
> doesn't turn off the VMMC regulator which leads to hangs when loading firmware.
> 
> Tested on i.MX28.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
> 
> again, this isn't new. it's (rebased and simplified)
> https://patchwork.kernel.org/patch/4365751/
> 
> Thanks Robin for your input!
> 
> revision history
> ----------------
> v1: was just a question why this hasn't gone in earlier.

Not sure why it never made it. I created it for use with a wl1271 which
wan't properly reset in case of a fault. Also combined with imx28.

Regards,
Robin van der Gracht
