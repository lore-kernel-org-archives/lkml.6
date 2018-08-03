Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C17C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434BC21711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434BC21711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeHCHfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 03:35:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40576 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbeHCHfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 03:35:33 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1589927;
        Fri,  3 Aug 2018 05:40:56 +0000 (UTC)
Date:   Fri, 3 Aug 2018 07:40:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/246] 4.14.60-stable review
Message-ID: <20180803054054.GC1852@kroah.com>
References: <20180801165011.700991984@linuxfoundation.org>
 <20180802154325.GB5137@roeck-us.net>
 <20180802182517.GA24531@roeck-us.net>
 <20180802190946.GA25832@roeck-us.net>
 <20180802194135.GA13901@kroah.com>
 <20180802194536.GA22671@kroah.com>
 <387e5d1c-431f-869e-43b2-c33e60bcbfdb@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <387e5d1c-431f-869e-43b2-c33e60bcbfdb@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 06:21:39PM -0700, Guenter Roeck wrote:
> On 08/02/2018 12:45 PM, Greg Kroah-Hartman wrote:
> [ ... ]
> > 
> > I've pushed out -rc2 releases for all of these with that patch removed.
> > 
> 
> Boot tests with updated images passed for all three releases.

Wonderful, thanks for letting me know.

greg k-h
