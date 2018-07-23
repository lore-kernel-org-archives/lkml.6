Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC65ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E186920671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E186920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbeGWTdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:33:13 -0400
Received: from smtprelay0061.hostedemail.com ([216.40.44.61]:32779 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387922AbeGWTdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:33:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id AAE5918024A4D;
        Mon, 23 Jul 2018 18:30:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: kite09_5d64850dcbe0b
X-Filterd-Recvd-Size: 1747
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Jul 2018 18:30:41 +0000 (UTC)
Message-ID: <5ac390c1cdf14656624dcc1f2816ab4d694d0d4f.camel@perches.com>
Subject: Re: [PATCH 05/11] touchscreen: elants: Use octal permissions
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dev-harsh1998 <harshitjain6751@gmail.com>, trivial@kernel.org,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 Jul 2018 11:30:40 -0700
In-Reply-To: <20180723182412.GA2964@roeck-us.net>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
         <20180723131954.30739-4-harshitjain6751@gmail.com>
         <20180723133200.GA1167@kroah.com> <20180723171831.GC100814@dtor-ws>
         <e257bc89eb082e9fdc342d6f794c15a2805c98a9.camel@perches.com>
         <20180723182412.GA2964@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-23 at 11:24 -0700, Guenter Roeck wrote:
> There are much more urgent issues to fix there (such as, for example,
> converting the "offending" drivers to the latest API, which would
> magically cause most of the offenders to disappear).

Perhaps posting a list of desired hwmon changes could help.

Documentation/hwmon/submitting-patches does not seem to specify
what the "latest API" is nor describe what changes would be
required in older drivers.
