Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932826AbeEaD3x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:29:53 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:56809 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932643AbeEaD3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:29:51 -0400
Subject: Re: [PATCH v3] selftests: cgroup/memcontrol: add basic test for
 socket accounting
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <1527019565-20470-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180528061845.GA4805@rapoport-lnx>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <46b8563c-912b-add4-8c56-625c738510fd@kernel.org>
Date: Wed, 30 May 2018 21:29:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528061845.GA4805@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 12:18 AM, Mike Rapoport wrote:
> Hi,
> 
> Are there any updates on this?
> 
> On Tue, May 22, 2018 at 11:06:05PM +0300, Mike Rapoport wrote:
>> The test verifies that when there is active TCP connection, the
>> memory.stat.sock and memory.current values are close.
>>
>> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
>> Acked-by: Roman Gushchin <guro@fb.com>
>> ---
>> v3 changes:
>> * added changelog

Now in linux-kselftest next for 4.18-rc1.

thanks,
-- Shuah
