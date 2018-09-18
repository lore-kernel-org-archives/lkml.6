Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BD6ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EC1214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EC1214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbeIRVZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:25:16 -0400
Received: from www62.your-server.de ([213.133.104.62]:42015 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbeIRVZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:25:14 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1g2IIC-00082L-5A; Tue, 18 Sep 2018 17:52:00 +0200
Received: from [178.197.249.15] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g2IIB-000Mos-UO; Tue, 18 Sep 2018 17:52:00 +0200
Subject: Re: [PATCH bpf-next] samples/bpf: remove duplicated includes
To:     Y Song <ys114321@gmail.com>, yuehaibing@huawei.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <20180918014534.26128-1-yuehaibing@huawei.com>
 <CAH3MdRWv7AV3xDHpCLwiFV6hvDGedtUUODmpjju68aMqVkMA8A@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <978be6b0-64b1-a2a7-9641-194a9ab27f5f@iogearbox.net>
Date:   Tue, 18 Sep 2018 17:51:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAH3MdRWv7AV3xDHpCLwiFV6hvDGedtUUODmpjju68aMqVkMA8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24952/Tue Sep 18 15:13:17 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 06:48 AM, Y Song wrote:
> On Mon, Sep 17, 2018 at 6:46 PM YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> Remove duplicated includes.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Acked-by: Yonghong Song <yhs@fb.com>

Applied to bpf-next, thanks!
