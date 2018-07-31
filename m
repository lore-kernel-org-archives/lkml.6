Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93387C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A970208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pmhahn.de header.i=@pmhahn.de header.b="sw+Z5o79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A970208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pmhahn.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbeGaMSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:18:54 -0400
Received: from parrot.pmhahn.de ([88.198.50.102]:45056 "EHLO parrot.pmhahn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbeGaMSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:18:54 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jul 2018 08:18:53 EDT
Received: from [IPv6:2001:470:71e6:17:3c97:eff:fe92:d32a] (unknown [IPv6:2001:470:71e6:17:3c97:eff:fe92:d32a])
        by parrot.pmhahn.de (Postfix) with ESMTPSA id 7AC8DEF23D;
        Tue, 31 Jul 2018 12:29:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pmhahn.de; s=201711;
        t=1533032982; bh=btS9aWeVMv2FG/2z/i1CGiqcAQzgKrslqPJ01P/3iHI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=sw+Z5o79vx/yvuhTO3wkNxypTuBi2qWdHRPoVeelSXPUBXPq2oUBqJbGnKJ2AXDsa
         NVsE4JY5MWGBQ/TbY6rtEQkRXFG/+fjb2eV3diA8YB5mUVhMt6ZZB0jomR9tyux8ST
         Tkje4TNDEBJYL5h9r9RjYwmdICZ0tBjoBB9eJrz0=
Subject: Re: [PATCH] MAINTAINERS: mark ddbridge, stv0910, stv6111 and mxl5xx
 orphan
To:     Daniel Scheller <d.scheller.oss@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20180714175634.29827-1-d.scheller.oss@gmail.com>
From:   Philipp Hahn <pmhahn+video@pmhahn.de>
Message-ID: <38607707-5a77-0382-7160-0131afb8a2e3@pmhahn.de>
Date:   Tue, 31 Jul 2018 12:29:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180714175634.29827-1-d.scheller.oss@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

Am 14.07.2018 um 19:56 schrieb Daniel Scheller:
> From: Daniel Scheller <d.scheller@gmx.net>
> 
> I'm definitely not interested to try to maintain drivers in a subsystem/
> tree anymore where the subsystem maintainer prefers to have changes
> bitrot for months, rejects patches for idiotic reasons and, ontop, simply
> ignores emails (lots of) with ie. questions to any requested changes, or
> questions in general.
> 
> I'd happily continue taking care of these drivers (it's fun and I surely
> have time for this, albeit everything being hobbyist, volunteer and
> unpaid work). Though recalling all the latest actions and the fact that
> the initial series that got the ball rolling at all being ignored for
> over four(!) months, I'm now out of this business. This is not about
> "getting work done".

Thank you for getting ddbridge and related drivers into shape. As an
owner of that DVB card I very much appreciated your work. Thank you allot.
I own you a drink.

Philipp
