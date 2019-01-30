Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB883C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1C221473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfA3Xws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:52:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58395 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfA3Xws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:52:48 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 9cc5c660e0879020; Thu, 31 Jan 2019 00:52:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pavel Machek <pavel@ucw.cz>, Yangtao Li <tiny.windzz@gmail.com>
Cc:     len.brown@intel.com, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / wakeup: fix comment of pm_wakeup_dev_event()
Date:   Thu, 31 Jan 2019 00:51:40 +0100
Message-ID: <2581955.zbx2OOVCpv@aspire.rjw.lan>
In-Reply-To: <20190124122633.GA24847@amd>
References: <20190123162201.26366-1-tiny.windzz@gmail.com> <20190124122633.GA24847@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 24, 2019 1:26:33 PM CET Pavel Machek wrote:
> 
> --tThc/1wpZn/ma/RB
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Wed 2019-01-23 11:22:01, Yangtao Li wrote:
> > This brings the kernel doc in line with the function signature.
> >=20
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Patch applied, thanks!

