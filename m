Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F811C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C942183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfAGVfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:35:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:55400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbfAGVfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:35:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7621B02B;
        Mon,  7 Jan 2019 21:35:34 +0000 (UTC)
Message-ID: <1546896322.6905.0.camel@suse.com>
Subject: Re: [PATCH v3] usb: hub: add retry routine after intr URB submit
 error
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Mon, 07 Jan 2019 22:25:22 +0100
In-Reply-To: <Pine.LNX.4.44L0.1901071357040.1399-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1901071357040.1399-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2019-01-07 at 13:59 -0500, Alan Stern wrote:
> On Mon, 7 Jan 2019, Greg KH wrote:
> 
> 
> > What ever happened to this patch?  Is it still needed?  Oliver and Alan,
> > any objections about it anymore?
> 
> I have just one very minor nit to pick (see below).  Mostly I've been
> waiting to hear from Oliver.

Sorry, I have been away over Christmas. It is looking good to me.

	Regards
		Oliver

