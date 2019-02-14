Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A22921B18
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438041AbfBNV4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:56:14 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:36031 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfBNV4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:56:14 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 879E3240003;
        Thu, 14 Feb 2019 21:56:11 +0000 (UTC)
Date:   Thu, 14 Feb 2019 22:56:10 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Paul Hardwick <p.hardwick@option.com>
Subject: Re: [PATCH] tty/nozomi: use pci_iomap instead of ioremap_nocache
Message-ID: <20190214215610.GA9108@behemoth.owl.eu.com.local>
References: <20190210171212.GA22758@behemoth.owl.eu.com.local>
 <20190210214500.GB22758@behemoth.owl.eu.com.local>
 <20190212092625.GC27450@kroah.com>
 <20190212182555.GD2261@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212182555.GD2261@behemoth.owl.eu.com.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I will provide a patch if somebody is available to test it.

FTR, I have found test devices and should be able to run some tests by the
end of next week.

regards,
 Hugo

-- 
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C
