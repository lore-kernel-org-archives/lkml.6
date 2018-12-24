Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB39C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C992173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeLXNIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:08:02 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:48138 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbeLXNIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:08:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 7AF2A1463;
        Mon, 24 Dec 2018 14:08:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pgIF-jPDGwRY; Mon, 24 Dec 2018 14:07:59 +0100 (CET)
Received: from function.home (2a01cb008832b6009eb6d0fffe88c3c7.ipv6.abo.wanadoo.fr [IPv6:2a01:cb00:8832:b600:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id BE26C1461;
        Mon, 24 Dec 2018 14:07:59 +0100 (CET)
Received: from samy by function.home with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gbPxe-0001F2-S9; Mon, 24 Dec 2018 14:07:58 +0100
Date:   Mon, 24 Dec 2018 14:07:58 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Daniel Smith <daniel.bazinga@gmail.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup <speakup@linux-speakup.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: speakup: Fix coding style
Message-ID: <20181224130758.h225z5xs327tcit7@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Daniel Smith <daniel.bazinga@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup <speakup@linux-speakup.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20181224101118.GA21642@dan-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181224101118.GA21642@dan-VirtualBox>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Smith, le lun. 24 déc. 2018 10:12:23 +0000, a ecrit:
> Replaced text ---help--- with help as per style check patch recommendation
> 
> Signed-off-by: Daniel <daniel.bazinga@gmail.com>

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
