Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66686ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2523A20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2523A20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeGWGPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:15:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbeGWGPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:15:32 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D892D41C;
        Mon, 23 Jul 2018 05:16:08 +0000 (UTC)
Date:   Mon, 23 Jul 2018 07:16:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pengbo Mu <pengbo.mu@nxp.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, ran.wang_1@nxp.com
Subject: Re: [PATCH] usb: dwc3: call set incr burst type func()
Message-ID: <20180723051605.GA13377@kroah.com>
References: <1532316853-29184-1-git-send-email-pengbo.mu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532316853-29184-1-git-send-email-pengbo.mu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 11:34:13AM +0800, Pengbo Mu wrote:
> Call dwc3_set_incr_burst_type() in dwc3_core_init().
> 

That says what you did, not why you are doing this.

Please fix up.

greg k-h
