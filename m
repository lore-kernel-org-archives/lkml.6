Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACEAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1ADA21871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfABJuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:50:17 -0500
Received: from mail.CARNet.hr ([161.53.123.6]:45176 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfABJuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:50:17 -0500
Received: from [2001:b68:ff:12::131] (port=40104 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1gedAC-0006Vp-Ud; Wed, 02 Jan 2019 10:50:13 +0100
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id C969B21B8F; Wed,  2 Jan 2019 10:50:12 +0100 (CET)
Date:   Wed, 2 Jan 2019 10:50:12 +0100
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Message-ID: <20190102095012.GH8140@gavran.carpriv.carnet.hr>
References: <20181229124829.3745-1-Valentin.Vidic@CARNet.hr>
 <7e91df3a-d38b-fda4-b64f-4d47f4949623@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e91df3a-d38b-fda4-b64f-4d47f4949623@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: Re: [PATCH] n_tty: update comment for WAKEUP_CHARS define
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 07:48:42AM +0100, Jiri Slaby wrote:
> On 29. 12. 18, 13:48, Valentin Vidic wrote:
> > Give a better descriptions of what WAKEUP_CHARS represents.
> > 
> > Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
> 
> I am not a native speaker, but this is much better than the current text.
> 
> Acked-by: Jiri Slaby <jslaby@suse.cz>
> 
> BTW this text is copy&pasted from/to all the other WAKEUP_CHARS
> locations. Care to fix them all?

Yes, I've seen other instances of WAKEUP_CHARS but they don't look like
the same thing, for example:

rocket_int.h:/* number of characters left in xmit buffer before we ask for more */
rocket_int.h:#define WAKEUP_CHARS 256

rocket.c:       if (info->xmit_cnt < WAKEUP_CHARS) {
rocket.c:               tty_wakeup(tty);

Maybe the instance in n_tty.c could use a better name instead?

-- 
Valentin
