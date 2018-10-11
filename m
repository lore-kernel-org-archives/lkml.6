Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1826C6780C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD782075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD782075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeJLDIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:08:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60667 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeJLDIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:08:17 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9BJdQpB2026798
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 11 Oct 2018 12:39:26 -0700
Subject: Re: Insanely high baud rates
To:     Craig Milo Rogers <rogers@isi.edu>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
 <20181010211717.30c1f052@alans-desktop>
 <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com>
 <20181011133134.085624af@alans-desktop> <20181011193651.GA11500@isi.edu>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <aa19265c-f39a-cb7d-1215-1c663d15ac30@zytor.com>
Date:   Thu, 11 Oct 2018 12:39:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181011193651.GA11500@isi.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/18 12:36 PM, Craig Milo Rogers wrote:
> On 18.10.11, Alan Cox wrote:
>> I mean - what is the baud rate of a pty  ?
> 
> 	Solaris made the distinction between B0, which means pty hangup mode,
> and any other baud rate:
> 
> https://docs.oracle.com/cd/E88353_01/html/E37851/pty-4d.html
> 
> 	But... why not implement a pty bandwidth limitation layer?  You say, I
> need to justify it?  It's for, uh... protecting the system from unrestricted
> pty usage DOS attacks!  Yeah.  That's what it's for.

B0 is hangup, that's not in question.

	-hpa

