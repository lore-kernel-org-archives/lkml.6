Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeEVPo6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:44:58 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:34710 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbeEVPo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:44:57 -0400
Subject: Re: [PATCH] tc-testing: fix ip address in u32 test
To: Vlad Buslov <vladbu@mellanox.com>, linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net, lucasb@mojatatu.com, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, chrism@mellanox.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <1526661066-11138-1-git-send-email-vladbu@mellanox.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <a4185e7e-83d1-aa22-b4c7-831d264b3b96@kernel.org>
Date: Tue, 22 May 2018 09:44:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526661066-11138-1-git-send-email-vladbu@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 10:31 AM, Vlad Buslov wrote:
> Fix expected ip address to actually match configured ip address.
> Fix test to expect single matched filter.
> 
> Signed-off-by: Vlad Buslov <vladbu@mellanox.com>

I can get this into 4.18-rc1 unless there is a reason for this to go
through net tree.

thanks,
-- Shuah
