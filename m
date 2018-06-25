Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ADCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B9925533
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B9925533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeFYHfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:35:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35799 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751607AbeFYHfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:35:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A6CE32087B; Mon, 25 Jun 2018 09:35:09 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7A3A52073C;
        Mon, 25 Jun 2018 09:34:59 +0200 (CEST)
Date:   Mon, 25 Jun 2018 09:34:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Greg KH <greg@kroah.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH 5/9] rtc: cros-ec: Switch to SPDX identifier.
Message-ID: <20180625073459.GA15406@piout.net>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
 <20180605092209.22887-6-enric.balletbo@collabora.com>
 <20180605094626.GC4637@piout.net>
 <39af6363-ce08-a227-f66a-4c7bd4916596@collabora.com>
 <20180605185952.GG4637@piout.net>
 <20180625015832.GB30408@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625015832.GB30408@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2018 09:58:32+0800, Greg KH wrote:
> On Tue, Jun 05, 2018 at 08:59:52PM +0200, Alexandre Belloni wrote:
> > On 05/06/2018 20:51:06+0200, Enric Balletbo i Serra wrote:
> > > Hi Alexandre,
> > > 
> > > On 05/06/18 11:46, Alexandre Belloni wrote:
> > > > On 05/06/2018 11:22:05+0200, Enric Balletbo i Serra wrote:
> > > >> Adopt the SPDX license identifier headers to ease license compliance
> > > >> management.
> > > >>
> > > >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > >> ---
> > > >>
> > > >>  drivers/rtc/rtc-cros-ec.c | 21 +++++----------------
> > > >>  1 file changed, 5 insertions(+), 16 deletions(-)
> > > >>
> > > > Applied, thanks.
> > > > 
> > > 
> > > Looks like all the ChromeOS drivers should be licensed as GPL v2 only. There was
> > > a mismatch between what the header says and the MODULE_LICENSE and I wrongly
> > > assumed that the MODULE_LICENSE is the one I should follow. So could you not
> > > apply this patch for now and I'll send another version with the correct license?
> > > 
> > 
> > Hum, ok, this seemed to be the correct way to solve the mismatch to me.
> 
> No, the license text trumps the MODULE_LICENSE() string.  Please revert
> this, or fix it up to be correct.
> 

Isn't it correct in Linus' tree?


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
