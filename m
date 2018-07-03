Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2719B23CE3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2719B23CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753615AbeGCTFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:05:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbeGCTFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:05:36 -0400
Received: from localhost (unknown [213.138.59.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6F36CD7;
        Tue,  3 Jul 2018 19:05:35 +0000 (UTC)
Date:   Tue, 3 Jul 2018 21:05:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc:     stable@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.4.139
Message-ID: <20180703190527.GC15763@kroah.com>
References: <d4d62b73-d769-c708-8a3c-8b04189ae366@manjaro.org>
 <e428c411-8095-d9a3-be7e-995f275b01e5@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e428c411-8095-d9a3-be7e-995f275b01e5@manjaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 07:32:06PM +0200, Philip Müller wrote:
> Hi Greg,
> 
> for this kernel there are now patches generated on kernel.org homepage.
> 
> Best, Philip

Ugh, let me push them all out again.  I did it on a train today with
limited connectivity and it looks like some of the patches didn't make
it through, but the tarballs did...

sorry about that.

greg k-h
