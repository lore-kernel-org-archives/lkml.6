Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCDAECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36B3208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36B3208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGPKyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:54:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbeGPKyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:54:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5C8CE89B;
        Mon, 16 Jul 2018 10:27:37 +0000 (UTC)
Date:   Mon, 16 Jul 2018 12:27:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        broonie@kernel.org, p.paillet@st.com, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2] base: core: Remove WARN_ON from link dependencies
 check
Message-ID: <20180716102735.GA6269@kroah.com>
References: <20180716095952.22202-1-benjamin.gaignard@st.com>
 <1753469.EDefOSO2YU@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1753469.EDefOSO2YU@aspire.rjw.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:07:20PM +0200, Rafael J. Wysocki wrote:
> On Monday, July 16, 2018 11:59:52 AM CEST Benjamin Gaignard wrote:
> > In some cases the link between between customer and supplier
> > already exist, for example when a device use it parent as supplier [1].
> 
> I think this should be "its parent as a supplier".
> 
> > Do not warn about already existing dependencies because device_link_add()
> > take care of this case.
> 
> "device_link_add() takes care of"
> 
> > [1] https://lkml.org/lkml/2018/7/9/356
> 
> There is the Link: tag for links and it is better to not use lkml.org
> as it is not reliable enough.  You can use lore.kernel.org/lkml/ instead.

Even better, use:
	lkml.kernel.org/r/[message-id]

thanks,

greg k-h
