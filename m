Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D052C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C65020841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C65020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeJKVmI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:42:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38971 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeJKVmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:42:08 -0400
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9BEEbUr1924930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 11 Oct 2018 07:14:38 -0700
Date:   Thu, 11 Oct 2018 07:14:30 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20181011133134.085624af@alans-desktop>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com> <20181010211717.30c1f052@alans-desktop> <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com> <20181011133134.085624af@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Insanely high baud rates
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
CC:     linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
From:   hpa@zytor.com
Message-ID: <8A583BC1-A295-48D2-B4C3-3E70AA50D035@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 11, 2018 5:31:34 AM PDT, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> I'm mostly wondering if it is worth future-proofing for new
>transports. It sounds like we can have a consensus on leaving the upper
>4 bits of the speed fields reserved, but leave the details of
>implementation for the future?
>
>It seems reasonable, although I think the reality is that any future
>transport is not going to be a true serial link, but some kind of
>serial
>emulation layer. For those the speed really only matters to tell
>editors
>and the like not to bother being clever.
>
>I mean - what is the baud rate of a pty  ?
>
>Alan

Whatever the master wants it to be...
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
