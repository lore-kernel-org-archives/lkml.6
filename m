Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF6BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7462145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7462145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeJRDsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:48:08 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:52698 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeJRDsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:48:07 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-99-103-nat.elisa-mobile.fi [85.76.99.103])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id A64A53000C;
        Wed, 17 Oct 2018 22:50:51 +0300 (EEST)
Date:   Wed, 17 Oct 2018 22:50:50 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: Re: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
Message-ID: <20181017195050.GA20347@darkstar.musicnaut.iki.fi>
References: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
 <CA+7wUszkduiKMVx5Et3Q2-2tz72CXUKE1_kndC6V1d45uEY2Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUszkduiKMVx5Et3Q2-2tz72CXUKE1_kndC6V1d45uEY2Aw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 17, 2018 at 03:38:07PM +0200, Mathieu Malaterre wrote:
> Since CONFIG_PREEMPT has been 'y' since at least commit 0752f92934292
> could you confirm that the original mmc driver (kernel from imgtech
> people) did work ok with PREEMPT_NONE (sorry I did not do my homework)
> ?

Sorry, cannot confirm or test that. I have only used the mainline kernel
on this board, since v4.5 or so with my own custom config which has
been PREEMPT_NONE until now.

A.
