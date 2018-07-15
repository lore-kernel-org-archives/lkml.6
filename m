Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A44ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2CB20882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2CB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeGOJXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:23:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeGOJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:23:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 03A6AA95;
        Sun, 15 Jul 2018 09:00:58 +0000 (UTC)
Date:   Sun, 15 Jul 2018 11:00:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 12/18] staging: gasket: annotate ioctl arg with __user
Message-ID: <20180715090055.GB23333@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
 <20180714055816.223754-13-toddpoynor@gmail.com>
 <20180714063502.GF20451@kroah.com>
 <CAO3upobyf9JpKLSoSPeVfNGOh6R0cud=hT+bhA=U2kNkGEJ-aw@mail.gmail.com>
 <20180714074450.GA22469@kroah.com>
 <CAO3upoYSywZWQCnhYijzEeNdr+ONXxcX3kJVv6nKUeqqe52ujQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO3upoYSywZWQCnhYijzEeNdr+ONXxcX3kJVv6nKUeqqe52ujQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 12:20:51PM -0700, Todd Poynor wrote:
> >> I think I'm following http://www.kroah.com/log/linux/linux-staging-update.html,
> >> but if I'm off in the weeds do clue me in, thanks.
> >
> > That's something I wrote 9 years ago :)
> 
> Still the top search result for how to work in staging, suggest an update. :)

Do all subsystems have such descriptions?  No, working in staging is no
different from working in any other kernel subsystem.  If you want to
find the location of the latest code, look in the MAINTAINERS file for
the git tree.

There's nothing "special" about drivers/staging, except the quality of
the code...

greg k-h
