Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CDAC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5279208D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5279208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbeGHPiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 11:38:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeGHPiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 11:38:13 -0400
Received: from localhost (unknown [46.44.180.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 22107CE3;
        Sun,  8 Jul 2018 15:38:12 +0000 (UTC)
Date:   Sun, 8 Jul 2018 17:38:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, keescook@chromium.org,
        aastha.gupta4104@gmail.com, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 03/12] staging:rtl8192u: Remove blank lines before '}'
 and after '{' characters
Message-ID: <20180708153811.GA29737@kroah.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
 <20180707145513.15325-3-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707145513.15325-3-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 03:55:04PM +0100, John Whitmore wrote:
> Coding style change to simply remove the unrequired spaces before a closing
> brace or before an opening brace.

That would be good, but that's not what this patch does :(

It removes lines, not spaces, as the subject line said.  You also fix up
an indentation as well.

thanks,

greg k-h
