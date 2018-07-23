Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6011DECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D7520846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D7520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388284AbeGWKjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:39:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35040 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbeGWKjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:39:39 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D2F37B78;
        Mon, 23 Jul 2018 09:39:18 +0000 (UTC)
Date:   Mon, 23 Jul 2018 11:39:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, gkohli@codeaurora.org,
        Maria Yu <aiquny@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        neeraju@codeaurora.org, stable@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Issue related cpuhotplug failure path on 4.9.x version
Message-ID: <20180723093916.GA22443@kroah.com>
References: <4c43c9d5-cd7d-4f2f-70b3-384863a3fe61@codeaurora.org>
 <b8865622-6fb8-bd0e-dbe0-30fb54157504@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8865622-6fb8-bd0e-dbe0-30fb54157504@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:49:27PM +0530, Mukesh Ojha wrote:
> On 7/23/2018 1:57 PM, Mukesh Ojha wrote:
> > 
> > Hi All,
> > 
> > I wanted to discuss about one of the corner case exists in 4.9 kernel
> > (4.9.x) where

4.9 is over 1 1/2 years old now.  Please test this on 4.17 or better
yet, 4.18-rc as the cpu hotplug path has been radically cleaned up and
changed since 4.9 was released.

If you are stuck with 4.9 for some odd reason, sorry, but you really are
on your own.  I recommend going and asking for support from the people
that are forcing you to stick with that kernel.

good luck!

greg k-h
