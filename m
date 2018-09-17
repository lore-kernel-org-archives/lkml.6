Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBB5ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301D1214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301D1214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIQRPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:15:52 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:48271 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeIQRPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:15:52 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8F6BD300047F2;
        Mon, 17 Sep 2018 13:48:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 65DB0105E30; Mon, 17 Sep 2018 13:48:52 +0200 (CEST)
Date:   Mon, 17 Sep 2018 13:48:52 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Chris Mason <clm@fb.com>, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Olof Johansson <olof@lxom.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180917114852.hzo36b2fewdzqc4t@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 12:22:43PM -0700, Linus Torvalds wrote:
> The one change that stands out and merits mention is the code of
> conduct addition...
[...]
> +Scope
> +=====
> +
> +This Code of Conduct applies both within project spaces and in public spaces
> +when an individual is representing the project or its community. Examples of
> +representing a project or community include using an official project e-mail
> +address, posting via an official social media account, or acting as an appointed
> +representative at an online or offline event. Representation of a project may be
> +further defined and clarified by project maintainers.

Hm, this "applies ... when an individual is representing the project or its
community", and that's the case when e.g. "using an official project e-mail
address".

By that measure, the document seems to only apply to fellows and employees
of the Linux Foundation and noone else.

Why is that?  Were they the only ones misbehaving? ;-)

Seriously though, I read this to know what I need to be aware of but oddly
the language of this paragraph says it doesn't apply to me:  I'm not using
an official project e-mail address nor an official social media account,
nor has anyone appointed me as representative.  I can live with that, I'm
just wondering what the benefit of a document is that only seems to apply
to a tiny fraction of the community.  Has this CoC been discussed anywhere?
I'm not seeing it in the LKML or ksummit-discuss archive.

Thanks,

Lukas
