Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41C8C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB7321841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389028AbfAKOaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:30:46 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:57110 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389003AbfAKOan (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 11 Jan 2019 09:30:43 -0500
Received: from linux-l9pv.suse (124-11-22-254.static.tfn.net.tw [124.11.22.254])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 11 Jan 2019 15:30:10 +0100
Date:   Fri, 11 Jan 2019 22:29:59 +0800
From:   joeyli <jlee@suse.com>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
Message-ID: <20190111142959.GZ3599@linux-l9pv.suse>
References: <20190103143227.9138-1-jlee@suse.com>
 <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
 <20190109163958.GG9503@linux-l9pv.suse>
 <2049173.FbhQ43HnNr@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2049173.FbhQ43HnNr@tauon.chronox.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 05:47:53PM +0100, Stephan Mueller wrote:
> Am Mittwoch, 9. Januar 2019, 17:39:58 CET schrieb joeyli:
> 
> Hi joeyli,
> 
> > 
> > I am doing encrypt-then-MAC.
> 
> Note, this is what the authenc() AEAD cipher does.
>

OK.. Thanks for your reminding. I will look at it.

Joey Lee 
