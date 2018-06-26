Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E652C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F86E268D1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F86E268D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934581AbeFZKW2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:22:28 -0400
Received: from www62.your-server.de ([213.133.104.62]:46956 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933990AbeFZKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:22:26 -0400
Received: from [62.203.87.61] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fXl7A-0002dR-Ak; Tue, 26 Jun 2018 12:22:24 +0200
Subject: Re: [PATCH v2] selftests: bpf: notification about privilege required
 to run test_lwt_seg6local.sh testing script
To:     Jeffrin Jose T <ahiliation@gmail.com>, ast@kernel.org,
        shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20180622214032.6527-1-ahiliation@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b10965e2-1187-2cc1-f51f-20a489a77d2d@iogearbox.net>
Date:   Tue, 26 Jun 2018 12:22:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180622214032.6527-1-ahiliation@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24697/Tue Jun 26 06:38:09 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/2018 11:40 PM, Jeffrin Jose T wrote:
> This test needs root privilege for it's successful execution.
> 
> This patch is atleast used to notify the user about the privilege
> the script demands for the  smooth execution of the test.
> 
> Signed-off-by: Jeffrin Jose T (Rajagiri SET) <ahiliation@gmail.com>

Applied to bpf, thanks Jeffrin!
