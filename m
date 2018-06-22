Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7759EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AD023F2A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AD023F2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeFVIqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:46:15 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:53090 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeFVIqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:46:14 -0400
Received: from cnzgrivvl-t440p.carpriv.carnet.hr ([161.53.12.131]:59816 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fWHho-0007r0-F2; Fri, 22 Jun 2018 10:46:08 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id 442E9239D8; Fri, 22 Jun 2018 10:46:08 +0200 (CEST)
Date:   Fri, 22 Jun 2018 10:46:08 +0200
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Marcus Wolf <marcus.wolf@smarthome-wolf.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <20180622084608.GT2412@gavran.carpriv.carnet.hr>
References: <20180605031120.GB1981@hle-laptop.local>
 <50c4e6ee-e5fb-1d27-4e73-1e82080036b3@smarthome-wolf.de>
 <20180622020345.GA1914@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622020345.GA1914@hle-laptop.local>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: Re: rf69_set_deviation in rf69.c (pi433 driver)
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 10:03:45PM -0400, Hugo Lefeuvre wrote:
> I'll prepare a patch addressing both issues. However I don't own test devices
> so it would be really great if you could test it !

I have two pi433 devices now so I should be able to tests things,
just let me know...

-- 
Valentin
