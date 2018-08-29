Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61637C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CF420652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CF420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeH3BMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:12:47 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:32781 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727595AbeH3BMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:12:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1343C182CED5B;
        Wed, 29 Aug 2018 21:14:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cork98_2357fcaf80142
X-Filterd-Recvd-Size: 1727
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Aug 2018 21:14:02 +0000 (UTC)
Message-ID: <b621a12258c3f0d0a9fcb61ac454af4822814e67.camel@perches.com>
Subject: Re: [PATCH 01/21] staging:rtl8192u: Rename AdvCoding - Style
From:   Joe Perches <joe@perches.com>
To:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Larry.Finger" <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Date:   Wed, 29 Aug 2018 14:14:01 -0700
In-Reply-To: <20180829203547.15650-2-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
         <20180829203547.15650-2-johnfwhitmore@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-29 at 21:35 +0100, John Whitmore wrote:
> Rename the bit field element AdvCoding, as it causes a checkpatch issue
> with CamelCase naming. As the element is not actually used in code it
> has been renamed to 'not_used_adv_coding'.
> 
> The single line of code which initialises the bit has been removed,
> as the  field is unused.
> 
> This is a purely coding style change which should have no impact
> on runtime code execution.

Hi John.

Other than the somewhat useful code style cleanups, is there
a point at which you will feel comfortable doing actual code
changes to this driver?

Perhaps support for the chipset could be converted to use
mac80211 and moved into the directory with the other realtek
drivers in drivers/net/wireless/realtek/rtl8xxxu/...

Larry?  What do you think?
