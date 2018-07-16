Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82783ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EAB20871
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EAB20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbeGPNke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:40:34 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:39434 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728742AbeGPNke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:40:34 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w6GDD16u005171;
        Mon, 16 Jul 2018 14:13:01 +0100
Date:   Mon, 16 Jul 2018 14:13:01 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tty: support CIBAUD without BOTHER
Message-ID: <20180716141301.5d542605@alans-desktop>
In-Reply-To: <20180716104411.GA11023@kroah.com>
References: <20180715133935.24964-1-johan@kernel.org>
        <20180715133935.24964-4-johan@kernel.org>
        <20180716100028.GA20101@kroah.com>
        <20180716101824.GK10204@localhost>
        <20180716104411.GA11023@kroah.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ugh, I thought glibc got support for it, I guess everyone just
> hand-codes it in their applications for now.  Sad.

The glibc people actively contributed to its design and then went radio
silent on the subject.

Alan
