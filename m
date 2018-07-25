Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE4BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D31C20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D31C20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeGYHCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:02:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:44107 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeGYHCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:02:52 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiCj5-0007w6-O5; Wed, 25 Jul 2018 07:52:43 +0200
Received: from [2601:647:4601:b6c5::9c2f] (helo=localhost.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiCj5-000DAk-7Z; Wed, 25 Jul 2018 07:52:43 +0200
Subject: Re: [PATCH bpf-next] samples/bpf: xdpsock: order memory on AArch64
To:     Brian Brooks <brian.brooks@linaro.org>, ast@kernel.org,
        bjorn.topel@intel.com, magnus.karlsson@intel.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180724133337.20175-1-brian.brooks@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8ee462c0-3202-9416-4998-bfde2bbea5b3@iogearbox.net>
Date:   Wed, 25 Jul 2018 07:52:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180724133337.20175-1-brian.brooks@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24780/Wed Jul 25 02:42:30 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 03:33 PM, Brian Brooks wrote:
> Signed-off-by: Brian Brooks <brian.brooks@linaro.org>

Please respin with proper commit message instead of empty one.

Thanks,
Daniel
