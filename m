Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030220AbeCAKH6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:07:58 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35509 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967425AbeCAKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:07:32 -0500
X-Google-Smtp-Source: AG47ELtNyCrwvC2j6tbQjUKaBCrHdYxkF0bkG4YYfVfZxFxLZpmoxMuQb7PQghSQpl//CjKUzc03nw==
Subject: Re: [PATCH V2] lightnvm: pblk: remove unused variable
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1519833444-28160-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <2cf2565b-0a2c-ecba-ea55-9a63591d8f93@lightnvm.io>
Date: Thu, 1 Mar 2018 11:07:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1519833444-28160-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 04:57 PM, Javier González wrote:
> # Changes since V1:
>   - Rebase on top of latest 2.0 changes
> 
> 
> Javier González (1):
>    lightnvm: pblk: remove unused variable
> 
>   drivers/lightnvm/pblk-core.c | 3 ---
>   1 file changed, 3 deletions(-)
> 

Okay if I merge this with Hans' patch? It has not gone upstream yet.
