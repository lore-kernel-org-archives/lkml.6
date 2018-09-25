Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A32C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338172087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338172087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeIYNKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:10:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44040 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeIYNKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:10:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 795821113;
        Tue, 25 Sep 2018 07:04:34 +0000 (UTC)
Date:   Tue, 25 Sep 2018 09:04:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Silesh C V <svellattu@mvista.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 2/2] treewide: use bus_find_device_by_fwnode
Message-ID: <20180925070431.GA18765@kroah.com>
References: <1537853328-1282-1-git-send-email-svellattu@mvista.com>
 <1537853328-1282-2-git-send-email-svellattu@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537853328-1282-2-git-send-email-svellattu@mvista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:58:48AM +0530, Silesh C V wrote:
> Use bus_find_device_by_fwnode helper to find the device having a
> specific firmware node on a bus.
> ---


No signed off by?

:(
