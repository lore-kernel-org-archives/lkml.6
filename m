Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F0320866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbeL1UIs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 15:08:48 -0500
Received: from muru.com ([72.249.23.125]:59660 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732128AbeL1UIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 15:08:46 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0645B8116;
        Fri, 28 Dec 2018 20:08:50 +0000 (UTC)
Date:   Fri, 28 Dec 2018 12:08:42 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: Re: cpcap-charger: generate events for userspace
Message-ID: <20181228200842.GA6707@atomide.com>
References: <20181227195221.GA11920@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181227195221.GA11920@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [181227 11:52]:
>     
> The driver doesn't generate uevents on charger connect/disconnect.
> This leads to UPower not detecting when AC is on or off... and that is
> bad.

Acked-by: Tony Lindgren <tony@atomide.com>
