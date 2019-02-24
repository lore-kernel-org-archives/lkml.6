Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D98C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3054620652
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfBXTiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:38:08 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:42622 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfBXTiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:38:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 06DB8536C;
        Sun, 24 Feb 2019 20:38:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JgIJ33x8gyoK; Sun, 24 Feb 2019 20:38:05 +0100 (CET)
Received: from function (unknown [198.134.98.50])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 39465535C;
        Sun, 24 Feb 2019 20:38:05 +0100 (CET)
Received: from samy by function with local (Exim 4.92-RC6)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gxzb6-0002sX-O2; Sun, 24 Feb 2019 20:38:00 +0100
Date:   Sun, 24 Feb 2019 20:38:00 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: Note that simple_strtoul can't simply be
 replaced by kstrtoul
Message-ID: <20190224193800.nlqixjkpdx5guiju@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, w.d.hubbs@gmail.com,
        chris@the-brannons.com, kirk@reisers.ca, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190223194219.qxvi7cwfp3etqdfi@function>
 <20190224075921.GA5937@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190224075921.GA5937@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le dim. 24 févr. 2019 08:59:21 +0100, a ecrit:
> On Sat, Feb 23, 2019 at 08:42:19PM +0100, Samuel Thibault wrote:
> > We often receive patches which erroneously try to use kstrtoul in these
> > places.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Awe, it's fun to try to see people do this and not really think about
> the consequences :)

Sure :)
But I have to say I'm a bit scared one of these could pass through :)

> Anyway, seriously, thanks for this, I'll go queue it up later today...

Thanks!

Samuel
