Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122CAECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0C52145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0C52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJRGaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:30:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRGaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:30:12 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 73A5B3546;
        Wed, 17 Oct 2018 22:32:24 +0000 (UTC)
Date:   Wed, 17 Oct 2018 15:32:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-serial@vger.kernel.org, tj@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] serial: set suppress_bind_attrs flag only if
 builtin
Message-Id: <20181017153223.6c4e5156895dad7973f7d059@linux-foundation.org>
In-Reply-To: <e0763032-3ae6-b352-e586-ad131ce689ca@codeaurora.org>
References: <20181017140311.28679-1-anders.roxell@linaro.org>
        <20181017150546.0d451252950214bec74a6fc8@linux-foundation.org>
        <e0763032-3ae6-b352-e586-ad131ce689ca@codeaurora.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 16:21:08 -0600 Jeffrey Hugo <jhugo@codeaurora.org> wrote:

> On 10/17/2018 4:05 PM, Andrew Morton wrote:
> > On Wed, 17 Oct 2018 16:03:10 +0200 Anders Roxell <anders.roxell@linaro.org> wrote:
> > 
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > 
> > This should have Arnd's Signed-off-by: as well.
> 
> I'm just interested to know, why?

So that Arnd certifies that

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

and all the other stuff in Documentation/process/submitting-patches.rst
section 11!

Also, because section 12 says so :)  And that final sentence is, I
believe, appropriate.
