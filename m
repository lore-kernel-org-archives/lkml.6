Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFD7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839FE23DAF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839FE23DAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933311AbeGFPh4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:37:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932932AbeGFPhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:37:54 -0400
Received: from localhost (unknown [37.170.89.196])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 66EB6BBF;
        Fri,  6 Jul 2018 15:37:53 +0000 (UTC)
Date:   Fri, 6 Jul 2018 17:37:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Vernia <peter.vernia@gmail.com>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, NeilBrown <neil@brown.name>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH] staging: mt7621-pinctrl: Replace unsigned with unsigned
 int
Message-ID: <20180706153749.GA10530@kroah.com>
References: <1530834355-8833-1-git-send-email-peter.vernia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530834355-8833-1-git-send-email-peter.vernia@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 07:45:41PM -0400, Peter Vernia wrote:
> Replaces instances of "unsigned" with "unsigned int" in pinctrl-mt7621.c
> 
> Signed-off-by: Peter Vernia <peter.vernia@gmail.com>
> ---
>  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 27 +++++++++++++------------
>  1 file changed, 14 insertions(+), 13 deletions(-)

Someone else sent this same change before you did, sorry :(
