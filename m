Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D72CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588B92173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfBZQYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:24:53 -0500
Received: from www62.your-server.de ([213.133.104.62]:56848 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZQYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:24:53 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyfXH-0006gC-2t; Tue, 26 Feb 2019 17:24:51 +0100
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyfXG-000JQh-S4; Tue, 26 Feb 2019 17:24:50 +0100
Subject: Re: [PATCH] bpf: decrease usercnt if bpf_map_new_fd() fails in
 bpf_map_get_fd_by_id()
To:     zerons <sironhide0null@gmail.com>, ast@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551190537-28694-1-git-send-email-sironhide0null@gmail.com>
 <564058e0-1432-676e-2f83-c8694911d8e5@iogearbox.net>
 <288b6db2-b14a-4f85-b89c-d873f0f6fcd8@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ba6710b8-a2c9-3557-3a03-14b74ccde5b8@iogearbox.net>
Date:   Tue, 26 Feb 2019 17:24:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <288b6db2-b14a-4f85-b89c-d873f0f6fcd8@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25372/Tue Feb 26 11:34:09 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/2019 03:58 PM, zerons wrote:
> On 2/26/19 22:44, Daniel Borkmann wrote:
>> On 02/26/2019 03:15 PM, zerons wrote:
>>> [ Upstream commit c91951f15978f1a0c6b65f063d30f7ea7bc6fb42 ]
>>
>> Thanks for the fix! What do you mean by "upstream commit" above in this context?
> 
> This patch is based on that commit, I thought I should mention this.
> Sorry for the confusion.

Ah, no. Usually that line is placed into stable commits that are
cherry-picked to point to the original commit sha in the mainline
tree. In any case, I didn't find c91951f15978, hence my question.
Anyway, for normal patch submissions in future, please don't add
it into the log, we'll remove it this time.

Thanks,
Daniel
