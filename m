Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeEVPfp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:35:45 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:34731 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVPfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:35:41 -0400
Subject: Re: [PATCH] kselftest/cgroup: fix variable dereferenced before check
 warning
To: Roman Gushchin <guro@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180522101031.8451-1-guro@fb.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <351128a3-5bba-8cd2-6d8a-fcaf9c33e2f3@kernel.org>
Date: Tue, 22 May 2018 09:35:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522101031.8451-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 04:10 AM, Roman Gushchin wrote:
> cg_name(const char *root, const char *name) is always called with
> non-empty root and name arguments, so there is no sense in checking
> it in the function body (after using in strlen()).
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: linux-kselftest@vger.kernel.org


Thanks. I will queue this up for 4.18-rc1

-- Shuah
