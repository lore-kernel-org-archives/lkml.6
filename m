Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751046AbeC0Gyo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:54:44 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:22292 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeC0Gyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:54:43 -0400
X-ME-Helo: [192.168.8.29]
X-ME-Auth: ZXJpYy52YWxldHRlNkB3YW5hZG9vLmZy
X-ME-Date: Tue, 27 Mar 2018 08:54:40 +0200
X-ME-IP: 86.214.204.162
Reply-To: eric.valette@free.fr
Subject: Re: Periodic Null pointer access with 4.14.29-30 (while using
 minidlna) in sendfile system call
References: <87f4360e-d118-651f-0724-c7f79a5d885b@free.fr>
 <2f7dab1f-82b2-2f8a-52b1-24a5e73d45d0@free.fr>
To: LKML <linux-kernel@vger.kernel.org>
From: Eric Valette <eric.valette@free.fr>
Organization: HOME
Message-ID: <346ede96-04a6-feed-ce5b-a05814f8277e@free.fr>
Date: Tue, 27 Mar 2018 08:54:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <2f7dab1f-82b2-2f8a-52b1-24a5e73d45d0@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/18 11:39 PM, Eric Valette wrote:
> On 3/25/18 11:07 PM, Eric Valette wrote:
>> Since a few kernels I get this error when streaming video to TV via 
>> minidlna:
> 
> Checked it started with at least 4.14.25. My older kern.log.2.gz file 
> says before first march I did not get this error. But I removed older 
> kernels from my /boot directory.
> 
> I usually update kernel regularly as they appear but sometime I have a 
> week or two delay. If this helps bisecting.


Opened bug 199211 in bugzilla. Other user have confirmed it and even 
proposed a possible explanation.

-- eric
