Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ED9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40A0208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40A0208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933330AbeGJN1o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:27:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36492 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeGJN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:27:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8A753C34;
        Tue, 10 Jul 2018 13:27:42 +0000 (UTC)
Date:   Tue, 10 Jul 2018 15:27:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Mavrodiev <stefan.mavrodiev@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] drm/panel: Add support for Olimex LCD-OLinuXino
 panel
Message-ID: <20180710132740.GA19600@kroah.com>
References: <1529909093-17021-1-git-send-email-stefan@olimex.com>
 <20180710103250.GG1504@ulmo>
 <e1229a90-1bdb-0c8e-c371-cde0bc30ea56@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1229a90-1bdb-0c8e-c371-cde0bc30ea56@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 04:08:54PM +0300, Stefan Mavrodiev wrote:
> On 07/10/2018 01:32 PM, Thierry Reding wrote:
> > > +MODULE_AUTHOR("Stefan Mavrodiev <stefan@olimex.com>");
> > > +MODULE_DESCRIPTION("LCD-OLinuXino driver");
> > > +MODULE_LICENSE("GPL v2");
> > This seems to contradict the GPL-2.0+ in the SPDX header.
> Can you elaborate on this?

Please read module.h for what this string means.

thanks,

greg k-h
