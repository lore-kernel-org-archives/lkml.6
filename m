Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B2DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4658220881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4658220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJPUB2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:01:28 -0400
Received: from [195.159.176.226] ([195.159.176.226]:39636 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJPUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:01:28 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1gCO9o-000396-MT
        for linux-kernel@vger.kernel.org; Tue, 16 Oct 2018 14:09:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Marcel Ziswiler <marcel@ziswiler.com>
Subject: Re: [PATCH v2 0/9] ARM: dts: tegra: last minute fixes
Date:   Tue, 16 Oct 2018 14:10:51 +0200
Message-ID: <1539691851.6233.14.camel@ziswiler.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
         <20181016115852.GE7449@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Complaints-To: usenet@blaine.gmane.org
In-Reply-To: <20181016115852.GE7449@sirena.org.uk>
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-16 at 12:58 +0100, Mark Brown wrote:
> On Tue, Oct 16, 2018 at 12:47:21PM +0200, Marcel Ziswiler wrote:
> 
> > Marcel Ziswiler (9):
> >   ARM: tegra: fix simple-panel compatibles
> >   ARM: tegra: apalis-tk1/colibri_t20/t30: eval/iris: fix regulator
> > gpio
> >     enable
> >   ARM: tegra: colibri_t20: reorder pmic properties
> >   ARM: tegra: apalis-tk1: further regulator clean-up
> >   ARM: tegra: apalis_t30/tk1: annotate power I2C being on-module
> >   ARM: tegra: colibri_t30: further regulator clean-up
> >   ARM: tegra: apalis_t30: further regulator clean-up
> >   ASoC: tegra_sgtl5000: fix device_node refcounting
> >   ASoC: tegra_sgtl5000: fix platform name vs. of_node assignement
> 
> These ASoC patches appear to have absolutely no relationship with the
> rest of the series.  Is that the case or is there some dependency I'm
> missing?

Not outside of all being Tegra specific stuff, no. If you prefer I may
send them as a separate series.

