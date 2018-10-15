Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E89C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2622064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2622064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeJOSOK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:14:10 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:60326 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbeJOSOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:14:10 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9FATAka013574;
        Mon, 15 Oct 2018 11:29:11 +0100
Date:   Mon, 15 Oct 2018 11:29:10 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     khalasa@piap.pl (Krzysztof =?UTF-8?B?SGHFgmFzYQ==?=)
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: net/wan: hostess_sv11 + z85230 problems
Message-ID: <20181015112910.4504cd3a@alans-desktop>
In-Reply-To: <m34ldnd3ju.fsf@t19.piap.pl>
References: <1468d110-4f92-da7a-21b5-36afcec3c94e@infradead.org>
        <m34ldnd3ju.fsf@t19.piap.pl>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 10:20:21 +0200
khalasa@piap.pl (Krzysztof Hałasa) wrote:

> Hi,
> 
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
> > kernel 4.19-rc7, on i386, with NO wan/hdlc/hostess/z85230 hardware:
> >
> > modprobe hostess_sv11 + autoload of z85230 give:  
> 
> BTW Hostess SV11 is apparently an ISA card, with all those problems.

Actually it worked perfectly well of old but people kept changing it
who didn't have hardware. Please just delete the driver instead of
pretending we can test it.

Nobody has one, even if they did there is no use for it as nobody runs
their internet over an old HDLC 64K link any more.

And we know since it's broken several ways by bit-rot that nobody uses it.

Alan
