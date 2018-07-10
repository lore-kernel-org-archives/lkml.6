Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776E2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C76208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C76208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeGJIoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:44:08 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:51492 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeGJIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:44:06 -0400
X-IronPort-AV: E=Sophos;i="5.51,333,1526367600"; 
   d="scan'208";a="16859370"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Jul 2018 01:44:06 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Tue, 10 Jul 2018
 01:44:05 -0700
Date:   Tue, 10 Jul 2018 10:42:57 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Juergen Fitschen <me@jue.yt>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [v2,3/3] i2c: at91: added slave mode support
Message-ID: <20180710084257.ewgnvroow5weffvf@M43218.corp.atmel.com>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        Juergen Fitschen <me@jue.yt>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c9b749fca8e684aa47ead9a5d9e68751326f63cb.1510247114.git.me@jue.yt>
 <20180602213513.qv45gaq2kogagju3@katana>
 <20180709151504.6phtp4rm7of6b2qc@M43218.corp.atmel.com>
 <20180709155135.bjwhrmbk6j26fx4c@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180709155135.bjwhrmbk6j26fx4c@ninjato>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:51:36PM +0200, Wolfram Sang wrote:
> 
> > Sorry for having not catched it. If I remember well, it was the only
> > issue I had while testing the slave support.
> > 
> > > 
> > > BTW maybe I asked already and forgot: is this IP core capable of being
> > > master and slave on the same bus?
> > > 
> > 
> > No the master and slave modes are exclusive.
> 
> Pity.
> 
> But thanks for the heads up, any tag you want to give? Ack or Rev?
> 

Yes sure, you can add my Ack. I would be pleased to see the slave
support taken.

Regards

Ludovic
