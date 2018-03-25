Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeCYVjx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 17:39:53 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:41564 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeCYVju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 17:39:50 -0400
X-ME-Helo: [192.168.8.29]
X-ME-Auth: ZXJpYy52YWxldHRlNkB3YW5hZG9vLmZy
X-ME-Date: Sun, 25 Mar 2018 23:39:49 +0200
X-ME-IP: 86.214.204.162
Reply-To: eric.valette@free.fr
Subject: Re: Periodic Null pointer access with 4.14.29-30 (while using
 minidlna) in sendfile system call
To: LKML <linux-kernel@vger.kernel.org>
References: <87f4360e-d118-651f-0724-c7f79a5d885b@free.fr>
From: Eric Valette <eric.valette@free.fr>
Organization: HOME
Message-ID: <2f7dab1f-82b2-2f8a-52b1-24a5e73d45d0@free.fr>
Date: Sun, 25 Mar 2018 23:39:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <87f4360e-d118-651f-0724-c7f79a5d885b@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/18 11:07 PM, Eric Valette wrote:
> Since a few kernels I get this error when streaming video to TV via 
> minidlna:

Checked it started with at least 4.14.25. My older kern.log.2.gz file 
says before first march I did not get this error. But I removed older 
kernels from my /boot directory.

I usually update kernel regularly as they appear but sometime I have a 
week or two delay. If this helps bisecting.

-- eric
