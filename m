Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nHLJlK4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14E7560290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeFFOST (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:18:19 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43712 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbeFFOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:18:17 -0400
X-Google-Smtp-Source: ADUXVKK8LqQqQpjxwAfKn/u1DFxGd4L5kKkw7JiOK9IaxbVkBOWry5ZaYwLP11m0misWsCJRlTHajQ==
Subject: Re: Block IO issue in kernel-v4.17
To: Kent Overstreet <kent.overstreet@gmail.com>,
        Li Wang <liwang@redhat.com>
Cc: Coly Li <colyli@suse.de>, hch@lst.de, darrick.wong@oracle.com,
        snitzer@redhat.com, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
 <20180606084105.GA10720@kmo-pixel>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
Date: Wed, 6 Jun 2018 08:18:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180606084105.GA10720@kmo-pixel>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/18 2:41 AM, Kent Overstreet wrote:
> On Wed, Jun 06, 2018 at 04:37:25PM +0800, Li Wang wrote:
>> Hi BIO experts,
>>
>> I catch this panic issue on some kind of arches(x86_64, ppc64,
>> ppc64le..), it seems the root cause is very probably from BIO changes
>> from kernel-4.17-rc7. Plz take a look.
> 
> That's the bioset changes, the fix is out and on its way in

It's already in mainline, since about lunch time yesterday.


-- 
Jens Axboe
