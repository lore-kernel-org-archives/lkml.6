Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9946C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E93D206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E93D206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeIZN1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:27:50 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:53866 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeIZN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:27:50 -0400
X-IronPort-AV: E=Sophos;i="5.54,305,1534834800"; 
   d="scan'208";a="17788979"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Sep 2018 00:16:20 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Wed, 26 Sep 2018
 00:16:19 -0700
Date:   Wed, 26 Sep 2018 09:16:17 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Olof Johansson <olof@lixom.net>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, <arm@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ARM: at91: SoC for 4.20
Message-ID: <20180926071617.5vend45tfxtxbsiv@M43218.corp.atmel.com>
Mail-Followup-To: Olof Johansson <olof@lixom.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180925103735.GA31525@piout.net>
 <20180925203812.z7jo32d5aebwh7e2@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180925203812.z7jo32d5aebwh7e2@localhost>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 01:38:12PM -0700, Olof Johansson wrote:
> On Tue, Sep 25, 2018 at 12:37:35PM +0200, Alexandre Belloni wrote:
> > Arnd, Olof,
> > 
> > Most changes are shuffling around the maintainers entries. There are
> > also two PM non urgent fixes.
> > 
> > This one as a trivial conflict with the staging tree solved in linux-next.
> > 
> > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > 
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-soc
> > 
> > for you to fetch changes up to 34d2a7db77ad837cfb88bd01b33fd1f3855ce9c0:
> > 
> >   MAINTAINERS: sdhci: move the Microchip entry to proper location (2018-09-25 12:26:31 +0200)
> > 
> > ----------------------------------------------------------------
> > AT91 SoC for 4.20
> > 
> >  - rename MAINTAINERS entries and change maintainers
> >  - two pm cleanups
> 
> Merged, thanks.  Welcome aboard as maintainer, Ludovic!

Thanks!

Ludovic

> 
> 
> -Olof
