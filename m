Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640D4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E7A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E7A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeGRTWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:22:25 -0400
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:36633 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726834AbeGRTWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:22:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9BFD618033D29;
        Wed, 18 Jul 2018 18:43:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: screw59_391dc7e0ba63b
X-Filterd-Recvd-Size: 1706
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Jul 2018 18:43:12 +0000 (UTC)
Message-ID: <47fc6920ec365a11b06f7c44f4a3f8d73d177e67.camel@perches.com>
Subject: Re: [PATCH] pktcdvd:checkpatch:fix pointer declaration
From:   Joe Perches <joe@perches.com>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "raghuhack78@gmail.com" <raghuhack78@gmail.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>
Date:   Wed, 18 Jul 2018 11:43:11 -0700
In-Reply-To: <5ad3cf3212c434e73375eeb22d2f67fd70702744.camel@wdc.com>
References: <20180718155855.4949-1-raghuhack78@gmail.com>
         <5ad3cf3212c434e73375eeb22d2f67fd70702744.camel@wdc.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 18:06 +0000, Bart Van Assche wrote:
> On Wed, 2018-07-18 at 21:28 +0530, RAGHU Halharvi wrote:
> > * Fix all pointer declaration which causes
> >    "ERROR: "foo* bar" should be "foo *bar""
> 
> Hello Raghu,
> 
> If you would not be aware of this, checkpatch is a tool that is intended to
> verify patches before submission and not to verify code that is already
> upstream. A detailed explanation of why patches like this one should not be
> submitted is available in "A quick guide to why stand-alone checkpatch
> patches suck"
> (https://lists.kernelnewbies.org/pipermail/kernelnewbies/2014-September/012296.html).

Read more of the whole thread.
Varying opinions exist.

