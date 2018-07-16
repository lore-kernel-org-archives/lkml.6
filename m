Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A76ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBA6208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBA6208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeGPLIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:08:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44618 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeGPLIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:08:34 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 7ecd7176bebb05d0; Mon, 16 Jul 2018 12:41:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     broonie@kernel.org, p.paillet@st.com, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2] base: core: Remove WARN_ON from link dependencies check
Date:   Mon, 16 Jul 2018 12:40:08 +0200
Message-ID: <2548044.UDzUby0S5K@aspire.rjw.lan>
In-Reply-To: <20180716102735.GA6269@kroah.com>
References: <20180716095952.22202-1-benjamin.gaignard@st.com> <1753469.EDefOSO2YU@aspire.rjw.lan> <20180716102735.GA6269@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 16, 2018 12:27:35 PM CEST Greg KH wrote:
> On Mon, Jul 16, 2018 at 12:07:20PM +0200, Rafael J. Wysocki wrote:
> > On Monday, July 16, 2018 11:59:52 AM CEST Benjamin Gaignard wrote:
> > > In some cases the link between between customer and supplier
> > > already exist, for example when a device use it parent as supplier [1].
> > 
> > I think this should be "its parent as a supplier".
> > 
> > > Do not warn about already existing dependencies because device_link_add()
> > > take care of this case.
> > 
> > "device_link_add() takes care of"
> > 
> > > [1] https://lkml.org/lkml/2018/7/9/356
> > 
> > There is the Link: tag for links and it is better to not use lkml.org
> > as it is not reliable enough.  You can use lore.kernel.org/lkml/ instead.
> 
> Even better, use:
> 	lkml.kernel.org/r/[message-id]

Where [message-id] is the value of the Message-Id: header (without the
enclosing <>) of the target e-mail message (that you can find by looking
at the raw message).

Thanks,
Rafael

