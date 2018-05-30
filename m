Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-186052-1527710794-2-13910679208067585582
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527710793; b=g5bI2Rhg4wQf5N5xwtEHvJ3gPmaTDZtQ63Nm5jsPytpuJD8gpS
    SdmBebW3r27D0SagttpR98d27qug+BEnV5cjL1VRrRarRIbSPM/23YNKJjQQgQuz
    kzN9t4vMXFcKw3iUpCUO55eUFwXz5DedPqHyJgj8J4XHbWr1BmLgiUE9hcJSuD/o
    oD+gLcIiFYeu1PS0Ixj01lUjSssouE0x+gG36yeftzCFQUY3mSgMvswUVbTxLhMp
    ZmypCWmEtlLy2DaafysTP4nGGSf38HiydI20ZxKWSTvrfGz9aoc5gLK6I+XIwdwu
    AoGgRrZwWW+EhT4Qz483S+tEee4KsKBc18Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527710793; bh=zciRQeJ+LdrvLuXalTpm+GD8fJN3id
    PrSs9msKoLtEc=; b=NKk18ntdyVaaWTZbzvAXboK2JMiqCb2lwvxfMHRYZfIWrX
    1o+QgL/zpa/biCa+H+IEtjoCbfXayGGDHx/ZoAzEJJgxIFQLluF6/Ae0c8bZGPJr
    DX/ca6EWrQ31yS7bDPKtWuxCdIxdx3SLhYIPpTgZPSFxIKLMwK2H+GjBvLiB9RJg
    pjWKbpcvyUqf7sqwAhsOxebCloGDJyVvKU9LhoYxK35GTuouggXR4AhVfrKuaE5q
    M7otbDl9RffTP8MbZhETRRhUwCJWzsVcTALnA5pdduOa6ia77XT8I3hU2IObW4DM
    VdEDERqF47Rt77IjRVOHvckzIoCc7pXQ8Zb0iMJg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=uDc5gJB1 header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=uDc5gJB1 header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNe2UGvgLJuRjb8hysGuar5FiYgKuBccAP6HwiCcoryiY2CQHVqxSXbRxv9PD/1UXYovxx1NvZD9vulHu2fYKPIi9e4YKoXi8oIYaojm1DNyO5w/74BY
    6VIPaMJffJjq2y5t5OZxEO1P8mUg5quLKECWRpcVbmy53pxjkHE3OUPJMzUTgsOJ3RccZ+uWVpM9iZbFnyGMlS5OM/3YksjkSKOkN6vhVqSRIu6DLF6VWP7E
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=XYXJxzdxa0XuJ7vNzfwA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932149AbeE3UGa (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 16:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753718AbeE3UG3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 May 2018 16:06:29 -0400
Date: Wed, 30 May 2018 22:06:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: arnd@arndb.de, willy@infradead.org, geert@linux-m68k.org,
        linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] mm: PAGE_KERNEL_* fallbacks
Message-ID: <20180530200608.GA15435@kroah.com>
References: <20180510185507.2439-1-mcgrof@kernel.org>
 <20180516164403.GI27853@wotan.suse.de>
 <20180523213551.GF4511@wotan.suse.de>
 <20180530195500.GU4511@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530195500.GU4511@wotan.suse.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 30, 2018 at 09:55:00PM +0200, Luis R. Rodriguez wrote:
> On Wed, May 23, 2018 at 11:35:51PM +0200, Luis R. Rodriguez wrote:
> > On Wed, May 16, 2018 at 06:44:03PM +0200, Luis R. Rodriguez wrote:
> > > On Thu, May 10, 2018 at 11:55:05AM -0700, Luis R. Rodriguez wrote:
> > > > This is the 3rd iteration for moving PAGE_KERNEL_* fallback
> > > > definitions into asm-generic headers. Greg asked for a Changelog
> > > > for patch iteration changes, its below.
> > > > 
> > > > All these patches have been tested by 0-day.
> > > > 
> > > > Questions, and specially flames are greatly appreciated.
> > > 
> > > *Poke*
> > 
> > Greg, since this does touch the firmware loader as well, *poke*.
> 
> *Re-re-poke*

Hah, they are not for me to take, sorry, that's up to the mm maintainer.

good luck!

greg k-h
