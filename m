Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823D7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A72A208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A72A208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeHVW5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:57:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeHVW5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:57:49 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A078FCB7;
        Wed, 22 Aug 2018 19:31:37 +0000 (UTC)
Date:   Wed, 22 Aug 2018 21:31:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philippe Ombredanne <pombredanne@nexb.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/11] can: rcar: use SPDX identifier for Renesas drivers
Message-ID: <20180822193133.GA1613@kroah.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-6-wsa+renesas@sang-engineering.com>
 <CAOMZO5AkVNiYMGdED9erL=YMaKcmtS5BzZxw2gO1KLXEaPnD7A@mail.gmail.com>
 <20180822063005.535lytz7hl32rsha@katana>
 <CAOMZO5BiAyDMSR=2Y-4-1ftNuVtRS59sSJd_cdFmzX=0kgF0Bw@mail.gmail.com>
 <CAOFm3uF9_rbELx0aYLDXpDnZfi2Z11V1Z4Ktw+DDJT62o2S1kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOFm3uF9_rbELx0aYLDXpDnZfi2Z11V1Z4Ktw+DDJT62o2S1kQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 08:16:45PM +0200, Philippe Ombredanne wrote:
> Hi Fabio,
> On Wed, Aug 22, 2018 at 2:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Wed, Aug 22, 2018 at 3:30 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >>
> >>> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >>>
> >>> According to Documentation/process/license-rules.rst the format should
> >>> be like this instead:
> >>>
> >>> // SPDX-License-Identifier: GPL-2.0+
> >>
> >> According to https://spdx.org/licenses/ it should be what I did above.
> >
> > Previous advice I saw was to follow the format described in
> > Documentation/process/license-rules.rst
> >
> > Greg/Philippe,
> >
> > Any inputs on this matter?
> >
> > Thanks
> 
> IMHO we should always treat and use the
> Documentation/process/license-rules.rst as the reference and not SPDX
> proper who moves at its own pace and evolves its specs and license ids
> independently of where we stand in the kernel.
> If this is not right Doc patches are welcomed!
> In this is very specific case this has been discussed on list a few
> times. If I recall correctly Thomas also had an opinion on this...
> So you are correct and this should be for now:
> // SPDX-License-Identifier: GPL-2.0+

That is correct, stick with that format/version for now please.

thanks,

greg k-h
