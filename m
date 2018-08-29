Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC750C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70617206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70617206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeH2MXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:23:21 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:56208 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbeH2MXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:23:21 -0400
Received: from [2001:b68:ff:12::131] (port=58008 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fuvp6-0006Bl-0G; Wed, 29 Aug 2018 10:27:32 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id C8B3E20239; Wed, 29 Aug 2018 10:27:31 +0200 (CEST)
Date:   Wed, 29 Aug 2018 10:27:31 +0200
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Juergen Gross <jgross@suse.com>
Cc:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Message-ID: <20180829082731.GX26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <1701ccef-3ebb-973b-de32-059a8816d31c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701ccef-3ebb-973b-de32-059a8816d31c@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:16:09AM +0200, Juergen Gross wrote:
> Did you test whether it is okay to not change state in case the device
> is still online?

Not sure how to simulate that. Maybe using xl block-detach or something else?

-- 
Valentin
