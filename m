Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D20C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD6F257F2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD6F257F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967830AbeF1SXX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:23:23 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:4659 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030426AbeF1SWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:22:00 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w5SILoZ5029863;
        Thu, 28 Jun 2018 20:21:50 +0200
Date:   Thu, 28 Jun 2018 20:21:50 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, ben.whitten@gmail.com,
        geert+renesas@glider.be, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-morse: send out morse code
Message-ID: <20180628182150.GA29858@1wt.eu>
References: <20180628134227.GA1719@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628134227.GA1719@arbeit>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:42:27PM +0200, Andreas Klinger wrote:
> Send out a morse code by using LEDs.
> 
> This is useful especially on embedded systems without displays to tell the
> user about error conditions and status information.
> 
> The trigger will be called "morse"
> 
> The string to be send is written into the file morse_string and sent out
> with a workqueue. Supported are letters and digits.
> 
> With the file dot_unit the minimal time unit can be adjusted in
> milliseconds.

Wow, I really love the idea!

Willy
