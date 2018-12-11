Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C608BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AB92081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AB92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeLKNtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:49:55 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:54621 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeLKNtz (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 11 Dec 2018 08:49:55 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 11 Dec 2018 14:49:52 +0100
Received: from [192.168.1.132] (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 11 Dec 2018 13:49:29 +0000
Message-ID: <1544536167.5269.7.camel@suse.com>
Subject: Re: [PATCH] Revert "firmware: dmi_scan: Use lowercase letters for
 UUID"
From:   Jean Delvare <jdelvare@suse.com>
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 11 Dec 2018 14:49:27 +0100
In-Reply-To: <87efaotgi1.fsf@dell.be.48ers.dk>
References: <20181205211351.5309-1-peter@korsgaard.com>
         <1544086444.5492.1.camel@suse.com> <87a7ljyppx.fsf@dell.be.48ers.dk>
         <1544092087.5492.3.camel@suse.com> <878t1264lf.fsf@dell.be.48ers.dk>
         <87efaotgi1.fsf@dell.be.48ers.dk>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 13:06 +0100, Peter Korsgaard wrote:
> > > > > > "Peter" == Peter Korsgaard <peter@korsgaard.com> writes:
> 
> Hi Jean,
> 
>  >> Look, you can imagine that I was perfectly aware of what I was doing
>  >> when I made that change, and that I pondered the decision carefully at
>  >> that time. And my decision was that the change should be made. As far
>  >> as I'm concerned, this ship has sailed already, sorry.
> 
>  > Sorry, what is the perceived risk of reverting this change? Just the
>  > minor inconsistency between the dmidecode and sysfs output? As stated
>  > above, the RFC requires conforming parsers to handle upper case as well.
> 
> I would appreciate if you could explain what risk you see from reverting
> this change?

The exact same risk that you are complaining about, for a different
pair of kernel versions. You cannot at the same time argue that the
change should not have been done back then, and ask for same change to
be done again now.

-- 
Jean Delvare
SUSE L3 Support
