Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14FAC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C43624E27
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mps19v9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C43624E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbeGANtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 09:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752124AbeGANtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 09:49:05 -0400
Received: from dragon (unknown [45.56.152.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96D052243A;
        Sun,  1 Jul 2018 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530452945;
        bh=VUiHyy0wBe9Fo5GaQkfLiX9pxal+BU1U3yAqFP0yedw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mps19v9mbpg+rKrPD8F94CVoLCj8H2f9P7gFTMXB7gf6efFb7KpNP0wLFLJkEmXB3
         3iUWnf58ADTetO7QwNz5qcC7GsqtSRydHcr9SVhBhOdOfMQ5Kjm6OkmrTqC3sH4ydc
         D8s+KhW6dEBIEy55TXnL0TSecBeYJJiBWlXoiJcs=
Date:   Sun, 1 Jul 2018 21:48:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP EEPROM
 nodes
Message-ID: <20180701134854.GV4348@dragon>
References: <20180628042424.12664-1-andrew.smirnov@gmail.com>
 <20180628042424.12664-3-andrew.smirnov@gmail.com>
 <CAHQ1cqHpX_nz+xyyPg30kXsn2oTp2BBzk-qpCi3z3kezg1PTWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqHpX_nz+xyyPg30kXsn2oTp2BBzk-qpCi3z3kezg1PTWg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 09:39:37PM -0700, Andrey Smirnov wrote:
> On Wed, Jun 27, 2018 at 9:24 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >
> > ZII's RDU1s come with two EEPROMs attached to RAVE SP. Add
> 
> Ugh, the description should read RDU2, not RDU1. Will fix in v2,
> tomorrow. Sorry about that.

I fixed it up and applied the series.

Shawn
