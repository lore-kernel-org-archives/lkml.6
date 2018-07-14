Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C94ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EC4208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EC4208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeGNGt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:49:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeGNGt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:49:58 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34C6C86D;
        Sat, 14 Jul 2018 06:32:02 +0000 (UTC)
Date:   Sat, 14 Jul 2018 08:31:58 +0200
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
Subject: Re: [PATCH 03/18] staging: gasket: typo and whitespace cleanups
Message-ID: <20180714063158.GC20451@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
 <20180714055816.223754-4-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714055816.223754-4-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 10:58:01PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Trivial typo and whitespace fixes.

typos are different from whitespace issues.  Please break this up.

Yeah, it's a pain, sorry, but that's a requirement for kernel patches.
It's to make it easier on the reviewer, not necessarily the creator of
the patch :)

thanks,

greg k-h
