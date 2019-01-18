Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8698CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC66204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfARKyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:54:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49091 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfARKyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:54:10 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkRmj-0004PF-6M; Fri, 18 Jan 2019 11:54:01 +0100
Date:   Fri, 18 Jan 2019 11:54:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ilya Dryomov <idryomov@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Henriques <lhenriques@suse.com>,
        Jiri Kosina <jkosina@suse.cz>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>
Subject: Re: [patch 6/9] ceph: quota: Cleanup license mess
In-Reply-To: <CAOi1vP_zHqKvoqZ3Bupip3=Hcoy6fY4jEF-kf46-A0g4ZTNpcw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901181153310.1647@nanos.tec.linutronix.de>
References: <20190117231416.111952141@linutronix.de> <20190117231501.346447710@linutronix.de> <CAOi1vP_zHqKvoqZ3Bupip3=Hcoy6fY4jEF-kf46-A0g4ZTNpcw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Ilya Dryomov wrote:

> On Fri, Jan 18, 2019 at 12:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Precise and non-ambiguous license information is important. The recently
> > added aegis header file has a SPDX license identifier, which is nice, but
> 
> Looks like cut-and-paste from crypto/aegis.h patch?

Oops, sorry.

> I'm changing this to say "recently added quota.c file".

Thank you!

      tglx
