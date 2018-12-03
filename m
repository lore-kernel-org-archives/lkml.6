Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FFEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 01:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38F720881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 01:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38F720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbeLCBoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 20:44:14 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39624 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLCBoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 20:44:13 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gTdHL-0000oW-PB; Mon, 03 Dec 2018 09:44:07 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gTdHK-0002jb-1H; Mon, 03 Dec 2018 09:44:06 +0800
Date:   Mon, 3 Dec 2018 09:44:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH v3] rhashtable: detect when object movement between
 tables might have invalidated a lookup
Message-ID: <20181203014405.ohmoljrgmrjis3qr@gondor.apana.org.au>
References: <87muqbtev6.fsf@notabene.neil.brown.name>
 <20181116055551.zxfydbpoicslsfkg@gondor.apana.org.au>
 <878t1tece0.fsf@notabene.neil.brown.name>
 <87pnuno479.fsf@notabene.neil.brown.name>
 <20181201084727.6mfh46yshxdoba4h@gondor.apana.org.au>
 <878t17o9js.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t17o9js.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 09:20:23AM +1100, NeilBrown wrote:
>
> I don't understand how this is relevant.

Thanks for the explanation, I had missed the double pointer part.
With that, I'm happy with this patch as it stands:

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
