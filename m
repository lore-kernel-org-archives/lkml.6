Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBC9ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D72820779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D72820779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeJVP4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:56:07 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:37458 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727638AbeJVP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:56:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 04AEB181D341D;
        Mon, 22 Oct 2018 07:38:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brush55_867a69364222a
X-Filterd-Recvd-Size: 1517
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Oct 2018 07:38:44 +0000 (UTC)
Message-ID: <7c258019d4746325ac323bd6d49746ab3ea84066.camel@perches.com>
Subject: Re: Linux 4.19
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Oct 2018 00:38:43 -0700
In-Reply-To: <20181022073224.GA5658@kroah.com>
References: <20181022073224.GA5658@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 08:32 +0100, Greg KH wrote:

> Greg Kroah-Hartman (7):
>       Code of Conduct Interpretation: Add document explaining how the Code of Conduct is to be interpreted
>       Code of Conduct Interpretation: Properly reference the TAB correctly
>       Code of Conduct: Provide links between the two documents
>       Code of Conduct Interpretation: Put in the proper URL for the committee
>       Code of Conduct: Change the contact email address
>       MAINTAINERS: Add an entry for the code of conduct

Regardless of the number of acks that were given
to this patchset, I believe this was patch block
was not done in a public manner and so should not
have been applied within the single day after its
initial publication.


