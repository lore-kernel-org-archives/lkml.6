Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C4C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDFD21762
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDFD21762
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeHHQFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:05:19 -0400
Received: from www62.your-server.de ([213.133.104.62]:52229 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeHHQFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:05:19 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fnOmG-0000KS-OA; Wed, 08 Aug 2018 15:45:28 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fnOmG-000GMJ-Iq; Wed, 08 Aug 2018 15:45:28 +0200
Subject: Re: [PATCH bpf-next 12/13] docs: net: Fix various minor typos
To:     Jonathan Corbet <corbet@lwn.net>, "Tobin C. Harding" <me@tobin.cc>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180801050908.29970-1-me@tobin.cc>
 <20180801050908.29970-13-me@tobin.cc>
 <76cf11bc-61b3-8068-5546-79d3ff3a58e9@iogearbox.net>
 <20180808014248.GF11191@eros> <20180808072310.4695cea4@lwn.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <99c50323-601e-91ea-cac3-98c1f381f9ac@iogearbox.net>
Date:   Wed, 8 Aug 2018 15:45:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180808072310.4695cea4@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24823/Wed Aug  8 10:42:17 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 03:23 PM, Jonathan Corbet wrote:
> On Wed, 8 Aug 2018 11:42:48 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
>> Thanks for doing such a careful review that you noticed this.  I'm
>> working on this more ATM and I've moved the document to use double
>> spaces between _all_ full stops.  Currently the document uses mostly
>> single spaces but there are some sections with double space.  The
>> internet tells me this is a 'style' issue not a rule.  And I've seen
>> single and double spacing in tree and do not know if one is favoured.
>>
>> Do you care? 
> 
> I'm not Daniel, but let me just say that, for docs in general, I'm
> absolutely uninterested in patches adjusting the number of spaces after
> periods.  It really doesn't matter one way or the other, and I don't think
> we benefit from that kind of churn.

Yep, agree.
