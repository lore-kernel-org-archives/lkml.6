Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAE0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B1220868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B1220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeK3Gk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:40:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:37608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbeK3Gk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:40:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05D18ACC6;
        Thu, 29 Nov 2018 19:34:26 +0000 (UTC)
Date:   Thu, 29 Nov 2018 20:34:25 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4.14 044/100] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Message-ID: <20181129203425.63544638@endymion>
In-Reply-To: <20181129192136.GA13749@kroah.com>
References: <20181129140058.768942700@linuxfoundation.org>
        <20181129140102.870510957@linuxfoundation.org>
        <1543502726.10991.13.camel@suse.de>
        <20181129150115.GA22451@kroah.com>
        <CF6A88132359CE47947DB4C6E1709ED53C551AF7@ORSMSX122.amr.corp.intel.com>
        <20181129192136.GA13749@kroah.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 20:21:37 +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 29, 2018 at 06:56:40PM +0000, Schmauss, Erik wrote:
> > This should only apply to 4.17 or later. I unintentionally put all applicable so
> > please drop this for all 4.16 or earlier. I've learned my lesson and I'll put the
> > correct tags from now on :-)  
> 
> Ok, now dropped from 4.14, thanks.

Should be dropped from 4.9 and 4.4 too... if it was not clear.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
