Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5E8F6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA1C208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA1C208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935488AbeFMRdL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:33:11 -0400
Received: from smtp121.ord1d.emailsrvr.com ([184.106.54.121]:54647 "EHLO
        smtp121.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934979AbeFMRdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:33:10 -0400
Received: from smtp24.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp24.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 932BFA02EA;
        Wed, 13 Jun 2018 13:33:09 -0400 (EDT)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id ABCA1A020F;
        Wed, 13 Jun 2018 13:33:08 -0400 (EDT)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 13 Jun 2018 13:33:09 -0400
Subject: Re: [PATCH v4] staging: comedi: Improved readability of function
 comedi_nsamples_left.
To:     Chris Opperman <eklikeroomys@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <1528837793-11765-1-git-send-email-eklikeroomys@gmail.com>
 <20180613092955.vc5impf46prhcur7@mwanda> <20180613182643.GA14100@kerdev>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <ad590779-6e94-f6ea-cced-bcb76df2e90b@mev.co.uk>
Date:   Wed, 13 Jun 2018 18:33:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613182643.GA14100@kerdev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/18 19:26, Chris Opperman wrote:
> Hi Dan/Ian,
> 
> Noted your comments regarding additional text, thanks! Just curious whether
> the "scissors" format given at the link below is valid?
> 
> https://kernelnewbies.org/PatchTipsAndTricks
> 
> It is given as an alternative to placing additional text below the
> cut-off line.

I don't know.  Maybe?  I haven't seen it used before.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
