Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6555C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F682086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F682086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbeLKKop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:44:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52455 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKKop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:44:45 -0500
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 76650218a2e57eea; Tue, 11 Dec 2018 11:44:43 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pavel Machek <pavel@ucw.cz>, Yangtao Li <tiny.windzz@gmail.com>
Cc:     len.brown@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / QoS: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Tue, 11 Dec 2018 11:44:25 +0100
Message-ID: <4536360.xs1Gq46u5u@aspire.rjw.lan>
In-Reply-To: <20181111112955.GC27666@amd>
References: <20181106143806.8551-1-tiny.windzz@gmail.com> <20181111112955.GC27666@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 11, 2018 12:29:55 PM CET Pavel Machek wrote:
> 
> --V88s5gaDVPzZ0KCq
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Tue 2018-11-06 09:38:06, Yangtao Li wrote:
> > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> >=20
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Patch applied, thanks!

