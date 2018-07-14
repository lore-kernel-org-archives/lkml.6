Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875FBECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4AD20673
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4AD20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeGNGUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:20:48 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60541 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeGNGUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:20:48 -0400
X-Originating-IP: 50.39.174.102
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net [50.39.174.102])
        (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6FF9D1BF205;
        Sat, 14 Jul 2018 06:02:51 +0000 (UTC)
Date:   Fri, 13 Jul 2018 23:02:48 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Adrian Reber <adrian@lisas.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
Message-ID: <20180714060247.GB3258@localhost>
References: <20180712130733.11510-1-adrian@lisas.de>
 <87sh4o5s82.fsf@xmission.com>
 <20180713135541.7ada72437862c32f4563a9a8@linux-foundation.org>
 <CAGXu5jJMBDd3-Yab78aYwQ1N6VG7=BjARoTF1pDygPhaWA9VNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJMBDd3-Yab78aYwQ1N6VG7=BjARoTF1pDygPhaWA9VNQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 09:44:15PM -0700, Kees Cook wrote:
> On Fri, Jul 13, 2018 at 1:55 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Thu, 12 Jul 2018 11:33:33 -0500 ebiederm@xmission.com (Eric W. Biederman) wrote:
> >> What is the value of disabling this functionality ever?
> >>
> >> Is there any reason why we don't just delete CONFIG_CHECKPOINT_RESTORE
> >> entirely?
> >
> > For the vast number of Linux machines which aren't servers?  Check out
> > some defconfigs - only one of arm's 119 defconfigs selects it.
> 
> Right, and I would bet the minification folks would like to keep it
> out of their builds too. I think we should keep the config.

Thank you, Kees.  Yes, please.

- Josh Triplett
