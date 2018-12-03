Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F425C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E978620851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E978620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLCKPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:15:34 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:55484 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeLCKPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:15:34 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1gTlFq-0002xa-3I; Mon, 03 Dec 2018 11:15:06 +0100
Date:   Mon, 3 Dec 2018 11:15:06 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniel Axtens <dja@axtens.net>,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Stefano Brivio <sbrivio@redhat.com>,
        Yonghong Song <yhs@fb.com>, Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC 15/15] net: replace **** with a hug
Message-ID: <20181203101506.GM30790@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniel Axtens <dja@axtens.net>,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Stefano Brivio <sbrivio@redhat.com>, Yonghong Song <yhs@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-16-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130192737.15053-16-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:27:24AM -0800, Jarkko Sakkinen wrote:
> In order to comply with the CoC, replace **** with a hug.

This is incorrect: The patch doesn't replace '****', but 'fuck' instead.

> -			/* Fuck, we are miserable poor guys... */
> +			/* Hug, we are miserable poor guys... */

I fail to see the benefit from doing that. If I wrote: "Hug you you
hugging hug", you would still find it offensive as long as you know what
"hug" is supposed to translate into. And if you don't, you'll soon find
out.

A more constructive approach to replacing "fuck this and that" than
simply applying 's/fuck/whatever/' would be to provide details what
exactly is so bad about this and that. Of course that's not possible
without considerable effort, unlike your approach which doesn't alter
what is written but merely which words are used for it.

Cheers, Phil
